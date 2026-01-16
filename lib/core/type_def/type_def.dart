import 'package:aspira/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

typedef Result<T> = Future<Either<Failure, T>>;
