import 'package:clean_architecture_demo/data/network/failure.dart';
import 'package:clean_architecture_demo/domain/entity/todo_entity.dart';
import 'package:clean_architecture_demo/domain/repository/todo_repository.dart';
import 'package:clean_architecture_demo/domain/usecase/usecase.dart';
import 'package:either_dart/either.dart';

class GetTodosUseCase implements UseCase<List<TodoEntity>, void> {
  final TodoRepository _todoRepository;

  GetTodosUseCase(this._todoRepository);

  @override
  Future<Either<Failure, List<TodoEntity>>> execute(void params) {
    return _todoRepository.getTodoList();
  }
}
