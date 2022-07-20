import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meeting_app/common/constant.dart';
import 'package:meeting_app/domain/entities/activities.dart';
import 'package:meeting_app/domain/usecase/get_activities.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'dart:developer';

import '../../../common/enum_status.dart';
part 'list_activities_state.dart';

class ListActivitiesCubit extends Cubit<ListActivitiesState> {
  ListActivitiesCubit({required this.getActivities}) : super(ListActivitiesInitial());

  final GetActivities getActivities;
  static final controller = RefreshController();
  static final controllerComplete = RefreshController();

  fetchActivities({required bool isOpen, required String type})async{
    emit(ListActivitiesLoaded(list: [], complete: [], isOpen: isOpen, enumStatus: EnumStatus.loading));
    final result = await getActivities.execute(type);
    result.when((error) {
      emit(ListActivitiesError(message: error.toString(), list: []));
    }, (success) async{
      success.sort((a, b)=>a.whenActivities.compareTo(b.whenActivities));
      final result = success.fold(<String, List<Activities>>{}, (Map<String, List<Activities>> a, b) {
        a.putIfAbsent(b.whenActivities.split(' ')[0], () => []).add(b);
        return a;
      }).values
          .where((l) => l.isNotEmpty)
          .map((l) => {
        'when_activities': l.first.whenActivities,
        'Date': l.map((e) => {
          'id': e.id,
          'activity_type': e.activityType,
          'institution': e.institution,
          'when_activities': e.whenActivities,
          'objective': e.objective,
          'remarks': e.remarks,
          'complete': e.complete
        }).toList()
      }).toList();
      emit(ListActivitiesLoaded(list: result, complete: [], isOpen: isOpen, enumStatus: EnumStatus.loaded));
      controller.refreshCompleted();
    });
  }

  fetchActivitiesComplete({required bool isOpen, required String type})async{
    emit(ListActivitiesLoaded(list: [], complete: [], isOpen: isOpen, enumStatus: EnumStatus.loading));
    final result = await getActivities.execute(type);
    result.when((error) {
      emit(ListActivitiesError(message: error.toString(), list: []));
    }, (success) async{
      success.sort((a, b)=>a.whenActivities.compareTo(b.whenActivities));
      final result = success.fold(<String, List<Activities>>{}, (Map<String, List<Activities>> a, b) {
        a.putIfAbsent(b.whenActivities.split(' ')[0], () => []).add(b);
        return a;
      }).values
          .where((l) => l.isNotEmpty)
          .map((l) => {
        'when_activities': l.first.whenActivities,
        'Date': l.map((e) => {
          'id': e.id,
          'activity_type': e.activityType,
          'institution': e.institution,
          'when_activities': e.whenActivities,
          'objective': e.objective,
          'remarks': e.remarks,
          'complete': e.complete
        }).toList()
      }).toList();
      emit(ListActivitiesLoaded(list: [], complete: result, isOpen: isOpen, enumStatus: EnumStatus.loaded));
      controllerComplete.refreshCompleted();
    });
  }

  onOpen(){
    fetchActivities(isOpen: true, type: Constant.getAll);
  }

  onComplete(){
    fetchActivitiesComplete(isOpen: false, type: Constant.getAllComplete);
  }

  onRefresh(){
    var myState = state as ListActivitiesLoaded;
    myState.isOpen ?
      fetchActivities(isOpen: myState.isOpen, type: Constant.getAll) :
      fetchActivitiesComplete(isOpen: myState.isOpen, type: Constant.getAllComplete);
  }
}
