import 'package:bloc/bloc.dart';
import 'package:cubit/app/pages/home/cubits/todo_states.dart';

class TodoCubit extends Cubit<TodoState> {
  final List<String> _todos = [];

  List<String> get todos => _todos;

  TodoCubit() : super(InitialToDoState());

  Future<void> addToDo({required String todo}) async {
    emit(LoadingTodoState());

    await Future.delayed(const Duration(milliseconds: 500));

    if (_todos.contains(todo)) {
      emit(ErrorTodoState('Você já adicionou esta tarefa'));
    } else {
      _todos.add(todo);
      emit(LoadedTodoState(_todos));
    }
  }

  Future<void> removeToDo({required int index}) async {
    emit(LoadingTodoState());

    await Future.delayed(const Duration(seconds: 1));

    _todos.removeAt(index);

    emit(LoadedTodoState(_todos));
  }
}
