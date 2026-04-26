// otp_mobile_view.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pollux/src/feature/auth/otp/bloc/otp_bloc.dart';

class OtpMobileViewPage extends StatefulWidget {
  /// Phone number passed from the login page
  final String phone;

  const OtpMobileViewPage({super.key, required this.phone});

  @override
  State<OtpMobileViewPage> createState() => _OtpMobileViewPageState();
}

class _OtpMobileViewPageState extends State<OtpMobileViewPage> {
  static const int _otpLength = 4;
  static const int _resendCooldown = 30; // seconds

  final List<TextEditingController> _controllers =
      List.generate(_otpLength, (_) => TextEditingController());
  final List<FocusNode> _focusNodes =
      List.generate(_otpLength, (_) => FocusNode());

  int _secondsRemaining = _resendCooldown;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
    // Auto-focus first box
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNodes[0].requestFocus();
    });
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() => _secondsRemaining = _resendCooldown);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        timer.cancel();
      } else {
        setState(() => _secondsRemaining--);
      }
    });
  }

  String get _currentOtp =>
      _controllers.map((c) => c.text).join();

  void _onChanged(String value, int index) {
    if (value.length == 1 && index < _otpLength - 1) {
      _focusNodes[index + 1].requestFocus();
    }
    // Auto-submit when all boxes filled
    if (_currentOtp.length == _otpLength) {
      _submitOtp();
    }
  }

  void _onKeyEvent(KeyEvent event, int index) {
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace &&
        _controllers[index].text.isEmpty &&
        index > 0) {
      _focusNodes[index - 1].requestFocus();
      _controllers[index - 1].clear();
    }
  }

  void _submitOtp() {
    if (_currentOtp.length < _otpLength) return;
    FocusScope.of(context).unfocus();
    context.read<OtpBloc>().add(
          OtpSubmitted(otp: _currentOtp, phone: widget.phone),
        );
  }

  void _resendOtp() {
    if (_secondsRemaining > 0) return;
    for (final c in _controllers) {
      c.clear();
    }
    _focusNodes[0].requestFocus();
    _startTimer();
    context.read<OtpBloc>().add(OtpResendRequested(phone: widget.phone));
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OtpBloc(),
      child: Scaffold(
        body: BlocListener<OtpBloc, OtpState>(
          listener: (context, state) {
            if (state.status == OtpStatus.success) {
              context.go('/home');
            }
          },
          child: BlocBuilder<OtpBloc, OtpState>(
            builder: (context, state) {
              final isLoading = state.status == OtpStatus.loading;
              final isResending = state.status == OtpStatus.resending;

              return Stack(
                fit: StackFit.expand,
                children: [
                  // Background
                  Image.asset(
                    'assets/image/download.jpg',
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF0D0D1A), Color(0xFF1A1A3E)],
                        ),
                      ),
                    ),
                  ),

                  // Dark overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.3),
                          Colors.black.withOpacity(0.88),
                        ],
                      ),
                    ),
                  ),

                  SafeArea(
                    child: Column(
                      children: [
                        // Back button
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

                        const Spacer(),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Container(
                            padding: const EdgeInsets.all(28),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(28),
                              border: Border.all(color: Colors.white24),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.4),
                                  blurRadius: 40,
                                  offset: const Offset(0, 20),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Header
                                const Text(
                                  'Verify OTP',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 28,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.55),
                                      fontSize: 14,
                                    ),
                                    children: [
                                      const TextSpan(
                                          text: 'Code sent to '),
                                      TextSpan(
                                        text: widget.phone,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 32),

                                // OTP Pin Boxes
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: List.generate(
                                    _otpLength,
                                    (index) => _OtpBox(
                                      controller: _controllers[index],
                                      focusNode: _focusNodes[index],
                                      isError:
                                          state.status == OtpStatus.failure,
                                      onChanged: (v) =>
                                          _onChanged(v, index),
                                      onKeyEvent: (e) =>
                                          _onKeyEvent(e, index),
                                    ),
                                  ),
                                ),

                                // Error message
                                if (state.status == OtpStatus.failure)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12),
                                    child: Text(
                                      state.message,
                                      style: const TextStyle(
                                        color: Colors.redAccent,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),

                                // Resend toast
                                if (state.status == OtpStatus.initial &&
                                    state.message.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12),
                                    child: Text(
                                      state.message,
                                      style: const TextStyle(
                                        color: Colors.greenAccent,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),

                                const SizedBox(height: 28),

                                // Verify button
                                SizedBox(
                                  width: double.infinity,
                                  height: 52,
                                  child: ElevatedButton(
                                    onPressed: isLoading ? null : _submitOtp,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor:
                                          const Color(0xFF1A1A2E),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(14),
                                      ),
                                      elevation: 0,
                                    ),
                                    child: isLoading
                                        ? const SizedBox(
                                            width: 22,
                                            height: 22,
                                            child: CircularProgressIndicator(
                                              color: Colors.black,
                                              strokeWidth: 2.5,
                                            ),
                                          )
                                        : const Text(
                                            'Verify',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                  ),
                                ),

                                const SizedBox(height: 16),

                                // Resend row
                                Center(
                                  child: isResending
                                      ? const SizedBox(
                                          width: 16,
                                          height: 16,
                                          child: CircularProgressIndicator(
                                            color: Colors.white54,
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : GestureDetector(
                                          onTap: _resendOtp,
                                          child: RichText(
                                            text: TextSpan(
                                              style: TextStyle(
                                                color: Colors.white
                                                    .withOpacity(0.55),
                                                fontSize: 13,
                                              ),
                                              children: [
                                                const TextSpan(
                                                    text: "Didn't receive it? "),
                                                TextSpan(
                                                  text: _secondsRemaining > 0
                                                      ? 'Resend in ${_secondsRemaining}s'
                                                      : 'Resend OTP',
                                                  style: TextStyle(
                                                    color: _secondsRemaining > 0
                                                        ? Colors.white38
                                                        : Colors.white,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 48),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Single OTP digit box
// ─────────────────────────────────────────────

class _OtpBox extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isError;
  final ValueChanged<String> onChanged;
  final ValueChanged<KeyEvent> onKeyEvent;

  const _OtpBox({
    required this.controller,
    required this.focusNode,
    required this.isError,
    required this.onChanged,
    required this.onKeyEvent,
  });

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: FocusNode(),
      onKeyEvent: onKeyEvent,
      child: SizedBox(
        width: 62,
        height: 62,
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          maxLength: 1,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          onChanged: onChanged,
          decoration: InputDecoration(
            counterText: '',
            filled: true,
            fillColor: Colors.white.withOpacity(0.12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: isError
                    ? Colors.redAccent
                    : Colors.white.withOpacity(0.2),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: isError
                    ? Colors.redAccent
                    : Colors.white.withOpacity(0.2),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: isError ? Colors.redAccent : Colors.white,
                width: 1.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}