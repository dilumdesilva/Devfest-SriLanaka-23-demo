import 'package:clean_architecture_demo/domain/entity/todo_entity.dart';
import 'package:clean_architecture_demo/domain/usecase/delete_todo_usecase.dart';
import 'package:clean_architecture_demo/domain/usecase/get_todos_usecase.dart';
import 'package:clean_architecture_demo/domain/usecase/pin_todo_usecase.dart';
import 'package:clean_architecture_demo/presentation/features/view_todo_cards/todo_cards_state.dart';
import 'package:clean_architecture_demo/presentation/utils/todo_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoCardsCubit extends Cubit<TodoCardsState> {
  TodoCardsCubit(
      {required this.getTodosUseCase,
      required this.deleterTodoUseCase,
      required this.pinTodoUseCase})
      : super(const GetTodoCardsInProgress());

  final GetTodosUseCase getTodosUseCase;
  final DeleteTodoUseCase deleterTodoUseCase;
  final PinTodoUseCase pinTodoUseCase;

  var fetchedTodoCards = <TodoEntity>[];

  void getTodoCards() async {
    emit(const GetTodoCardsInProgress());
    final result = await getTodosUseCase.execute(null);

    if (result.isRight) {
      fetchedTodoCards = result.right;
      emit(GetTodoCardsSuccess(todoCards: result.right.sortByPinned()));
    } else {
      emit(GetTodoCardsFailure(failure: result.left));
    }
  }

  void deleteTodoCard(TodoEntity todoEntity) async {
    //emit(const DeleteTodoCardInProgress());
    final result = await deleterTodoUseCase.execute(todoEntity);

    if (result.right == true) {
      fetchedTodoCards.remove(todoEntity);
      emit(DeleteTodoCardSuccess(todoCards: fetchedTodoCards.sortByPinned()));
    } else {
      emit(DeleteTodoCardFailure(failure: result.left));
    }
  }

  void pinTodoCard(TodoEntity todoEntity) async {
    todoEntity.isPinned = !todoEntity.isPinned;
    emit(const PinTodoCardInProgress());
    final result = await pinTodoUseCase.execute(todoEntity);

    if (result.right == true) {
      emit(PinTodoCardSuccess(todoCards: fetchedTodoCards.sortByPinned()));
    } else {
      emit(PinTodoCardFailure(failure: result.left));
    }
  }
}
