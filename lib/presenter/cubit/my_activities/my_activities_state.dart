part of 'my_activities_cubit.dart';

@immutable
abstract class MyActivitiesState {}

class MyActivitiesInitial extends MyActivitiesState {}

class MyActivitiesLoaded extends MyActivitiesState {
  final List<Map<String, dynamic>> list;
  final EnumStatus enumStatus;
  final bool isNew;

  MyActivitiesLoaded({required this.list, this.enumStatus = EnumStatus.loading, this.isNew = true});
}

class MyActivitiesError extends MyActivitiesState{
  final String message;
  final EnumStatus enumStatus;

  MyActivitiesError({required this.message, this.enumStatus = EnumStatus.loaded});
}
