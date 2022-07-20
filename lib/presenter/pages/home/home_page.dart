import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeting_app/common/constant.dart';
import 'package:meeting_app/common/custom_snackbar.dart';
import 'package:meeting_app/common/enum_status.dart';
import '../../../injection.dart' as di;
import 'package:intl/intl.dart';
import 'package:meeting_app/common/custom_color.dart';
import 'package:meeting_app/common/custom_font.dart';
import 'package:meeting_app/common/custom_size.dart';
import 'package:meeting_app/common/routes.dart';
import 'package:meeting_app/presenter/cubit/list/list_activities_cubit.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_)=> di.locator<ListActivitiesCubit>()..fetchActivities(isOpen: true, type: Constant.getAll),
      child: BlocBuilder<ListActivitiesCubit, ListActivitiesState>(builder: (context, state){
        if(state is ListActivitiesLoaded){
          return Scaffold(
              appBar: PreferredSize(
                  preferredSize: Size(MediaQuery.of(context).size.width, kToolbarHeight * 2.2),
                  child: Container(
                      color: Colors.indigo,
                      child: Column(
                        children: [
                          SizedBox(height: kToolbarHeight - 20,),
                          Text('Activities', style: CustomFont.fontTitleCard(
                              CustomColor.white, CustomSize.f19), textAlign: TextAlign.center,),
                          SizedBox(height: 10,),
                          Container(
                            padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                            height: kToolbarHeight * 1.2,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    context.read<ListActivitiesCubit>().onOpen();
                                  },
                                  child: Container(
                                    child: Text('Open', style: TextStyle(
                                        color: state.isOpen ? CustomColor.white : CustomColor.black,
                                        fontWeight: FontWeight.bold, fontSize: 17
                                    ),),
                                    decoration: BoxDecoration(
                                        color: !state.isOpen ? CustomColor.white : CustomColor.indigoColor,
                                        borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                        width: 1,
                                          color: !state.isOpen ? CustomColor.transparent : CustomColor.white
                                      )
                                    ),
                                    padding: EdgeInsets.only(left: 40, right: 40, top: 10, bottom: 10),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    context.read<ListActivitiesCubit>().onComplete();
                                  },
                                  child: Container(
                                    child: Text('Complete', style: TextStyle(
                                        color: state.isOpen ? CustomColor.black : CustomColor.white,
                                        fontWeight: FontWeight.bold, fontSize: 17
                                    ),),
                                    decoration: BoxDecoration(
                                        color: !state.isOpen ? CustomColor.indigoColor : CustomColor.white,
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                            width: 1,
                                            color: !state.isOpen ? CustomColor.white : CustomColor.transparent
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
              floatingActionButton: FloatingActionButton(
                backgroundColor: CustomColor.indigoColor,
                onPressed: (){
                  Navigator.pushNamed(context, Routes.addActivities);
                },
                child: Icon(Icons.add, color: CustomColor.white,),
              ),
              body: bodyContent(context, state)
          );
        }
        return Center(child: CircularProgressIndicator(),);
      }),
    );
  }
  
  Widget bodyContent(BuildContext context, ListActivitiesLoaded state){
    if(state.isOpen == true){
      if(state.enumStatus == EnumStatus.loading){
        return Center(child: CircularProgressIndicator(),);
      }else if(state.enumStatus == EnumStatus.loaded){
        if(state.list.isNotEmpty){
          return Container(
              child: SmartRefresher(
                controller: ListActivitiesCubit.controller,
                onRefresh: context.read<ListActivitiesCubit>().onRefresh,
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
                                      Navigator.pushNamed(context, Routes.infoActivities, arguments: int.tryParse(dates['id']));
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
                                              padding: EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 20),
                                              decoration: BoxDecoration(
                                                  color: CustomColor.indigoColor.withOpacity(0.5),
                                                  borderRadius: BorderRadius.circular(10)
                                              ),
                                              child: Text('${dates['activity_type']} with ${dates['institution']}', style: CustomFont.fontTitleCard(
                                                  CustomColor.white, CustomSize.f15), textAlign: TextAlign.start,),
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
          );
        }else{
          return Center(
            child: Text('No data yet'),
          );
        }
      }
      return SizedBox.shrink();
    }else{
      if(state.enumStatus == EnumStatus.loading){
        return Center(child: CircularProgressIndicator(),);
      }else if(state.enumStatus == EnumStatus.loaded){
        if(state.complete.isNotEmpty){
          return Container(
              child: SmartRefresher(
                controller: ListActivitiesCubit.controllerComplete,
                onRefresh: context.read<ListActivitiesCubit>().onRefresh,
                child: ListView.builder(
                    itemCount: state.complete.length,
                    shrinkWrap: true,
                    itemBuilder: (context, i){
                      DateTime dt = DateTime.parse(state.complete[i]['when_activities']);
                      String dateIndo = DateFormat("EEEE, d MMMM yyyy","id").format(dt);
                      List<Map<String, dynamic>> date = state.complete[i]['Date'];
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
                                      displaySnackbar(context, "This activity have been completed, can\'t see detail");
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
                                              padding: EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 20),
                                              decoration: BoxDecoration(
                                                  color: CustomColor.indigoColor.withOpacity(0.5),
                                                  borderRadius: BorderRadius.circular(10)
                                              ),
                                              child: Text('${dates['activity_type']} with ${dates['institution']}', style: CustomFont.fontTitleCard(
                                                  CustomColor.white, CustomSize.f15), textAlign: TextAlign.start,),
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
          );
        }else{
          return Center(
            child: Text('No data yet'),
          );
        }
      }
      return SizedBox.shrink();
    }
  }
}
