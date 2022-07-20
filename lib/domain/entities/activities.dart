import 'package:equatable/equatable.dart';

class Activities extends Equatable{
  Activities({
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

  @override
  // TODO: implement props
  List<Object?> get props => [
    id, activityType, institution,
    whenActivities, objective, remarks, complete];
}