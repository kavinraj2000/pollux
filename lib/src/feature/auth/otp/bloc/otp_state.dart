part of 'otp_bloc.dart';

enum OtpStatus { initial, loading, success, failure, resending }

final class OtpState extends Equatable {
  final OtpStatus status;
  final String message;
  final int timerSeconds;

  const OtpState({
    this.status = OtpStatus.initial,
    this.message = '',
    this.timerSeconds = 30,
  });

  bool get canResend => timerSeconds == 0 && status != OtpStatus.resending;

  OtpState copyWith({
    OtpStatus? status,
    String? message,
    int? timerSeconds,
  }) {
    return OtpState(
      status: status ?? this.status,
      message: message ?? this.message,
      timerSeconds: timerSeconds ?? this.timerSeconds,
    );
  }

  @override
  List<Object?> get props => [status, message, timerSeconds];
}