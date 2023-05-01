import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto/cubits/task_cubit.dart';
import 'package:proyecto/models/task.dart';

class AddTaskScreen extends StatefulWidget {
  static const String routeName = '/add';

  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _taskName;
  late DateTime _dueDate;
  late String _label;
  bool _isComplete = false;

  @override
  void initState() {
    super.initState();
    _dueDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar tarea'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Nombre de la tarea',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa el nombre de la tarea';
                }
                return null;
              },
              onSaved: (value) {
                _taskName = value!;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Etiqueta',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa una etiqueta';
                }
                return null;
              },
              onSaved: (value) {
                _label = value!;
              },
            ),
            Row(
              children: [
                const Text('Fecha de vencimiento: '),
                Text('${_dueDate.day}/${_dueDate.month}/${_dueDate.year}'),
                IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: _dueDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _dueDate = pickedDate;
                      });
                    }
                  },
                ),
              ],
            ),
            CheckboxListTile(
              title: const Text('Completada'),
              value: _isComplete,
              onChanged: (newValue) {
                setState(() {
                  _isComplete = newValue!;
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  final task = Task(
                    name: _taskName,
                    dueDate: _dueDate,
                    label: _label,
                    isComplete: _isComplete,
                  );
                  BlocProvider.of<TaskCubit>(context).addTask(task);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
