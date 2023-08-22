part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

abstract class Homeactionstate extends HomeState {}

class HomeNavigateToAddTaskstate extends Homeactionstate {}

class CheckboxClickedState extends Homeactionstate {}

class HomeOntapTAskState extends Homeactionstate {
  final TaskModel task;

  HomeOntapTAskState(this.task);
}

class HomeLoadingState extends HomeState {}

class HomeEmptyState extends HomeState {}

class HomeErrorState extends HomeState {}

class HomeLoadSuccessState extends HomeState {
  final List<TaskModel> tasklist;

  HomeLoadSuccessState(this.tasklist);
}

final class HomeInitial extends HomeState {}
