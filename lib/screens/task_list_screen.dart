import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto/cubits/task_cubit.dart';
import 'package:proyecto/models/task.dart';

class TaskListScreen extends StatelessWidget {
  static const String routeName = '/list';
  const TaskListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taskCubit = context.read<TaskCubit>();
    taskCubit.fetchTasks(); // Se obtienen las tareas al cargar la pantalla

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tareas'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/labels');
            },
            icon: const Icon(Icons.label),
          ),
        ],
      ),
      body: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          if (state is TaskInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TaskLoaded) {
            final tasks = state.tasks;
            if (tasks.isEmpty) {
              return const Center(
                child: Text('No hay tareas registradas aún'),
              );
            } else {
              return ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return ListTile(
                    title: Text(task.name),
                    subtitle: Text('Fecha de cumplimiento: ${task.dueDate}'),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          Text(task.label),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              task.isComplete = !task.isComplete;
                              taskCubit.updateTask(task);
                            },
                            icon: task.isComplete
                                ? const Icon(Icons.check_box)
                                : const Icon(Icons.check_box_outline_blank),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          } else {
            return const Center(
              child: Text('Error al cargar las tareas'),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
