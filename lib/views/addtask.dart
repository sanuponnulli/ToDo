import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc/bloc/task_adition_bloc.dart';
import 'package:todo/bloc/home_bloc/home_bloc.dart';
import 'package:todo/model/task_model.dart';
import 'package:todo/services/databaseservices.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskAditionBloc, TaskAditionState>(
        listener: (context, state) {
          if (state.runtimeType == TAskAdditionSucceessState) {
            if (mounted) {
              BlocProvider.of<HomeBloc>(context).add(HomeInitialEvant());
            }
            Navigator.of(context).pop();
          }
        },
        listenWhen: (previous, current) => current is TaskAditionStateAction,
        buildWhen: (previous, current) => current is! TaskAditionStateAction,
        builder: (context, State) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Add Task'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(labelText: 'Title'),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(labelText: 'Description'),
                  ),
                  const SizedBox(height: 32.0),
                  ElevatedButton(
                    onPressed: () {
                      _addTask();
                    },
                    child: const Text('Add Task'),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _addTask() async {
    final String title = _titleController.text;
    final String description = _descriptionController.text;

    if (title.isNotEmpty && description.isNotEmpty) {
      // Perform task addition logic, e.g., save to database or state
      // Reset the text fields after adding the task

      BlocProvider.of<TaskAditionBloc>(context).add(SubmitNewTaskEvent(
          TaskModel(title: title, description: description)));

      // Show a confirmation message or navigate back to the previous screen
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Task added successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please enter both title and description.')),
      );
    }
  }
}
