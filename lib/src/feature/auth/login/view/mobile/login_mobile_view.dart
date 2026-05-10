// login_mobile_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:pollux/app/route_name.dart';
import 'package:pollux/src/feature/auth/login/bloc/login_bloc.dart';

const _primary = Color(0xFFFF921C);
const _secondary = Color(0xFF015B5C);

class LoginMobileviewPage extends StatefulWidget {
  const LoginMobileviewPage({super.key});

  @override
  State<LoginMobileviewPage> createState() => _LoginMobileviewPageState();
}

class _LoginMobileviewPageState extends State<LoginMobileviewPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _secondary,
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.status == LoginStatus.success) {
            final phone =
                _formKey.currentState?.fields['phone']?.value as String? ?? '';
            context.push('/otp', extra: phone.trim());
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 40,
                        ),
                        child: ClipRRect(
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
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  blurRadius: 48,
                                  offset: const Offset(0, 24),
                                ),
                              ],
                            ),
                            child: FormBuilder(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Login',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 0.2,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Welcome back, please login to your account',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.72),
                                      fontSize: 13,
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  FormBuilderTextField(
                                    name: 'phone',
                                    keyboardType: TextInputType.phone,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(
                                        errorText: 'Phone number is required',
                                      ),
                                      FormBuilderValidators.minLength(
                                        7,
                                        errorText: 'Enter a valid phone number',
                                      ),
                                    ]),
                                    decoration: _glassDecoration(
                                      hint: 'Phone Number',
                                      icon: Icons.person_outline,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 52,
                                    child: ElevatedButton(
                                      onPressed:
                                          // state.status == LoginStatus.loading
                                          // ? null
                                          // :
                                          () {
                                            context.goNamed(RouteName.otp);
                                            // if (_formKey.currentState
                                            //         ?.saveAndValidate() ??
                                            //     false) {
                                            //   final phone =
                                            //       _formKey
                                            //               .currentState
                                            //               ?.fields['phone']
                                            //               ?.value
                                            //           as String? ??
                                            //       '';
                                            //   context.read<LoginBloc>().add(
                                            //     LoaddataEvent(
                                            //       phone: phone.trim(),
                                            //     ),
                                            //   );
                                            // }
                                          },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: _primary,
                                        foregroundColor: Colors.white,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            14,
                                          ),
                                        ),
                                      ),
                                      child: state.status == LoginStatus.loading
                                          ? const SizedBox(
                                              width: 22,
                                              height: 22,
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                                strokeWidth: 2.5,
                                              ),
                                            )
                                          : const Text(
                                              'Login',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w800,
                                                letterSpacing: 0.5,
                                              ),
                                            ),
                                    ),
                                  ),
                                  if (state.status == LoginStatus.failure)
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
                                  const SizedBox(height: 16),
                                  Center(
                                    child: RichText(
                                      text: TextSpan(
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.65),
                                          fontSize: 13,
                                        ),
                                        children: const [
                                          TextSpan(
                                            text: "Don't have an account? ",
                                          ),
                                          TextSpan(
                                            text: 'Signup',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          context.goNamed(RouteName.home);
                                        },
                                        child: Text(
                                          'Guest mode',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

InputDecoration _glassDecoration({
  required String hint,
  required IconData icon,
  IconData? suffixIcon,
}) {
  return InputDecoration(
    hintText: hint,
    hintStyle: TextStyle(color: Colors.white.withOpacity(0.45), fontSize: 14),
    prefixIcon: Icon(icon, color: Colors.white60, size: 20),
    suffixIcon: suffixIcon != null
        ? Icon(suffixIcon, color: Colors.white54, size: 20)
        : null,
    filled: true,
    fillColor: Colors.white.withOpacity(0.12),
    contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.white.withOpacity(0.25)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.white.withOpacity(0.25)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: _primary, width: 1.8),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.redAccent),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.redAccent, width: 1.4),
    ),
    errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 11),
  );
}
