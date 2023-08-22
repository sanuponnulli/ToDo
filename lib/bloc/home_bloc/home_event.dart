part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeInitialEvant extends HomeEvent {}

class AddbuttonClick extends HomeEvent {}

class OnTapTask extends HomeEvent {
  final TaskModel task;

  OnTapTask(this.task);
}

class OnCheckboxClicked extends HomeEvent {
  final TaskModel task;

  OnCheckboxClicked(this.task);
}

class OntaskdeleteEvent extends HomeEvent {
  final TaskModel task;

  OntaskdeleteEvent(this.task);
}
