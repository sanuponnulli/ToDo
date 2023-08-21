import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/model/task_model.dart';
import 'package:todo/services/databaseservices.dart';

part 'task_adition_event.dart';
part 'task_adition_state.dart';

class TaskAditionBloc extends Bloc<TaskAditionEvent, TaskAditionState> {
  TaskAditionBloc() : super(TaskAditionInitial()) {
    on<TakAdditionPAgeInitailEvent>(initialevent);
    on<SubmitNewTaskEvent>(submitnewtask);

    on<EditTaskEvent>(edittask);
  }

  FutureOr<void> submitnewtask(
      SubmitNewTaskEvent event, Emitter<TaskAditionState> emit) async {
    emit(TaskAdditionprocessing());

    await DatabaseHelper().addtask(event.task).then((value) {
      emit(TAskAdditionSucceessState());
    });
  }

  FutureOr<void> edittask(
      EditTaskEvent event, Emitter<TaskAditionState> emit) async {
    emit(TaskAdditionprocessing());

    await DatabaseHelper().updatetask(event.task).then((value) {
      emit(TAskAdditionSucceessState());
    });
  }

  FutureOr<void> initialevent(event, Emitter<TaskAditionState> emit) {
    emit(TaskAditionInitial());
  }
}
