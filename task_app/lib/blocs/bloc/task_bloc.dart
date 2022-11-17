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
      allTask: List.from(state.allTask)..add(event.task),
      removeTask: state.removeTask,
    ));
  }

  void _onUpdateTask(UpdateTask event, Emitter<TaskState> emit) {
    final state = this.state;
    final task = event.task;
    final int index = state.allTask.indexOf(task);
    List<Task> allTask = List.from(state.allTask)..remove(task);
    task.isDone == false
        ? allTask.insert(index, task.copyWith(isDone: true))
        : allTask.insert(index, task.copyWith(isDone: false));

    emit(TaskState(allTask: allTask, removeTask: state.removeTask));
  }

  void _onDeleteTask(DeleteTask event, Emitter<TaskState> emit) {
    final state = this.state;
    emit(TaskState(
        allTask: state.allTask,
        removeTask: List.from(state.removeTask)..remove(event.task)));
  }

  void _onRemoveTask(RemoveTask event, Emitter<TaskState> emit) {
    final state = this.state;
    emit(TaskState(
      allTask: List.from(state.allTask)..remove(event.task),
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
