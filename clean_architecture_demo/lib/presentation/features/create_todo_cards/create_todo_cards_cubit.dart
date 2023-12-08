import 'package:clean_architecture_demo/domain/entity/todo_entity.dart';
import 'package:clean_architecture_demo/domain/usecase/create_todo_usecase.dart';
import 'package:clean_architecture_demo/presentation/features/create_todo_cards/create_todo_cards_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateTodoCardsCubit extends Cubit<CreateTodoCardsState> {
  CreateTodoCardsCubit({
    required this.createTodoUseCase,
  }) : super(const CreateTodoCardIdle());

  final CreateTodoUseCase createTodoUseCase;

  void createTodoCard(String title, String description) async {
    emit(const CreateTodoCardInProgress());

    TodoEntity todoEntity = TodoEntity('', title, description, false);

    final result = await createTodoUseCase.execute(todoEntity);

    if (result.isRight) {
      emit(const CreateTodoCardSuccess());
    } else {
      emit(CreateTodoCardFailure(failure: result.left));
    }
  }
}
