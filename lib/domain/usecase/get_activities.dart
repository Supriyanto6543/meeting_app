import 'package:meeting_app/domain/repositories/activity_repository.dart';
import 'package:multiple_result/multiple_result.dart';

import '../entities/activities.dart';

class GetActivities{
  final ActivityRepository repository;

  GetActivities({required this.repository});

  Future<Result<Exception, List<Activities>>> execute(String type){
    return repository.getActivities(type);
  }
}