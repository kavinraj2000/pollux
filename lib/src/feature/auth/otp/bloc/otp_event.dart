// otp_event.dart
part of 'otp_bloc.dart';

abstract class OtpEvent extends Equatable {
  const OtpEvent();

  @override
  List<Object?> get props => [];
}

class OtpSubmitted extends OtpEvent {
  final String otp;
  final String phone;

  const OtpSubmitted({required this.otp, required this.phone});

  @override
  List<Object?> get props => [otp, phone];
}

class OtpResendRequested extends OtpEvent {
  final String phone;

  const OtpResendRequested({required this.phone});

  @override
  List<Object?> get props => [phone];
}