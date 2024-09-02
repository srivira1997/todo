import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/data/models/todo_model.dart';
import 'package:todo/data/repositories/todo_repository.dart';

abstract class ToDoEvent extends Equatable {
  const ToDoEvent();

  @override
  List<Object> get props => [];
}

class LoadToDos extends ToDoEvent {}

class AddToDo extends ToDoEvent {
  final ToDoModel todo;

  const AddToDo(this.todo);

  @override
  List<Object> get props => [todo];
}

class UpdateToDo extends ToDoEvent {
  final ToDoModel todo;

  const UpdateToDo(this.todo);

  @override
  List<Object> get props => [todo];
}

class DeleteToDo extends ToDoEvent {
  final ToDoModel todo;

  const DeleteToDo(this.todo);

  @override
  List<Object> get props => [todo];
}

abstract class ToDoState extends Equatable {
  const ToDoState();

  @override
  List<Object> get props => [];
}

class ToDoInitial extends ToDoState {}

class ToDoLoading extends ToDoState {}

class ToDoLoaded extends ToDoState {
  final List<ToDoModel> todos;

  const ToDoLoaded(this.todos);

  @override
  List<Object> get props => [todos];
}

class ToDoEmpty extends ToDoState {
  const ToDoEmpty();

  @override
  List<Object> get props => [];
}

class ToDoError extends ToDoState {
  final String message;

  const ToDoError(this.message);

  @override
  List<Object> get props => [message];
}

/* class ToDoBloc extends Bloc<ToDoEvent, ToDoState> {
  final ToDoRepository repository;

  ToDoBloc(this.repository) : super(ToDoLoading()) {
    on<LoadToDos>(_onLoadToDos);
    on<AddToDo>(_onAddToDo);
    on<UpdateToDo>(_onUpdateToDo);
    on<DeleteToDo>(_onDeleteToDo);
  }

  void _onLoadToDos(LoadToDos event, Emitter<ToDoState> emit) async {
    emit(ToDoLoading());
    try {
      final todos = await repository.getToDos();
      emit(ToDoLoaded(todos));
    } catch (e) {
      emit(ToDoError(e.toString()));
    }
  }

  void _onAddToDo(AddToDo event, Emitter<ToDoState> emit) async {
    if (state is ToDoLoaded) {
      await repository.addTask(task: event.todo);
      final updatedTodos = List<ToDoModel>.from((state as ToDoLoaded).todos)
        ..add(event.todo);

      emit(ToDoLoaded(updatedTodos));
    }
  }

  void _onUpdateToDo(UpdateToDo event, Emitter<ToDoState> emit) async {
    if (state is ToDoLoaded) {
      await repository.updateTask(task: event.todo);
      final updatedTodos = (state as ToDoLoaded).todos.map((todo) {
        return todo.id == event.todo.id ? event.todo : todo;
      }).toList();
      emit(ToDoLoaded(updatedTodos));
    }
  }

  void _onDeleteToDo(DeleteToDo event, Emitter<ToDoState> emit) async {
    if (state is ToDoLoaded) {
      await repository.dalateTask(task: event.todo);
      final updatedTodos = (state as ToDoLoaded).todos.toList();
      emit(ToDoLoaded(updatedTodos));
    }
  }
}
 */

class ToDoBloc extends Bloc<ToDoEvent, ToDoState> {
  ToDoBloc() : super(ToDoInitial()) {
    on<ToDoEvent>((event, emit) async {
      if (event is AddToDo) {
        emit(ToDoInitial());
        emit(ToDoLoading());
        await ToDoRepository.addTask(task: event.todo);
        final updatedTodos = await ToDoRepository.getToDos();
        emit(ToDoLoaded(
            updatedTodos..sort((a, b) => a.createdAt.compareTo(b.createdAt))));
      }

      if (event is LoadToDos) {
        emit(ToDoInitial());
        emit(ToDoLoading());
        try {
          final todos = await ToDoRepository.getToDos();
          if (todos.isNotEmpty) {
            emit(ToDoLoaded(
                todos..sort((a, b) => a.createdAt.compareTo(b.createdAt))));
          } else {
            emit(const ToDoEmpty());
          }
        } catch (e) {
          emit(ToDoError(e.toString()));
        }
      }
    });
  }
}
