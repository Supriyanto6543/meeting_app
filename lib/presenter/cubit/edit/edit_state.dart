part of 'edit_cubit.dart';

@immutable
abstract class EditState {}

class EditInitial extends EditState {}

class EditLoaded extends EditState {
  final Activities modelActivities;
  final EnumStatus enumStatus;

  EditLoaded({required this.modelActivities, this.enumStatus = EnumStatus.loaded});
}

class EditError extends EditState {
  final String message;
  EditError({required this.message});
}
