import 'dart:io';

import 'package:meeting_app/data/datasource/activities_remote_data.dart';
import 'package:meeting_app/data/models/model_activities.dart';
import 'package:meeting_app/domain/entities/activities.dart';
import 'package:meeting_app/domain/repositories/activity_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class ActivityRepositoryImpl implements ActivityRepository {

  final ActivitiesRemoteDataImpl remoteDataImpl;

  ActivityRepositoryImpl({required this.remoteDataImpl});

  @override
  Future<Result<Exception, List<Activities>>> getActivities(String type) async {
    final result = await remoteDataImpl.getActivities(type);
    try{
      return Success(result.map((e) => e.toEntity()).toList());
    }on SocketException catch(e){
      return Error(Exception(e.toString()));
    }
  }

  @override
  Future<Result<Exception, Activities>> infoActivities(int id) async {
    final result = await remoteDataImpl.infoActivities(id);
    try{
      return Success(result.toEntity());
    }on SocketException catch(e){
      return Error(Exception(e.toString()));
    }
  }

  @override
  Future<Result<Exception, Activities>> getEditActivities(int id) async{
    final result = await remoteDataImpl.getEditDetail(id);
    try{
      return Success(result.toEntity());
    }on SocketException catch(e){
      return Error(Exception(e.toString()));
    }
  }

  @override
  Future<Result<Exception, List<Activities>>> getAllMyActivity() async {
    final result = await remoteDataImpl.getAllMyActivities();
    try{
      return Success(result.map((e) => e.toEntity()).toList());
    }on SocketException catch(e){
      return Error(Exception(e.toString()));
    }
  }

}