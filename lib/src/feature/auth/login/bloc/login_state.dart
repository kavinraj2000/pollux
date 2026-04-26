part of 'login_bloc.dart';

enum LoginStatus { initial, loading, success, failure }

class LoginState extends Equatable {
  final LoginStatus status;
  final String message;
  final String phonenum;

  const LoginState({this.status = LoginStatus.initial, this.message = '',this.phonenum = ''});

  factory LoginState.initial() {
    return LoginState(status: LoginStatus.initial);
  }

  LoginState copyWith({LoginStatus? status, String? message,String?phonenum}) {
    return LoginState(
      status: status ?? this.status,
      phonenum: phonenum ?? this.phonenum,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, message,phonenum];
}
