import 'package:meeting_app/domain/entities/activities.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class ActivityRepository{
  Future<Result<Exception, List<Activities>>> getActivities(String type);
  Future<Result<Exception, List<Activities>>> getAllMyActivity();
  Future<Result<Exception, Activities>> getEditActivities(int id);
  Future<Result<Exception, Activities>> infoActivities(int id);
}