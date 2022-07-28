import 'package:dartz/dartz.dart';
import 'package:to_do_task2/error_handling/failures.dart';
import 'package:to_do_task2/features/tasks/data/repo_impl/tasks_repo_impl.dart';
import 'package:to_do_task2/features/tasks/domain/entity/task.dart';
import 'package:to_do_task2/features/tasks/domain/use_case/use_case_general.dart';

class DeleteTaskUseCase extends UseCase<Unit, DeleteParameters> {
  final TasksRepoImpl _tasksRepo;

  DeleteTaskUseCase(this._tasksRepo);
  @override
  Future<Either<Failures, Unit>?> call(DeleteParameters parameters) async {
    return await _tasksRepo.deleteTask(parameters.entity);
  }
}

class DeleteParameters {
  final TaskEntity entity;

  DeleteParameters(this.entity);
}
