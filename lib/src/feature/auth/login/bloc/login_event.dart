part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoaddataEvent extends LoginEvent {
  final String phone;

  const LoaddataEvent({required this.phone});

}
