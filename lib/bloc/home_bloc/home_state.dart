part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

abstract class Homeactionstate extends HomeState {}

class HomeNavigateToAddTaskstate extends Homeactionstate {}

class HomeLoadingState extends HomeState {}

class HomeEmptyState extends HomeState {}

class HomeErrorState extends HomeState {}

class HomeLoadSuccessState extends HomeState {
  final List<TaskModel> tasklist;

  HomeLoadSuccessState(this.tasklist);
}

final class HomeInitial extends HomeState {}
