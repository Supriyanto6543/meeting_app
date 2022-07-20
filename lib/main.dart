import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeting_app/common/constant.dart';
import 'package:meeting_app/common/routes.dart';
import 'package:meeting_app/presenter/bottom_view.dart';
import 'package:meeting_app/presenter/cubit/add/add_activities_cubit.dart';
import 'package:meeting_app/presenter/cubit/info/info_cubit.dart';
import 'package:meeting_app/presenter/cubit/list/list_activities_cubit.dart';
import 'package:meeting_app/presenter/cubit/my_activities/my_activities_cubit.dart';
import 'package:meeting_app/presenter/pages/add/add_page.dart';
import 'package:meeting_app/presenter/pages/edit/edit_page.dart';
import 'package:meeting_app/presenter/pages/info/activity_info_page.dart';
import 'injection.dart' as di;
import 'package:intl/date_symbol_data_local.dart';

void main(){
  di.init();
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_)=> di.locator<ListActivitiesCubit>()..fetchActivities(isOpen: true, type: Constant.getAll)),
        BlocProvider(create: (_)=> di.locator<MyActivitiesCubit>()..fetchAllMyActivities(),),
        BlocProvider(create: (_)=> AddActivitiesCubit())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BottomView(),
        initialRoute: '/',
        onGenerateRoute: (routes){
          switch(routes.name){
            case Routes.addActivities:
              return MaterialPageRoute(builder: (context)=> AddPage());
            case Routes.infoActivities:
              int id = routes.arguments as int;
              return MaterialPageRoute(builder: (context)=> ActivityInfoPage(id: id,));
            case Routes.editActivities:
              int id = routes.arguments as int;
              return MaterialPageRoute(builder: (context)=> EditPage(id: id));
            default:
              return MaterialPageRoute(builder: (context)=> Center(child: Text('Page not found'),));
          }
        }
      ),
    );
  }
}

