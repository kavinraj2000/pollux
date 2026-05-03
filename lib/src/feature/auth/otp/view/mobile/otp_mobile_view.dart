// otp_mobile_view.dart
import 'dart:async';
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

  bool _isSubmitting = false;

  int _seconds = 30;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _seconds = 30;
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds == 0) {
        timer.cancel();
      } else {
        setState(() => _seconds--);
      }
    });
  }

  String _getCurrentOtp() {
    final state = _formKey.currentState;
    if (state == null) return '';

    return List.generate(
      _otpLength,
      (i) => (state.fields['otp_$i']?.value as String?) ?? '',
    ).join();
  }

  void _submitOtp(String otp) {
    if (_isSubmitting) return;

    _isSubmitting = true;

    context.read<OtpBloc>().add(
      OtpSubmitted(
        otp: otp,
        phone: widget.phone,
      ),
    );
  }

  void _handleAutoSubmit() {
    final otp = _getCurrentOtp();

    if (otp.length == _otpLength && !_isSubmitting) {
      FocusScope.of(context).unfocus();
      _formKey.currentState?.save();
      _submitOtp(otp);
    }
  }

  void _handlePaste(String value) {
    if (value.length > 1) {
      final chars = value.split('');

      for (int i = 0; i < chars.length && i < _otpLength; i++) {
        _formKey.currentState?.fields['otp_$i']?.didChange(chars[i]);
      }

      _handleAutoSubmit();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<OtpBloc, OtpState>(
        listener: (context, state) {
          if (state.status != OtpStatus.loading) {
            _isSubmitting = false;
          }

          if (state.status == OtpStatus.success) {
            context.go('/home');
          }

          if (state.status == OtpStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }

          if (state.status == OtpStatus.resending) {
            _startTimer();
          }
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(color: _secondary),

            Container(
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
            ),

            BlocBuilder<OtpBloc, OtpState>(
              builder: (context, state) {
                final isLoading = state.status == OtpStatus.loading;
                final isResending = state.status == OtpStatus.resending;
                final isError = state.status == OtpStatus.failure;

                return SafeArea(
                  child: Stack(
                    children: [
                      Center(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(vertical: 80),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: _buildCard(
                              context,
                              isLoading,
                              isResending,
                              isError,
                              state,
                            ),
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(
    BuildContext context,
    bool isLoading,
    bool isResending,
    bool isError,
    OtpState state,
  ) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: Container(
        padding: const EdgeInsets.fromLTRB(24, 28, 24, 28),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.13),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: Colors.white.withOpacity(0.30),
            width: 1.2,
          ),
        ),
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

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  _otpLength,
                  (index) => _OtpBox(
                    name: 'otp_$index',
                    isError: isError,
                    onChanged: (val) {
                      _handlePaste(val ?? '');

                      if ((val?.length ?? 0) == 1 &&
                          index < _otpLength - 1) {
                        FocusScope.of(context).nextFocus();
                      }

                      if ((val?.isEmpty ?? true)) {
                        FocusScope.of(context).previousFocus();
                      }

                      _handleAutoSubmit();
                    },
                  ),
                ),
              ),

              const SizedBox(height: 28),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () {
                          final otp = _getCurrentOtp();
                          if (otp.length == _otpLength) {
                            _submitOtp(otp);
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primary,
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Verify'),
                ),
              ),

              const SizedBox(height: 16),

              Center(
                child: isResending
                    ? const CircularProgressIndicator()
                    : GestureDetector(
                        onTap: _seconds == 0
                            ? () {
                                _formKey.currentState?.reset();
                                context.read<OtpBloc>().add(
                                      OtpResendRequested(
                                        phone: widget.phone,
                                      ),
                                    );
                              }
                            : null,
                        child: Text(
                          _seconds == 0
                              ? "Resend OTP"
                              : "Resend in $_seconds s",
                          style: TextStyle(
                            color: _seconds == 0
                                ? Colors.white
                                : Colors.white54,
                          ),
                        ),
                      ),
              ),
            ],
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