import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollux/src/feature/auth/otp/bloc/otp_bloc.dart';
import 'package:pollux/src/feature/auth/otp/repo/otp_repo.dart';
import 'package:pollux/src/feature/auth/otp/view/mobile/otp_mobile_view.dart';

class OtpView extends StatelessWidget {
  const OtpView({super.key});


   @override
     Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtpBloc(repo: OtpRepo()),
      child: OtpMobileViewPage(phone: '1234567890',),
    );
  }
}