part of 'info_cubit.dart';

@immutable
abstract class InfoState {}

class InfoInitial extends InfoState {}

class InfoLoaded extends InfoState {
  final Activities activities;
  final EnumStatus enumStatus;

  InfoLoaded({required this.activities, this.enumStatus = EnumStatus.loaded});
}

class InfoError extends InfoState{
  final String message;
  final EnumStatus enumStatus;

  InfoError({required this.message, this.enumStatus = EnumStatus.loaded});
}
