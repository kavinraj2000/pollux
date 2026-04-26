import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollux/src/core/base/bloc/base_bloc.dart';
import 'package:pollux/src/core/base/view/mobile/base_mobile_view.dart';

class BaseView extends StatelessWidget {
  const BaseView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BaseBloc(),
      child: const BaseMobileView(),
    );
  }
}
