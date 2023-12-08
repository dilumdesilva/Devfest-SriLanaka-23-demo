import 'package:clean_architecture_demo/data/network/failure.dart';
import 'package:clean_architecture_demo/domain/entity/todo_entity.dart';
import 'package:equatable/equatable.dart';

class TodoCardsState extends Equatable {
  final List<TodoEntity>? todoCards;
  final Failure? failure;

  const TodoCardsState({this.todoCards, this.failure});

  @override
  List<Object?> get props => [todoCards];
}

//Get Todo Cards
class GetTodoCardsInProgress extends TodoCardsState {
  const GetTodoCardsInProgress();
}

class GetTodoCardsSuccess extends TodoCardsState {
  const GetTodoCardsSuccess({super.todoCards});
}

class GetTodoCardsFailure extends TodoCardsState {
  const GetTodoCardsFailure({super.failure});
}

//Create Todo Card
class CreateTodoCardInProgress extends TodoCardsState {
  const CreateTodoCardInProgress();
}

class CreateTodoCardSuccess extends TodoCardsState {
  const CreateTodoCardSuccess();
}

class CreateTodoCardFailure extends TodoCardsState {
  const CreateTodoCardFailure({super.failure});
}

// Delete Todo Card
class DeleteTodoCardInProgress extends TodoCardsState {
  const DeleteTodoCardInProgress();
}

class DeleteTodoCardSuccess extends TodoCardsState {
  const DeleteTodoCardSuccess({super.todoCards});
}

class DeleteTodoCardFailure extends TodoCardsState {
  const DeleteTodoCardFailure({super.failure});
}

// Pin Todo Card
class PinTodoCardInProgress extends TodoCardsState {
  const PinTodoCardInProgress();
}

class PinTodoCardSuccess extends TodoCardsState {
  const PinTodoCardSuccess({super.todoCards});
}

class PinTodoCardFailure extends TodoCardsState {
  const PinTodoCardFailure({super.failure});
}
