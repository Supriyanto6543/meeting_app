import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:meeting_app/common/custom_font.dart';
import 'package:meeting_app/common/custom_size.dart';
import 'package:meeting_app/common/routes.dart';
import 'package:meeting_app/presenter/cubit/info/info_cubit.dart';
import '../../../common/enum_status.dart';
import '../../../injection.dart' as di;
import '../../../common/custom_color.dart';

class ActivityInfoPage extends StatelessWidget {
  const ActivityInfoPage({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: InfoCubit.scaffold,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight * 1.7),
        child: AppBar(
          centerTitle: true,
          leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios, color: CustomColor.white,),
          ),
          title: Text('Activity Info'),
          backgroundColor: Colors.indigo,
          elevation: 0,
        ),
      ),
      body: BlocProvider(create: (_)=> di.locator<InfoCubit>()..getInfoActivities(id),
        child: BlocBuilder<InfoCubit, InfoState>(builder: (context, state){
          if(state is InfoLoaded){
            DateTime dt = DateTime.parse(state.activities.whenActivities);
            String dateIndo = DateFormat("EEEE, d MMMM yyyy HH:mm","id").format(dt);
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      border: Border.all(color: CustomColor.black.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Details', style: CustomFont.fontTitleCard(CustomColor.black, CustomSize.f20),),
                        Text('${state.activities.activityType} with ${state.activities.institution} '
                            '$dateIndo to discuss about ${state.activities.objective}', style: CustomFont.fontTitleCard(
                            CustomColor.black.withOpacity(0.7), CustomSize.f15), textAlign: TextAlign.start,),
                        SizedBox(height: 12,),
                        GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(context, Routes.editActivities,
                                arguments: int.parse(state.activities.id));
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                color: CustomColor.indigoColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: EdgeInsets.only(top: 14, bottom: 14),
                              width: MediaQuery.of(context).size.width,
                              child: Text('Edit Activity', style: CustomFont.fontTitleCard(
                                  CustomColor.white, CustomSize.f15), textAlign: TextAlign.center,)
                          ),
                        )
                      ],
                    )
                  ),
                  SizedBox(height: 3,),
                  Container(
                    margin: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('What is the result?', style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17
                        )),
                        SizedBox(height: 10,),
                        Container(
                            decoration: BoxDecoration(
                                color: CustomColor.grey.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: CustomColor.black.withOpacity(0.3))
                            ),
                            padding: EdgeInsets.only(left: 10, right: 10),
                            width: MediaQuery.of(context).size.width,
                            child: TextField(
                              maxLines: 6,
                              decoration: InputDecoration(
                                  hintText: 'This area i set to optional'
                              ),
                              controller: InfoCubit.description,
                            )
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(15),
                    child: GestureDetector(
                      onTap: (){
                        context.read<InfoCubit>().updateComplete(id);
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            color: CustomColor.greenColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.only(top: 20, bottom: 20),
                          width: MediaQuery.of(context).size.width,
                          child: createActivities(state)
                      ),
                    ),
                  )
                ],
              ),
            );
          }
          return Center(child: CircularProgressIndicator(),);
        }),
      )
    );
  }

  Widget createActivities(InfoLoaded state){
    if(state.enumStatus == EnumStatus.loading){
      return Center(child: SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(color: CustomColor.white,),
      ),);
    }else if(state.enumStatus == EnumStatus.loaded){
      return Text('Complete Activity', style: CustomFont.fontTitleCard(
          CustomColor.white, CustomSize.f15), textAlign: TextAlign.center,);
    }else{
      return Text('Complete Activity', style: CustomFont.fontTitleCard(
          CustomColor.white, CustomSize.f15), textAlign: TextAlign.center,);
    }
  }
}
