part of 'task_bloc.dart';

class TaskState extends Equatable {
  final List<Task> allTask;
  const TaskState({this.allTask = const <Task>[]});

  @override
  List<Object> get props => [allTask];

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'allTask': allTask.map((x) => x.toMap()).toList()});

    return result;
  }

  factory TaskState.fromMap(Map<String, dynamic> map) {
    return TaskState(
      allTask: List<Task>.from(map['allTask']?.map((x) => Task.fromMap(x))),
    );
  }
}
