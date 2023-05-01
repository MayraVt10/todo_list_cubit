import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:proyecto/screens/label_task_screen.dart';
import 'package:proyecto/screens/task_list_screen.dart';
import 'package:proyecto/screens/add_task_screen.dart';
import 'package:proyecto/models/task.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());

  void fetchTasks() {
    // Aquí se llamaría al backend para obtener las tareas
    final tasks = [
      Task(
          name: 'Comprar leche',
          dueDate: DateTime.now(),
          label: 'Compras',
          isComplete: false),
      Task(
          name: 'Llamar al médico',
          dueDate: DateTime.now().add(Duration(days: 1)),
          label: 'Salud',
          isComplete: false),
      Task(
          name: 'Terminar proyecto',
          dueDate: DateTime.now().add(Duration(days: 5)),
          label: 'Trabajo',
          isComplete: true),
    ];
    emit(TaskLoaded(tasks: tasks));
  }

  void addTask(Task task) {
    // Aquí se llamaría al backend para guardar la tarea
    emit(TaskAdded(task: task));
  }

  void updateTask(Task task) {
    // Aquí se llamaría al backend para actualizar la tarea
    emit(TaskUpdated(task: task));
  }

  void deleteTask(Task task) {
    // Aquí se llamaría al backend para eliminar la tarea
    emit(TaskDeleted(task: task));
  }

  void fetchLabels() {
    // Aquí se llamaría al backend para obtener las etiquetas
    final labels = ['Compras', 'Salud', 'Trabajo'];
    emit(LabelsLoaded(labels: labels));
  }

  void addLabel(String label) {
    // Aquí se llamaría al backend para guardar la etiqueta
    emit(LabelAdded(label: label));
  }

  void deleteLabel(String label) {
    // Aquí se llamaría al backend para eliminar la etiqueta
    emit(LabelDeleted(label: label));
  }
}
