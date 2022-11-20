import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../models/task.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends HydratedBloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskState()) {
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<RemoveTask>(_onRemoveTask);
  }

  void _onAddTask(AddTask event, Emitter<TaskState> emit) {
    final state = this.state;
    emit(TaskState(
      pendingTask: List.from(state.pendingTask)..add(event.task),
      completedTask: state.completedTask,
      favoriteTask: state.favoriteTask,
      removeTask: state.removeTask,
    ));
  }

  void _onUpdateTask(UpdateTask event, Emitter<TaskState> emit) {
    final state = this.state;
    final task = event.task;

    List<Task> pendingTask = state.pendingTask;
    List<Task> completedTask = state.completedTask;
    task.isDone == false
        ? {
            pendingTask = List.from(pendingTask)..remove(task),
            completedTask = List.from(completedTask)
              ..insert(0, task.copyWith(isDone: true)),
          }
        : {
            completedTask = List.from(completedTask)..remove(task),
            pendingTask = List.from(pendingTask)
              ..insert(0, task.copyWith(isDone: false)),
          };

    emit(TaskState(
      pendingTask: pendingTask,
      completedTask: completedTask,
      favoriteTask: state.favoriteTask,
      removeTask: state.removeTask,
    ));
  }

  void _onDeleteTask(DeleteTask event, Emitter<TaskState> emit) {
    final state = this.state;
    emit(TaskState(
        pendingTask: state.pendingTask,
        completedTask: state.completedTask,
        favoriteTask: state.favoriteTask,
        removeTask: List.from(state.removeTask)..remove(event.task)));
  }

  void _onRemoveTask(RemoveTask event, Emitter<TaskState> emit) {
    final state = this.state;
    emit(TaskState(
      pendingTask: List.from(state.pendingTask)..remove(event.task),
      completedTask: List.from(state.completedTask)..remove(event.task),
      favoriteTask: List.from(state.favoriteTask)..remove(event.task),
      removeTask: List.from(state.removeTask)
        ..add(event.task.copyWith(isDeleted: true)),
    ));
  }

  @override
  TaskState? fromJson(Map<String, dynamic> json) {
    return TaskState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TaskState state) {
    return state.toMap();
  }
}
