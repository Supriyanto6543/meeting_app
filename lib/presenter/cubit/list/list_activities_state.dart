part of 'list_activities_cubit.dart';

@immutable
abstract class ListActivitiesState {}

class ListActivitiesInitial extends ListActivitiesState {}

class ListActivitiesLoaded extends ListActivitiesState {
  final List<Map<String, dynamic>> list;
  final List<Map<String, dynamic>> complete;
  final bool isOpen;
  final EnumStatus enumStatus;

  ListActivitiesLoaded({
    required this.list,
    required this.complete,
    this.isOpen = true,
    this.enumStatus = EnumStatus.loaded});

}

class ListActivitiesError extends ListActivitiesState {
  final String message;
  final List<Activities> list;

  ListActivitiesError({required this.message, required this.list});
}
