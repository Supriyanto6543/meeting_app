part of 'add_activities_cubit.dart';

@immutable
abstract class AddActivitiesState {}

class AddActivitiesInitial extends AddActivitiesState {}

class AddActivitiesLoaded extends AddActivitiesState {
  final EnumStatus enumStatus;

  AddActivitiesLoaded({this.enumStatus = EnumStatus.loaded});
}

class AddActivitiesError extends AddActivitiesState{
  final EnumStatus enumStatus = EnumStatus.error;

  AddActivitiesError({required EnumStatus enumStatus});
}
