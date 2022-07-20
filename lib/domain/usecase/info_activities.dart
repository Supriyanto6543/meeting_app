import 'package:meeting_app/domain/repositories/activity_repository.dart';
import 'package:multiple_result/multiple_result.dart';

import '../entities/activities.dart';

class InfoActivities {
  final ActivityRepository repository;

  InfoActivities({required this.repository});

  Future<Result<Exception, Activities>> execute(int id){
    return repository.infoActivities(id);
  }
}