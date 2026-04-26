import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollux/src/feature/auth/login/bloc/login_bloc.dart';
import 'package:pollux/src/feature/auth/login/repo/login_repo.dart';
import 'package:pollux/src/feature/auth/login/view/mobile/login_mobile_view.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(repo: LoginRepo()),
      child: LoginMobileviewPage(),
    );
  }
}
