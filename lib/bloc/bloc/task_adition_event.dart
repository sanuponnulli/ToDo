part of 'task_adition_bloc.dart';

@immutable
sealed class TaskAditionEvent {}

class SubmitNewTaskEvent extends TaskAditionEvent {
  final TaskModel task;

  SubmitNewTaskEvent(this.task);
}

class EditTaskEvent extends TaskAditionEvent {
  final TaskModel task;

  EditTaskEvent(this.task);
}

class TakAdditionPAgeInitailEvent extends TaskAditionEvent {}
