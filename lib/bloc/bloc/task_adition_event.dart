part of 'task_adition_bloc.dart';

@immutable
sealed class TaskAditionEvent {}

class SubmitNewTaskEvent extends TaskAditionEvent {
  final TaskModel task;

  SubmitNewTaskEvent(this.task);
}
