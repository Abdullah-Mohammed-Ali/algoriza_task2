import 'package:dartz/dartz.dart';
import 'package:to_do_task2/error_handling/failures.dart';
import 'package:to_do_task2/features/tasks/data/repo_impl/tasks_repo_impl.dart';
import 'package:to_do_task2/features/tasks/domain/entity/task.dart';
import 'package:to_do_task2/features/tasks/domain/use_case/use_case_general.dart';

class CreateTaskUseCase extends UseCase<Unit, CreateParameters> {
  final TasksRepoImpl _tasksRepo;

  CreateTaskUseCase(this._tasksRepo);
  @override
  Future<Either<Failures, Unit?>?> call(CreateParameters parameters) async {
    return await _tasksRepo.createTask(parameters.entity);
  }
}

class CreateParameters {
  final TaskEntity entity;

  CreateParameters(this.entity);
}
