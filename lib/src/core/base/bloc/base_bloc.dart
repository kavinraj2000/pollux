import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'base_event.dart';
part 'base_state.dart';

class BaseBloc extends Bloc<BaseEvent, BaseState> {
  BaseBloc() : super(const BaseState()) {
    on<ScrollOffsetChanged>(_onScrollOffsetChanged);
  }

  void _onScrollOffsetChanged(
    ScrollOffsetChanged event,
    Emitter<BaseState> emit,
  ) {
    emit(state.copyWith(scrollOffset: event.offset));
  }
}