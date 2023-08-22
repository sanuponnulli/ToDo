import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/model/task_model.dart';
import 'package:todo/services/databaseservices.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvant>(homeinitialevent);
    // on<HomeEvent>((event, emit) {
    //   // TODO: implement event handler
    // });
    on<AddbuttonClick>(addbuttonclicked);

    on<OnTapTask>(ontaptask);

    on<OnCheckboxClicked>(oncheckboxclicked);

    on<OntaskdeleteEvent>(ontaskdelete);
  }

  FutureOr<void> addbuttonclicked(
      AddbuttonClick event, Emitter<HomeState> emit) async {
    emit(HomeNavigateToAddTaskstate());
    log("addbuttonclicked");
  }

  FutureOr<void> homeinitialevent(
      HomeInitialEvant event, Emitter<HomeState> emit) async {
    log("Home Initial Called");
    emit(HomeLoadingState());
    await DatabaseHelper().fetchall().then((value) {
      if (value == null) {
        emit(HomeEmptyState());
      } else {
        emit(HomeLoadSuccessState(value));
      }
    });
  }

  FutureOr<void> ontaptask(OnTapTask event, Emitter<HomeState> emit) {
    emit(HomeOntapTAskState(event.task));
  }

  FutureOr<void> oncheckboxclicked(
      OnCheckboxClicked event, Emitter<HomeState> emit) async {
    final task = event.task;
    if (task.id == null) {
      return;
    }

    final result = await DatabaseHelper().updatetask(TaskModel(
        id: task.id,
        title: task.title,
        description: task.description,
        completed: task.completed == 0 ? 1 : 0));

    log("DB rESULT${result.toString()}");

    emit(CheckboxClickedState());
  }

  FutureOr<void> ontaskdelete(
      OntaskdeleteEvent event, Emitter<HomeState> emit) async {
    final task = event.task;
    if (task.id == null) {
      return;
    }

    final result = await DatabaseHelper().deletetask(TaskModel(
        id: task.id,
        title: task.title,
        description: task.description,
        completed: task.completed == 0 ? 1 : 0));

    log("DB rESULT${result.toString()}");

    emit(CheckboxClickedState());
  }
}
