part of 'base_bloc.dart';


abstract class BaseEvent extends Equatable {
  const BaseEvent();

  @override
  List<Object?> get props => [];
}

class ScrollOffsetChanged extends BaseEvent {
  final double offset;
  const ScrollOffsetChanged(this.offset);

  @override
  List<Object?> get props => [offset];
}