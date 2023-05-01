import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto/cubits/login_cubit.dart';
import 'package:proyecto/cubits/task_cubit.dart';
import 'package:proyecto/screens/add_task_screen.dart';
import 'package:proyecto/screens/login_screen.dart';
//import 'package:proyecto/screens/label_task_screen.dart';
import 'package:proyecto/screens/task_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => TaskCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'To-Do List',
        theme: ThemeData(
          primarySwatch: Colors.pink,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => LoginScreen(),
          '/list': (context) => TaskListScreen(),
          '/add': (context) => AddTaskScreen(),
          // '/label': (context) => LabelTaskScreen(),
        },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) => TaskListScreen(),
          );
        },
      ),
    );
  }
}
