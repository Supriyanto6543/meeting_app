import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:meeting_app/common/constant.dart';
import '../models/model_activities.dart';
import 'dart:developer';

abstract class ActivitiesRemoteData{
  Future<List<ModelActivities>> getActivities(String type);
  Future<List<ModelActivities>> getAllMyActivities();
  Future<ModelActivities> infoActivities(int id);
  Future<ModelActivities> getEditDetail(int id);
}

class ActivitiesRemoteDataImpl implements ActivitiesRemoteData{

  final http.Client client;

  ActivitiesRemoteDataImpl({required this.client});

  @override
  Future<List<ModelActivities>> getActivities(String type) async{
    final request = await client.get(Uri.parse(Constant.baseUrl+type));
    final json = jsonDecode(request.body);
    List activities = json['activities'];

    if(activities != []){
      return activities.map((e) => ModelActivities.fromJson(e)).toList();
    }else{
      return [];
    }
  }

  @override
  Future<ModelActivities> infoActivities(int id) async{
    final request = await client.get(Uri.parse(Constant.baseUrl+Constant.getById+id.toString()));
    final json = jsonDecode(request.body);
    return ModelActivities.fromJson(json);
  }

  @override
  Future<ModelActivities> getEditDetail(int id) async {
    final request = await client.get(Uri.parse(Constant.baseUrl+Constant.getById+id.toString()));
    final json = jsonDecode(request.body);
    return ModelActivities.fromJson(json);
  }

  @override
  Future<List<ModelActivities>> getAllMyActivities() async {
    final request = await client.get(Uri.parse(Constant.baseUrl+Constant.getAllMyActivities));
    final json = jsonDecode(request.body);
    List activities = json['activities'];

    if(activities != []){
      return activities.map((e) => ModelActivities.fromJson(e)).toList();
    }else{
      return [];
    }
  }

}