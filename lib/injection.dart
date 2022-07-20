import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:meeting_app/data/datasource/activities_remote_data.dart';
import 'package:meeting_app/data/repsitories/activity_repository_impl.dart';
import 'package:meeting_app/domain/repositories/activity_repository.dart';
import 'package:meeting_app/domain/usecase/get_activities.dart';
import 'package:meeting_app/domain/usecase/get_all_activities.dart';
import 'package:meeting_app/domain/usecase/get_edit_activities.dart';
import 'package:meeting_app/domain/usecase/info_activities.dart';
import 'package:meeting_app/presenter/cubit/edit/edit_cubit.dart';
import 'package:meeting_app/presenter/cubit/info/info_cubit.dart';
import 'package:meeting_app/presenter/cubit/list/list_activities_cubit.dart';
import 'package:meeting_app/presenter/cubit/my_activities/my_activities_cubit.dart';

final locator = GetIt.instance;

init(){
  //repository
  locator.registerFactory<ActivityRepository>(() => ActivityRepositoryImpl(remoteDataImpl: locator()));

  //data source
  locator.registerFactory(() => ActivitiesRemoteDataImpl(client: locator()));

  //use case
  locator.registerFactory(() => GetActivities(repository: locator()));
  locator.registerFactory(() => InfoActivities(repository: locator()));
  locator.registerFactory(() => GetEditActivities(repository: locator()));
  locator.registerFactory(() => GetAllActivities(repository: locator()));

  //state management
  locator.registerFactory(() => ListActivitiesCubit(getActivities: locator()));
  locator.registerFactory(() => InfoCubit(infoActivities: locator()));
  locator.registerFactory(() => EditCubit(getEditActivities: locator()));
  locator.registerFactory(() => MyActivitiesCubit(getAllActivities: locator()));

  //external
  locator.registerFactory(() => Client());
}