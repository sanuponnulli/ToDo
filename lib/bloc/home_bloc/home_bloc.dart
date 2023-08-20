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
  }

  FutureOr<void> addbuttonclicked(
      AddbuttonClick event, Emitter<HomeState> emit) async {
    emit(HomeNavigateToAddTaskstate());
    log("addbuttonclicked");
  }

  FutureOr<void> homeinitialevent(
      HomeInitialEvant event, Emitter<HomeState> emit) async {
    log("message");
    emit(HomeLoadingState());
    await DatabaseHelper().fetchall().then((value) {
      if (value == null) {
        emit(HomeEmptyState());
      } else {
        emit(HomeLoadSuccessState(value));
      }
    });
  }
}
