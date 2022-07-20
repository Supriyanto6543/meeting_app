import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meeting_app/common/enum_status.dart';
import 'package:meeting_app/domain/entities/activities.dart';
import 'package:meeting_app/domain/usecase/get_edit_activities.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';
import '../../../common/constant.dart';
import '../../../common/custom_snackbar.dart';

part 'edit_state.dart';

class EditCubit extends Cubit<EditState> {
  EditCubit({required this.getEditActivities}) : super(EditInitial());

  final GetEditActivities getEditActivities;
  static final scaffold = GlobalKey<ScaffoldState>();
  static final meetOrCalling = TextEditingController();
  static final type = TextEditingController();
  static final dates = TextEditingController();
  static final objective = TextEditingController();
  static TextEditingController?  description;

  fetchEditDetail(int id)async{
    final result = await getEditActivities.execute(id);
    result.when((error) {
      emit(EditError(message: error.toString()));
    }, (success) {
      emit(EditLoaded(modelActivities: success));
      var states = state as EditLoaded;
      description = TextEditingController(text: states.modelActivities.remarks);
    });
  }

  updateEditActivity(int id)async{
    var myState = state as EditLoaded;
    emit(EditLoaded(modelActivities: myState.modelActivities, enumStatus: EnumStatus.loading));
    final create = await http.put(Uri.parse(Constant.baseUrl+Constant.updateItem),
        body: {
          'submit': 'submit',
          'activity_type': meetOrCalling.text,
          'institution': type.text,
          'objective': objective.text,
          'remarks': description!.text,
          'dates': dates.text,
          'id': id.toString()
        });
    final json = jsonDecode(create.body);
    if(json != ""){
      displaySnackbar(scaffold.currentContext!, "Succeed updated activities");
      emit(EditLoaded(modelActivities: myState.modelActivities, enumStatus: EnumStatus.loaded));
    }else{
      emit(EditLoaded(modelActivities: myState.modelActivities, enumStatus: EnumStatus.loaded));
    }
  }
}
