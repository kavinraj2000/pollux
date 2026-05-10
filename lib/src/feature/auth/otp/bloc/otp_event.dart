part of 'otp_bloc.dart';

sealed class OtpEvent extends Equatable {
  const OtpEvent();

  @override
  List<Object?> get props => [];
}

final class OtpSubmitted extends OtpEvent {
  final String otp;
  final String phone;

  const OtpSubmitted({required this.otp, required this.phone});

  @override
  List<Object?> get props => [otp, phone];
}

final class OtpResendRequested extends OtpEvent {
  final String phone;

  const OtpResendRequested({required this.phone});

  @override
  List<Object?> get props => [phone];
}

final class OtpTimerTicked extends OtpEvent {
  final int remaining;

  const OtpTimerTicked(this.remaining);

  @override
  List<Object?> get props => [remaining];
}