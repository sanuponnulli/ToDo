import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc/bloc/task_adition_bloc.dart';
import 'package:todo/bloc/home_bloc/home_bloc.dart';
import 'package:todo/services/databaseservices.dart';
import 'package:todo/views/addtask.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Provide instances of your BLoCs here
        BlocProvider<HomeBloc>(
          create: (context) =>
              HomeBloc(), // Replace with your BLoC creation logic
        ),
        BlocProvider<TaskAditionBloc>(
          create: (context) =>
              TaskAditionBloc(), // Replace with your BLoC creation logic
        ),
        // Add more BlocProviders as needed...
      ],
      child: MaterialApp(
        title: 'Flutter ToDo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a blue toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const TodoHomeScreen(),
      ),
    );
  }
}

class TodoHomeScreen extends StatefulWidget {
  const TodoHomeScreen({super.key});

  @override
  State<TodoHomeScreen> createState() => _TodoHomeScreenState();
}

class _TodoHomeScreenState extends State<TodoHomeScreen> {
  @override
  void initState() {
    // TODO: implement initState

    BlocProvider.of<HomeBloc>(context).add(HomeInitialEvant());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      buildWhen: (previous, current) => current is! Homeactionstate,
      listenWhen: (previous, current) => current is Homeactionstate,
      listener: (context, state) {
        // log(state.runtimeType.toString());
        if (state.runtimeType == HomeNavigateToAddTaskstate) {
          // log("message  AddbuttonClick");
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddTaskScreen()));
        } else if (state.runtimeType == HomeOntapTAskState) {
          final cstate = state as HomeOntapTAskState;
          // log("message  AddbuttonClick");
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddTaskScreen(
                    task: cstate.task,
                  )));
        } else if (state.runtimeType == CheckboxClickedState) {
          BlocProvider.of<HomeBloc>(context).add(HomeInitialEvant());
        }
        // TODO: implement listener
      },
      builder: (context, state) {
        // log(state.toString());

        switch (state.runtimeType) {
          case (HomeLoadSuccessState || HomeEmptyState):
            // final e = state as HomeLoadSuccessState;
            // log("0 th element completed value ${e.tasklist[0].completed.toString()}");
            return Scaffold(
              appBar: AppBar(
                actions: [
                  GestureDetector(
                      onTap: () {
                        DatabaseHelper().cleartable();
                      },
                      child: Icon(Icons.delete))
                ],
                title: const Text('Todo List'),
              ),
              body: state.runtimeType == HomeEmptyState
                  ? const Center(
                      child: Text("Empty"),
                    )
                  : Builder(builder: (context) {
                      final st = state as HomeLoadSuccessState;
                      final list = st.tasklist;
                      return ListView.builder(
                        itemCount:
                            list.length, // Replace with your actual task count
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              if (mounted) {
                                BlocProvider.of<HomeBloc>(context)
                                    .add(OnTapTask(list[index]));
                              }
                            },
                            child: Dismissible(
                              direction: DismissDirection.startToEnd,
                              key: Key(list[index].id.toString()),
                              onDismissed: (direction) {
                                BlocProvider.of<HomeBloc>(context)
                                    .add(OntaskdeleteEvent(list[index]));
                              },
                              child: Card(
                                elevation: 3,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 16),
                                child: ListTile(
                                  title: Text('Task ${list[index].title}',
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  subtitle: const Text(
                                      'Due Date: August 31, 2023',
                                      style: TextStyle(color: Colors.grey)),
                                  trailing: Checkbox(
                                    value: list[index].completed ==
                                        1, // Replace with your actual checkbox value
                                    onChanged: (bool? value) {
                                      BlocProvider.of<HomeBloc>(context)
                                          .add(OnCheckboxClicked(list[index]));
                                    },
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  BlocProvider.of<HomeBloc>(context).add(AddbuttonClick());
                  // Replace with your FAB onPressed logic
                },
                child: const Icon(Icons.add),
              ),
            );

          case HomeErrorState:
            return const Scaffold(body: Center(child: Text('Error')));
          default:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
        }
      },
    );
  }
}
