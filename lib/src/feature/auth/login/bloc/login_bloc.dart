import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:pollux/src/feature/auth/login/repo/login_repo.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepo repo;
  LoginBloc({required this.repo}) : super(LoginState.initial()) {
    on<LoaddataEvent>(_onLoadDataevent);
  }

  Future<void> _onLoadDataevent(
    LoaddataEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      await repo.sendotp(phone: event.phone);
      Logger().d('LoginBloc:LoaddataEvent::${event.phone}');
      emit(state.copyWith(status: LoginStatus.success));
    } catch (e) {
      Logger().e('LoginBloc:LoaddataEvent::error $e');
      emit(
        state.copyWith(
          status: LoginStatus.failure,
          message: 'Failed to send OTP. Please try again.',
        ),
      );
    }
  }
}
