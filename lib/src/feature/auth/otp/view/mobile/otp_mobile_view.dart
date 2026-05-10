import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:pollux/src/feature/auth/otp/bloc/otp_bloc.dart';

const _primary = Color(0xFFFF921C);
const _secondary = Color(0xFF015B5C);

class OtpMobileViewPage extends StatefulWidget {
  final String phone;

  const OtpMobileViewPage({super.key, required this.phone});

  @override
  State<OtpMobileViewPage> createState() => _OtpMobileViewPageState();
}

class _OtpMobileViewPageState extends State<OtpMobileViewPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  static const int _otpLength = 4;

  String _getCurrentOtp() {
    final fields = _formKey.currentState?.fields;
    if (fields == null) return '';
    return List.generate(
      _otpLength,
      (i) => (fields['otp_$i']?.value as String?) ?? '',
    ).join();
  }

  void _submitOtp(String otp) {
    context.read<OtpBloc>().add(
          OtpSubmitted(otp: otp, phone: widget.phone),
        );
  }

  void _tryAutoSubmit() {
    final otp = _getCurrentOtp();
    if (otp.length == _otpLength) {
      FocusScope.of(context).unfocus();
      _formKey.currentState?.save();
      _submitOtp(otp);
    }
  }

  void _handlePaste(String value) {
    if (value.length <= 1) return;

    final chars = value.split('');
    for (var i = 0; i < chars.length && i < _otpLength; i++) {
      _formKey.currentState?.fields['otp_$i']?.didChange(chars[i]);
    }
    _tryAutoSubmit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<OtpBloc, OtpState>(
        listener: (context, state) {
          if (state.status == OtpStatus.success) {
            context.go('/home');
          }

          if (state.status == OtpStatus.failure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            ColoredBox(color: _secondary),
            _buildGradientOverlay(),
            BlocBuilder<OtpBloc, OtpState>(
              builder: (context, state) => SafeArea(
                child: Stack(
                  children: [
                    Center(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(vertical: 80),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: _buildCard(context, state),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                        ),
                        onPressed: () => context.pop(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGradientOverlay() {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withOpacity(0.08),
            Colors.black.withOpacity(0.45),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, OtpState state) {
    final isLoading = state.status == OtpStatus.loading;
    final isResending = state.status == OtpStatus.resending;
    final isError = state.status == OtpStatus.failure;

    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.13),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: Colors.white.withOpacity(0.30),
            width: 1.2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 28),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Verify OTP',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 32),
                _buildOtpFields(context, isError),
                const SizedBox(height: 28),
                _buildVerifyButton(isLoading),
                const SizedBox(height: 16),
                _buildResendWidget(isResending, state),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOtpFields(BuildContext context, bool isError) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        _otpLength,
        (index) => _OtpBox(
          name: 'otp_$index',
          isError: isError,
          onChanged: (val) {
            _handlePaste(val ?? '');

            if ((val?.length ?? 0) == 1 && index < _otpLength - 1) {
              FocusScope.of(context).nextFocus();
            } else if (val?.isEmpty ?? true) {
              FocusScope.of(context).previousFocus();
            }

            _tryAutoSubmit();
          },
        ),
      ),
    );
  }

  Widget _buildVerifyButton(bool isLoading) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: isLoading
            ? null
            : () {
                final otp = _getCurrentOtp();
                if (otp.length == _otpLength) _submitOtp(otp);
              },
        style: ElevatedButton.styleFrom(backgroundColor: _primary),
        child: isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text('Verify'),
      ),
    );
  }

  Widget _buildResendWidget(bool isResending, OtpState state) {
    return Center(
      child: isResending
          ? const CircularProgressIndicator()
          : GestureDetector(
              onTap: state.canResend
                  ? () {
                      _formKey.currentState?.reset();
                      context
                          .read<OtpBloc>()
                          .add(OtpResendRequested(phone: widget.phone));
                    }
                  : null,
              child: Text(
                state.canResend
                    ? 'Resend OTP'
                    : 'Resend in ${state.timerSeconds} s',
                style: TextStyle(
                  color: state.canResend ? Colors.white : Colors.white54,
                ),
              ),
            ),
    );
  }
}

class _OtpBox extends StatelessWidget {
  final String name;
  final bool isError;
  final ValueChanged<String?> onChanged;

  const _OtpBox({
    required this.name,
    required this.isError,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 44,
      child: FormBuilderTextField(
        name: name,
        maxLength: 1,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onChanged: onChanged,
        validator: FormBuilderValidators.required(errorText: ''),
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: Colors.white.withOpacity(0.12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }
}