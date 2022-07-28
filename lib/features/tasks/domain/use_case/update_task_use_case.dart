import 'package:dartz/dartz.dart';
import 'package:to_do_task2/error_handling/failures.dart';
import 'package:to_do_task2/features/tasks/data/repo_impl/tasks_repo_impl.dart';
import 'package:to_do_task2/features/tasks/domain/entity/task.dart';
import 'package:to_do_task2/features/tasks/domain/use_case/use_case_general.dart';

class UpdateTaskUseCase extends UseCase<Unit, UpdateParameters> {
  final TasksRepoImpl _tasksRepo;

  UpdateTaskUseCase(this._tasksRepo);
  @override
  Future<Either<Failures, Unit?>?> call(UpdateParameters parameters) async {
    return await _tasksRepo.updateTask(parameters.entity);
  }
}

class UpdateParameters {
  final TaskEntity entity;

  UpdateParameters(this.entity);
}
