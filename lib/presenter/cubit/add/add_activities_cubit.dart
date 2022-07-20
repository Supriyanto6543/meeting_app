import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meeting_app/common/constant.dart';
import 'package:meeting_app/common/custom_snackbar.dart';
import 'package:meeting_app/common/enum_status.dart';
import 'package:meta/meta.dart';
import 'dart:developer';
import 'package:http/http.dart' as http;

part 'add_activities_state.dart';

class AddActivitiesCubit extends Cubit<AddActivitiesState> {
  AddActivitiesCubit() : super(AddActivitiesLoaded(enumStatus: EnumStatus.loaded));

  static final scaffold = GlobalKey<ScaffoldState>();
  static final meetOrCalling = TextEditingController();
  static final type = TextEditingController();
  static final dates = TextEditingController();
  static final objective = TextEditingController();
  static final description = TextEditingController();

  clearField(){
    description.clear();
  }

  createActivities()async{
    if(meetOrCalling.text != "" && type.text != "" && dates.text != "" && objective.text != "" && description.text != ""){
      emit(AddActivitiesLoaded(enumStatus: EnumStatus.loading));
      final create = await http.post(Uri.parse(Constant.baseUrl+Constant.createItem),
          body: {
            'submit': 'submit',
            'activity_type': meetOrCalling.text,
            'institution': type.text,
            'objective': objective.text,
            'remarks': description.text,
            'dates': dates.text
          });
      final json = jsonDecode(create.body);
      if(json != ""){
        displaySnackbar(scaffold.currentContext!, "Succeed create meeting with ${type.text}");
        emit(AddActivitiesLoaded(enumStatus: EnumStatus.loaded));
        clearField();
      }else{
        emit(AddActivitiesLoaded(enumStatus: EnumStatus.loaded));
      }
    }else{
      displaySnackbar(scaffold.currentContext!, "Please input all field");
    }
  }
}
