part of 'task_bloc.dart';

class TaskState extends Equatable {
  final List<Task> allTask;
  final List<Task> removeTask;
  const TaskState(
      {this.allTask = const <Task>[], this.removeTask = const <Task>[]});

  @override
  List<Object> get props => [allTask, removeTask];

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'allTask': allTask.map((x) => x.toMap()).toList()});
    result.addAll({'removeTask': removeTask.map((x) => x.toMap()).toList()});

    return result;
  }

  factory TaskState.fromMap(Map<String, dynamic> map) {
    return TaskState(
      allTask: List<Task>.from(map['allTask']?.map((x) => Task.fromMap(x))),
      removeTask:
          List<Task>.from(map['removeTask']?.map((x) => Task.fromMap(x))),
    );
  }
}
