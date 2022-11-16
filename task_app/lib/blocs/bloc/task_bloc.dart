import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/task.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskState()) {
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
  }

  void _onAddTask(AddTask event, Emitter<TaskState> emit) {
    final state = this.state;
    emit(TaskState(
      allTask: List.from(state.allTask)..add(event.task),
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

    emit(TaskState(allTask: allTask));
  }

  void _onDeleteTask(DeleteTask event, Emitter<TaskState> emit) {}
}
