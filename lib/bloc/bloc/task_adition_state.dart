part of 'task_adition_bloc.dart';

@immutable
sealed class TaskAditionState {}

abstract class TaskAditionStateAction extends TaskAditionState {}

final class TaskAdditionprocessing extends TaskAditionState {}

final class TAskAdditionSucceessState extends TaskAditionStateAction {}

final class TAskAdditionFailureState extends TaskAditionStateAction {}

final class TaskAditionInitial extends TaskAditionStateAction {}
