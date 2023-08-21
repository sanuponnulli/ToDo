part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeInitialEvant extends HomeEvent {}

class AddbuttonClick extends HomeEvent {}

class OnTapTask extends HomeEvent {
  final TaskModel task;

  OnTapTask(this.task);
}
