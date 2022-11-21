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
    on<MarkFavorite>(_onMarkFavorite);
    on<EditTask>(_onEditTask);
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

  void _onMarkFavorite(MarkFavorite event, Emitter<TaskState> emit) {
    final state = this.state;
    List<Task> pendingTasks = state.pendingTask;
    List<Task> completedTasks = state.completedTask;
    List<Task> favoriteTasks = state.favoriteTask;
    if (event.task.isDone == false) {
      if (event.task.isFavorite == false) {
        var taskIndex = pendingTasks.indexOf(event.task);
        pendingTasks = List.from(pendingTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: true));
        favoriteTasks.insert(0, event.task.copyWith(isFavorite: true));
      } else {
        var taskIndex = pendingTasks.indexOf(event.task);
        pendingTasks = List.from(pendingTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: false));
        favoriteTasks.remove(event.task);
      }
    } else {
      if (event.task.isFavorite == false) {
        var taskIndex = completedTasks.indexOf(event.task);
        completedTasks = List.from(completedTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: true));
        favoriteTasks.insert(0, event.task.copyWith(isFavorite: true));
      } else {
        var taskIndex = completedTasks.indexOf(event.task);
        completedTasks = List.from(completedTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: false));
        favoriteTasks.remove(event.task);
      }
    }
    emit(TaskState(
      pendingTask: pendingTasks,
      completedTask: completedTasks,
      favoriteTask: favoriteTasks,
      removeTask: state.removeTask,
    ));
  }

  void _onEditTask(EditTask event, Emitter<TaskState> emit) {
    final state = this.state;
    List<Task> favouriteTasks = state.favoriteTask;
    if (event.oldTask.isFavorite == true) {
      favouriteTasks
        ..remove(event.oldTask)
        ..insert(0, event.newTask);
    }
    emit(
      TaskState(
        pendingTask: List.from(state.pendingTask)
          ..remove(event.oldTask)
          ..insert(0, event.newTask),
        completedTask: state.completedTask..remove(event.oldTask),
        favoriteTask: favouriteTasks,
        removeTask: state.removeTask,
      ),
    );
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
