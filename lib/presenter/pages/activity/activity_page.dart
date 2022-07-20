import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:meeting_app/common/enum_status.dart';
import 'package:meeting_app/domain/entities/activities.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import '../../../common/custom_color.dart';
import '../../../common/custom_font.dart';
import '../../../common/custom_size.dart';
import '../../../common/custom_snackbar.dart';
import '../../../common/routes.dart';
import '../../../injection.dart' as di;
import '../../cubit/my_activities/my_activities_cubit.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_)=> di.locator<MyActivitiesCubit>()..fetchAllMyActivities(),
      child: BlocBuilder<MyActivitiesCubit, MyActivitiesState>(builder: (context, state){
        if(state is MyActivitiesLoaded){
          if(state.enumStatus == EnumStatus.loading){
            return Scaffold(
              appBar: PreferredSize(
                  preferredSize: Size(MediaQuery.of(context).size.width, kToolbarHeight * 2.4),
                  child: Container(
                      color: Colors.indigo,
                      child: Column(
                        children: [
                          SizedBox(height: kToolbarHeight - 20,),
                          Text('My Activity', style: CustomFont.fontTitleCard(
                              CustomColor.white, CustomSize.f19), textAlign: TextAlign.center,),
                          SizedBox(height: 5,),
                          Text('Sorting by: ', style: CustomFont.fontTitleCard(
                              CustomColor.white, CustomSize.f15), textAlign: TextAlign.center,),
                          SizedBox(height: 5,),
                          Container(
                            padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                            height: kToolbarHeight * 1.2,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: (){

                                  },
                                  child: Container(
                                    child: Text('Newest', style: TextStyle(
                                        color: CustomColor.black,
                                        fontWeight: FontWeight.bold, fontSize: 17
                                    ),),
                                    decoration: BoxDecoration(
                                        color:CustomColor.white,
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                            width: 1,
                                            color: CustomColor.transparent
                                        )
                                    ),
                                    padding: EdgeInsets.only(left: 40, right: 40, top: 10, bottom: 10),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){

                                  },
                                  child: Container(
                                    child: Text('Oldest', style: TextStyle(
                                        color: CustomColor.black,
                                        fontWeight: FontWeight.bold, fontSize: 17
                                    ),),
                                    decoration: BoxDecoration(
                                        color:CustomColor.white,
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                            width: 1,
                                            color: CustomColor.transparent
                                        )
                                    ),
                                    padding: EdgeInsets.only(left: 40, right: 40, top: 10, bottom: 10),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                  )
              ),
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }else{
            if(state.list.isNotEmpty){
              return Scaffold(
                appBar: PreferredSize(
                  preferredSize: Size(MediaQuery.of(context).size.width, kToolbarHeight * 2.4),
                  child: Container(
                      color: Colors.indigo,
                      child: Column(
                        children: [
                          SizedBox(height: kToolbarHeight - 20,),
                          Text('My Activity', style: CustomFont.fontTitleCard(
                              CustomColor.white, CustomSize.f19), textAlign: TextAlign.center,),
                          SizedBox(height: 5,),
                          Text('Sorting by: ${state.isNew ? 'Newest' : 'Oldest'} ', style: CustomFont.fontTitleCard(
                              CustomColor.white, CustomSize.f15), textAlign: TextAlign.center,),
                          SizedBox(height: 5,),
                          Container(
                            padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                            height: kToolbarHeight * 1.2,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    context.read<MyActivitiesCubit>().sortingByDate(sorting: true);
                                  },
                                  child: Container(
                                    child: Text('Newest', style: TextStyle(
                                        color: CustomColor.black,
                                        fontWeight: FontWeight.bold, fontSize: 17
                                    ),),
                                    decoration: BoxDecoration(
                                        color:CustomColor.white,
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                            width: 1,
                                            color: CustomColor.transparent
                                        )
                                    ),
                                    padding: EdgeInsets.only(left: 40, right: 40, top: 10, bottom: 10),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    context.read<MyActivitiesCubit>().sortingByDate(sorting: false);
                                  },
                                  child: Container(
                                    child: Text('Oldest', style: TextStyle(
                                        color: CustomColor.black,
                                        fontWeight: FontWeight.bold, fontSize: 17
                                    ),),
                                    decoration: BoxDecoration(
                                        color:CustomColor.white,
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                            width: 1,
                                            color: CustomColor.transparent
                                        )
                                    ),
                                    padding: EdgeInsets.only(left: 40, right: 40, top: 10, bottom: 10),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                  )
                ),
                body: Container(
                    child: SmartRefresher(
                      controller: MyActivitiesCubit.controller,
                      onRefresh: context.read<MyActivitiesCubit>().onRefresh,
                      child: ListView.builder(
                          itemCount: state.list.length,
                          shrinkWrap: true,
                          itemBuilder: (context, i){
                            DateTime dt = DateTime.parse(state.list[i]['when_activities']);
                            String dateIndo = DateFormat("EEEE, d MMMM yyyy","id").format(dt);
                            List<Map<String, dynamic>> date = state.list[i]['Date'];
                            return Container(
                              margin: EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(dateIndo, style: CustomFont.fontTitleCard(CustomColor.black, CustomSize.f18),),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: date.length,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index){
                                        Map<String, dynamic> dates = date[index];
                                        DateTime dt = DateTime.parse(dates['when_activities']);
                                        String dateIndo = DateFormat("hh:mm").format(dt);
                                        return GestureDetector(
                                          onTap: (){
                                            if(dates['complete'] == "0"){
                                              Navigator.pushNamed(context, Routes.infoActivities, arguments: int.tryParse(dates['id']));
                                            }else{
                                              displaySnackbar(context, "This activity have been completed, can\'t see detail");
                                            }
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(color: CustomColor.black)
                                                )
                                            ),
                                            padding: EdgeInsets.only(top: 10, bottom: 10),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(dateIndo, style: CustomFont.fontTitleCard(
                                                    CustomColor.black, CustomSize.f15)),
                                                SizedBox(width: 10,),
                                                Expanded(
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width,
                                                    padding: EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 10),
                                                    decoration: BoxDecoration(
                                                        color: dates['complete'] == "0" ? CustomColor.indigoColor : CustomColor.indigoColor.withOpacity(0.5),
                                                        borderRadius: BorderRadius.circular(10)
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text('${dates['activity_type']} with ${dates['institution']}', style: CustomFont.fontTitleCard(
                                                            CustomColor.white, CustomSize.f15), textAlign: TextAlign.start,),
                                                        SizedBox(height: 10,),
                                                        dates['complete'] == "0" ? Container(
                                                          padding: EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(6),
                                                              color: CustomColor.grey
                                                          ),
                                                          child: Text('Open', style: CustomFont.fontTitleCard(CustomColor.white, CustomSize.f15),),
                                                        ) : Container(
                                                          padding: EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(6),
                                                              color: CustomColor.greenColor
                                                          ),
                                                          child: Text('Completed', style: CustomFont.fontTitleCard(CustomColor.white, CustomSize.f15),),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                  ),
                                ],
                              ),
                            );
                          }
                      ),
                    )
                ),
              );
            }else{
              return Center(
                child: Text('No data yet'),
              );
            }
          }
        }
        if(state is MyActivitiesInitial){

        }
        return Center(child: CircularProgressIndicator(),);
      }),
    );
  }
}
