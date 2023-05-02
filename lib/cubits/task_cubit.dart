import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:proyecto/screens/label_task_screen.dart';
import 'package:proyecto/screens/task_list_screen.dart';
import 'package:proyecto/screens/add_task_screen.dart';
import 'package:proyecto/models/task.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());

  void fetchTasks() async {
    // Aquí se llamaría al backend para obtener las tareas
    final header = {
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJ3d3cudWNiLmVkdS5ibyIsIm5hbWUiOiJKdWFuIFBlcmV6IiwidHlwZSI6IkFVVEgiLCJleHAiOjE2ODMwMDY1MTgsInVzZXJJZCI6MTAwfQ.iGxJSOgwTuCJA2eYJ5P7c1EwX3LyHv6GtV34vqtUbsQ'
    };
    final url = Uri.parse('http://192.168.0.2:9999/api/v1/task');
    final response = await http.get(url, headers: header);
    if (response.statusCode == 200) {
      print('registros obtenidos');
      //print(json.decode(response.body)['code']);
      //print(task.name + ' ' + task.label);
      //Navigator.push(context, MaterialPageRoute(builder: (_) => TaskListScreen()));
      //emit(true);
    } else {
      print('registros no obtenidos');
      //emit(false);
    }

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

  void addTask(Task task) async {
    final body = {
      'description': task.name,
      'date': "2019-01-01T00:00:00Z",
      'labelIds': [task.label],
    };
    print(task.name + ' ' + task.label + ' ' + task.dueDate.toString() + ' ');
    final header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJ3d3cudWNiLmVkdS5ibyIsIm5hbWUiOiJKdWFuIFBlcmV6IiwidHlwZSI6IkFVVEgiLCJleHAiOjE2ODMwMDY1MTgsInVzZXJJZCI6MTAwfQ.iGxJSOgwTuCJA2eYJ5P7c1EwX3LyHv6GtV34vqtUbsQ'
    };
    final url = Uri.parse('http://192.168.0.2:9999/api/v1/task');
    final response =
        await http.post(url, headers: header, body: json.encode(body));
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(' tarea agregada');
      print(json.decode(response.body)['code']);
      print(task.name + ' ' + task.label);
      print(task.label);
      //Navigator.push(context, MaterialPageRoute(builder: (_) => TaskListScreen()));
      //emit(true);
    } else {
      print(' tarea fallido');
      //emit(false);
    }
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
