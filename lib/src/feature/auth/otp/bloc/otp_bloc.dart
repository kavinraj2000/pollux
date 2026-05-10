import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pollux/src/feature/auth/otp/repo/otp_repo.dart';

part 'otp_event.dart';
part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final OtpRepo repo;
  StreamSubscription<int>? _timerSubscription;

  OtpBloc({required this.repo}) : super(const OtpState()) {
    on<OtpSubmitted>(_onOtpSubmitted);
    on<OtpResendRequested>(_onOtpResendRequested);
    on<OtpTimerTicked>(_onTimerTicked);

    _startTimer();
  }

  void _startTimer() {
    _timerSubscription?.cancel();
    _timerSubscription = Stream.periodic(
      const Duration(seconds: 1),
      (tick) => 29 - tick,
    ).take(30).listen(
      (remaining) => add(OtpTimerTicked(remaining)),
    );
  }

  void _onTimerTicked(OtpTimerTicked event, Emitter<OtpState> emit) {
    emit(state.copyWith(timerSeconds: event.remaining));
  }

  Future<void> _onOtpSubmitted(
    OtpSubmitted event,
    Emitter<OtpState> emit,
  ) async {
    emit(state.copyWith(status: OtpStatus.loading));
    try {
      await repo.verifyOtp(phone: event.phone, otp: event.otp);
      emit(state.copyWith(status: OtpStatus.success));
    } on Exception {
      emit(state.copyWith(
        status: OtpStatus.failure,
        message: 'Invalid OTP. Please try again.',
      ));
    } catch (_) {
      emit(state.copyWith(
        status: OtpStatus.failure,
        message: 'Something went wrong. Please try again.',
      ));
    }
  }

  Future<void> _onOtpResendRequested(
    OtpResendRequested event,
    Emitter<OtpState> emit,
  ) async {
    emit(state.copyWith(status: OtpStatus.resending, timerSeconds: 30));
    try {
      // await repo.verifyOtp(phone: event.phone);
      emit(state.copyWith(
        status: OtpStatus.initial,
        message: 'OTP resent successfully.',
        timerSeconds: 30,
      ));
      _startTimer();
    } catch (_) {
      emit(state.copyWith(
        status: OtpStatus.failure,
        message: 'Failed to resend OTP.',
      ));
    }
  }

  @override
  Future<void> close() {
    _timerSubscription?.cancel();
    return super.close();
  }
}