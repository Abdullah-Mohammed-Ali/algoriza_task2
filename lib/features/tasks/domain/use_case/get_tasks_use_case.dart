import 'package:dartz/dartz.dart';
import 'package:to_do_task2/error_handling/failures.dart';
import 'package:to_do_task2/features/tasks/data/repo_impl/tasks_repo_impl.dart';
import 'package:to_do_task2/features/tasks/domain/entity/task.dart';
import 'package:to_do_task2/features/tasks/domain/use_case/use_case_general.dart';

class GetTasksUseCase extends UseCase<List<TaskEntity>, GetTasksParameters> {
  final TasksRepoImpl _tasksRepo;

  GetTasksUseCase(this._tasksRepo);
  @override
  Future<Either<Failures, List<TaskEntity>?>?> call(
      GetTasksParameters parameters) async {
    print(parameters.searchValue);
    print(parameters.searchFields);
    return await _tasksRepo.getTasks(
        parameters.searchFields, parameters.searchValue);
  }
}

class GetTasksParameters {
  final String searchFields;
  final dynamic searchValue;

  GetTasksParameters(this.searchFields, this.searchValue);
}
