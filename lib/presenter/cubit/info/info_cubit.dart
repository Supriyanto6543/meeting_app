import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meeting_app/common/constant.dart';
import 'package:meeting_app/domain/usecase/info_activities.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import '../../../common/custom_snackbar.dart';
import '../../../common/enum_status.dart';
import '../../../domain/entities/activities.dart';

part 'info_state.dart';

class InfoCubit extends Cubit<InfoState> {
  InfoCubit({required this.infoActivities}) : super(InfoInitial());

  final InfoActivities infoActivities;
  static final description = TextEditingController();
  static final scaffold = GlobalKey<ScaffoldState>();

  getInfoActivities(int id)async{
    final result = await infoActivities.execute(id);
    result.when((error) {
      emit(InfoError(message: error.toString(), enumStatus: EnumStatus.loaded));
    }, (success) {
      emit(InfoLoaded(activities: success, enumStatus: EnumStatus.loaded));
    });
  }

  updateComplete(int id)async{
    var my = state as InfoLoaded;
    emit(InfoLoaded(activities: my.activities, enumStatus: EnumStatus.loading));
    final request = await http.put(Uri.parse(Constant.baseUrl+Constant.completeItem),
        body: {'id': id.toString(), 'complete': '1'});
    final json = jsonDecode(request.body);

    if(json != ""){
      displaySnackbar(scaffold.currentContext!, "Activity mark as completed");
      emit(InfoLoaded(activities: my.activities, enumStatus: EnumStatus.loaded));
      description.clear();
    }else{
      emit(InfoLoaded(activities: my.activities, enumStatus: EnumStatus.loaded));
    }
  }
}
