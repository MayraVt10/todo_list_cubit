part of 'task_cubit.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

class TaskInitial extends TaskState {}

class TaskLoaded extends TaskState {
  final List<Task> tasks;

  const TaskLoaded({required this.tasks});

  @override
  List<Object> get props => [tasks];
}

class TaskAdded extends TaskState {
  final Task task;

  const TaskAdded({required this.task});

  @override
  List<Object> get props => [task];
}

class TaskUpdated extends TaskState {
  final Task task;

  const TaskUpdated({required this.task});

  @override
  List<Object> get props => [task];
}

class TaskDeleted extends TaskState {
  final Task task;

  const TaskDeleted({required this.task});

  @override
  List<Object> get props => [task];
}

class LabelsLoaded extends TaskState {
  final List<String> labels;

  const LabelsLoaded({required this.labels});

  @override
  List<Object> get props => [labels];
}

class LabelAdded extends TaskState {
  final String label;

  const LabelAdded({required this.label});

  @override
  List<Object> get props => [label];
}

class LabelDeleted extends TaskState {
  final String label;

  const LabelDeleted({required this.label});

  @override
  List<Object> get props => [label];
}
