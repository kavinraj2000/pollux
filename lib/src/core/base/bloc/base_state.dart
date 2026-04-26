part of 'base_bloc.dart';

enum BaseStatus { initial, loading, loaded, failure }

class BaseState extends Equatable {
  final BaseStatus status;
  final String message;
  final double scrollOffset;

  const BaseState({
    this.status = BaseStatus.initial,
    this.message = '',
    this.scrollOffset = 0.0,
  });

  BaseState copyWith({
    BaseStatus? status,
    String? message,
    double? scrollOffset,
  }) {
    return BaseState(
      status: status ?? this.status,
      message: message ?? this.message,
      scrollOffset: scrollOffset ?? this.scrollOffset,
    );
  }

  @override
  List<Object?> get props => [status, message, scrollOffset];
}