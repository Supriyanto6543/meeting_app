import 'package:bloc/bloc.dart';
import 'package:meeting_app/common/enum_status.dart';
import 'package:meeting_app/domain/usecase/get_all_activities.dart';
import 'package:meta/meta.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../domain/entities/activities.dart';

part 'my_activities_state.dart';

class MyActivitiesCubit extends Cubit<MyActivitiesState> {
  MyActivitiesCubit({required this.getAllActivities}) : super(MyActivitiesInitial());

  final GetAllActivities getAllActivities;
  static final controller = RefreshController();

  fetchAllMyActivities()async{
    emit(MyActivitiesLoaded(list: [], enumStatus: EnumStatus.loading));
    final result = await getAllActivities.execute();
    result.when((error) {
      emit(MyActivitiesError(message: error.toString(), enumStatus: EnumStatus.loaded));
    }, (success) {
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
      emit(MyActivitiesLoaded(list: result, enumStatus: EnumStatus.loaded));
      controller.refreshCompleted();
    });
  }

  sortingByDate({required bool sorting})async{
    emit(MyActivitiesLoaded(list: [], enumStatus: EnumStatus.loading));
    final result = await getAllActivities.execute();
    result.when((error) {
      emit(MyActivitiesError(message: error.toString(), enumStatus: EnumStatus.loaded));
    }, (success) {
      if(sorting){
        success.sort((a, b)=> a.whenActivities.compareTo(b.whenActivities));
      }else{
        success.sort((a, b)=> b.whenActivities.compareTo(a.whenActivities));
      }
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
      emit(MyActivitiesLoaded(list: result, enumStatus: EnumStatus.loaded, isNew: sorting));
      controller.refreshCompleted();
    });
  }

  onRefresh(){
    fetchAllMyActivities();
  }
}
