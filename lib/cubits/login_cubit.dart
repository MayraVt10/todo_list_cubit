import 'dart:js';
import 'package:proyecto/screens/task_list_screen.dart';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:proyecto/models/task.dart';

class LoginCubit extends Cubit<bool> {
  LoginCubit() : super(false);
  //final String myValue;
  //LoginCubit(this.myValue) : super(credenciales('', '', '', ''));

  Future<void> submit(context, String usuario, String password) async {
    //emit(credenciales(" ", " ", " ", ""));
    // Aquí agregarías la lógica de autenticación
    // En este ejemplo, simplemente emite un estado de autenticación exitosa
    //final body = {'usuario': usuario, 'password': password};
    final body = jsonEncode({'username': usuario, 'password': password});
    final header = {'Content-Type': 'application/json'};
    final url = Uri.parse('http://192.168.0.2:9999/api/v1/auth/login');
    final response = await http.post(url, headers: header, body: body);
    if (response.statusCode == 200) {
      print(' Login exitoso x');
      print(json.decode(response.body)['code']);
      print(usuario + ' ' + password);

      if (json.decode(response.body)['code'] == "0000") {
        print(' Login exitoso');
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => TaskListScreen()));

        emit(true);
      }
      //Navigator.pushNamed(BuildContext context ,'/list');
    } else {
      print(' Login fallido');
      emit(false);
    }
  }
}
