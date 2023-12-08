import 'package:clean_architecture_demo/data/network/failure.dart';
import 'package:either_dart/either.dart';

abstract class UseCase<T, Params> {
  Future<Either<Failure, T>> execute(Params params);
}
