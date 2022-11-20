part of 'task_bloc.dart';

class TaskState extends Equatable {
  final List<Task> pendingTask;
  final List<Task> completedTask;
  final List<Task> favoriteTask;
  final List<Task> removeTask;
  const TaskState({
    this.pendingTask = const <Task>[],
    this.completedTask = const <Task>[],
    this.favoriteTask = const <Task>[],
    this.removeTask = const <Task>[],
  });

  @override
  List<Object> get props => [
        pendingTask,
        completedTask,
        favoriteTask,
        removeTask,
      ];

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'pendingTask': pendingTask.map((x) => x.toMap()).toList()});
    result.addAll(
        {'completedTask': completedTask.map((x) => x.toMap()).toList()});
    result
        .addAll({'favoriteTask': favoriteTask.map((x) => x.toMap()).toList()});
    result.addAll({'removeTask': removeTask.map((x) => x.toMap()).toList()});

    return result;
  }

  factory TaskState.fromMap(Map<String, dynamic> map) {
    return TaskState(
      pendingTask:
          List<Task>.from(map['pendingTask']?.map((x) => Task.fromMap(x))),
      completedTask:
          List<Task>.from(map['completedTask']?.map((x) => Task.fromMap(x))),
      favoriteTask:
          List<Task>.from(map['favoriteTask']?.map((x) => Task.fromMap(x))),
      removeTask:
          List<Task>.from(map['removeTask']?.map((x) => Task.fromMap(x))),
    );
  }
}
