import 'package:clean_architecture_demo/data/network/failure.dart';

class CreateTodoCardsState {
  final bool? isTodoCardCreationSuccess;
  final Failure? failure;

  const CreateTodoCardsState({this.isTodoCardCreationSuccess, this.failure});
}

//Create Todo Card
class CreateTodoCardIdle extends CreateTodoCardsState {
  const CreateTodoCardIdle();
}

class CreateTodoCardInProgress extends CreateTodoCardsState {
  const CreateTodoCardInProgress();
}

class CreateTodoCardSuccess extends CreateTodoCardsState {
  const CreateTodoCardSuccess();
}

class CreateTodoCardFailure extends CreateTodoCardsState {
  const CreateTodoCardFailure({super.failure});
}
