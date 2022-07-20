import 'package:equatable/equatable.dart';
import 'package:meeting_app/domain/entities/activities.dart';

class ModelActivities extends Equatable{
  ModelActivities({
    required this.id,
    required this.activityType,
    required this.institution,
    required this.whenActivities,
    required this.objective,
    required this.remarks,
    required this.complete
  });
  late final String id;
  late final String activityType;
  late final String institution;
  late final String whenActivities;
  late final String objective;
  late final String remarks;
  late final String complete;

  ModelActivities.fromJson(Map<String, dynamic> json){
    id = json['id'];
    activityType = json['activity_type'];
    institution = json['institution'];
    whenActivities = json['when_activities'];
    objective = json['objective'];
    remarks = json['remarks'];
    complete = json['complete'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['activity_type'] = activityType;
    data['institution'] = institution;
    data['when_activities'] = whenActivities;
    data['objective'] = objective;
    data['remarks'] = remarks;
    data['complete'] = complete;
    return data;
  }

  Activities toEntity() => Activities(
      id: id, activityType: activityType, institution: institution,
      whenActivities: whenActivities, objective: objective,
      remarks: remarks, complete: complete);

  @override
  // TODO: implement props
  List<Object?> get props => [
    id, activityType, institution,
    whenActivities, objective, remarks, complete];
}