import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:meeting_app/common/custom_color.dart';
import 'package:meeting_app/common/custom_font.dart';
import 'package:meeting_app/common/custom_size.dart';
import 'package:meeting_app/common/enum_status.dart';
import 'package:meeting_app/presenter/cubit/add/add_activities_cubit.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {

  var first = ['Meeting', 'Phone Call'];
  String? firstInitial;

  var second = ['CV Anugrah Jaya', 'CV Berjaya Santosa', 'CV Indonesia'];
  String? secondInitial;

  var four = ['New Order', 'Invoice', 'New Leads'];
  String? fourInitial;

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  bool isSelected = false;
  bool isSelectedTime = false;
  String? dateIndo, dateResult;
  String? timeIndo;
  DateTime? dt;

  @override
  Widget build(BuildContext context) {
    timeIndo = getTime(selectedTime);
    dateResult = DateFormat('yyyy-MM-dd').format(selectedDate);
    dateIndo = DateFormat("EEEE, d MMMM yyyy","id").format(selectedDate);
    AddActivitiesCubit.dates.text = ("${dateResult!} ${timeIndo!.split(' ')[0]}");
    return Scaffold(
      key: AddActivitiesCubit.scaffold,
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
          title: Text('New Activity'),
          backgroundColor: Colors.indigo,
          elevation: 0,
        ),
      ),
      body: BlocBuilder<AddActivitiesCubit, AddActivitiesState>(builder: (context, state){
        if(state is AddActivitiesLoaded){
          return Container(
            margin: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('What do you want to do?', style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17
                        )),
                        SizedBox(height: 10,),
                        Container(
                          decoration: BoxDecoration(
                              color: CustomColor.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: CustomColor.black.withOpacity(0.3))
                          ),
                          width: MediaQuery.of(context).size.width,
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: firstInitial,
                            hint: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Text('Meeting or Calling'),
                            ),
                            underline: Container(color: Colors.transparent),
                            icon: Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: Icon(Icons.arrow_drop_down_outlined),),
                            items: first.map<DropdownMenuItem<String>>((String e) {
                              return DropdownMenuItem(
                                value: e,
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Text(e),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? s){
                              setState((){
                                firstInitial = s!;
                                AddActivitiesCubit.meetOrCalling.text = firstInitial!;
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 25,),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Who do you want to meet/call?', style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17
                        )),
                        SizedBox(height: 10,),
                        Container(
                          decoration: BoxDecoration(
                              color: CustomColor.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: CustomColor.black.withOpacity(0.3))
                          ),
                          width: MediaQuery.of(context).size.width,
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: secondInitial,
                            hint: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Text('CV Anugrah Jaya'),
                            ),
                            underline: Container(color: Colors.transparent),
                            icon: Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: Icon(Icons.search),),
                            items: second.map<DropdownMenuItem<String>>((String e) {
                              return DropdownMenuItem(
                                value: e,
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Text(e),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? s){
                              setState((){
                                secondInitial = s!;
                                AddActivitiesCubit.type.text = secondInitial!;
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 25,),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('What do you want to meet/call CV Anugrah Jaya?', style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17
                        )),
                        SizedBox(height: 10,),
                        Container(
                          decoration: BoxDecoration(
                              color: CustomColor.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: CustomColor.black.withOpacity(0.3))
                          ),
                          padding: EdgeInsets.only(top: 16, bottom: 16, left: 12, right: 12),
                          width: MediaQuery.of(context).size.width,
                          child: GestureDetector(
                            onTap: (){
                              _selectDate(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(!isSelected ? 'dd-MM-yyyy HH:mm' :
                                '$dateIndo $timeIndo', style: CustomFont.fontTitleCard(
                                    CustomColor.grey, CustomSize.f15),),
                                Icon(Icons.date_range, color: CustomColor.grey,)
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 25,),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Why do you want to meet/call CV Anugrah Jaya?', style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17
                        )),
                        SizedBox(height: 10,),
                        Container(
                          decoration: BoxDecoration(
                              color: CustomColor.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: CustomColor.black.withOpacity(0.3))
                          ),
                          width: MediaQuery.of(context).size.width,
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: fourInitial,
                            hint: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Text('New Order, Invoice, New Leads'),
                            ),
                            underline: Container(color: Colors.transparent),
                            icon: Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: Icon(Icons.arrow_drop_down_outlined),),
                            items: four.map<DropdownMenuItem<String>>((String e) {
                              return DropdownMenuItem(
                                value: e,
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Text(e),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? s){
                              setState((){
                                fourInitial = s!;
                                AddActivitiesCubit.objective.text = fourInitial!;
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 25,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Could you describe it more detail?', style: TextStyle(
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
                            controller: AddActivitiesCubit.description,
                          )
                      )
                    ],
                  ),
                  SizedBox(height: 25,),
                  GestureDetector(
                    onTap: (){
                      context.read<AddActivitiesCubit>().createActivities();
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
                  )
                ],
              ),
            ),
          );
        }
        return Center(child: CircularProgressIndicator(),);
      }),
    );
  }

  Widget createActivities(AddActivitiesLoaded state){
    if(state.enumStatus == EnumStatus.loading){
      return Center(child: SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(color: CustomColor.white,),
      ),);
    }else if(state.enumStatus == EnumStatus.loaded){
      return Text('Submit', style: CustomFont.fontTitleCard(
      CustomColor.white, CustomSize.f15), textAlign: TextAlign.center,);
    }else{
      return Text('Submit', style: CustomFont.fontTitleCard(
          CustomColor.white, CustomSize.f15), textAlign: TextAlign.center,);
    }
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
        isSelected = true;
        _selectTime(context);
      });
    }
  }

  Future<TimeOfDay> _selectTime(BuildContext context) async {
    final selected = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (selected != null && selected != selectedTime) {
      setState(() {
        selectedTime = selected;
        isSelectedTime = true;
      });
    }
    return selectedTime;
  }

  String getTime(TimeOfDay tod) {
    final now = DateTime.now();

    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm();
    return format.format(dt);
  }
}
