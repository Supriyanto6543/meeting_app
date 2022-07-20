import 'package:meeting_app/domain/entities/activities.dart';
import 'package:meeting_app/domain/repositories/activity_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class GetAllActivities{
  final ActivityRepository repository;

  GetAllActivities({required this.repository});

  Future<Result<Exception, List<Activities>>> execute(){
    return repository.getAllMyActivity();
  }
}