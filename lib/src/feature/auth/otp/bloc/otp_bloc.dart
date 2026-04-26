// otp_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'otp_event.dart';
part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  OtpBloc() : super(const OtpState()) {
    on<OtpSubmitted>(_onOtpSubmitted);
    on<OtpResendRequested>(_onOtpResendRequested);
  }

  Future<void> _onOtpSubmitted(
    OtpSubmitted event,
    Emitter<OtpState> emit,
  ) async {
    emit(state.copyWith(status: OtpStatus.loading));
    try {
      // TODO: Replace with your actual OTP verification API call
      await Future.delayed(const Duration(seconds: 2));

      // Simulate success/failure
      if (event.otp == '1234') {
        emit(state.copyWith(status: OtpStatus.success));
      } else {
        emit(state.copyWith(
          status: OtpStatus.failure,
          message: 'Invalid OTP. Please try again.',
        ));
      }
    } catch (e) {
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
    emit(state.copyWith(status: OtpStatus.resending));
    try {
      // TODO: Replace with your actual resend OTP API call
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(
        status: OtpStatus.initial,
        message: 'OTP resent successfully.',
      ));
    } catch (e) {
      emit(state.copyWith(
        status: OtpStatus.failure,
        message: 'Failed to resend OTP.',
      ));
    }
  }
}