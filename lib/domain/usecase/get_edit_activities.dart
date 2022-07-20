import 'package:meeting_app/domain/repositories/activity_repository.dart';
import 'package:multiple_result/multiple_result.dart';

import '../entities/activities.dart';

class GetEditActivities{
  final ActivityRepository repository;

  GetEditActivities({required this.repository});

  Future<Result<Exception, Activities>> execute(int id){
    return repository.getEditActivities(id);
  }
}