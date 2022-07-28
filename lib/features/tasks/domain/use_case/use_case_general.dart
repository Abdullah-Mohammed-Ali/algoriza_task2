import 'package:dartz/dartz.dart';

import '../../../../error_handling/failures.dart';

abstract class UseCase<Type, Parameters> {
  Future<Either<Failures, Type?>?> call(Parameters parameters);
}
