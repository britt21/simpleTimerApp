import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simple_timer_app/state/todo_bloc.dart';
import 'package:simple_timer_app/state/todp_event.dart';
import 'package:simple_timer_app/ui/home/create_timer.dart';
import 'package:simple_timer_app/ui/home/home_dashboard.dart';
import 'package:simple_timer_app/ui/home/splash_home.dart';
import 'package:simple_timer_app/ui/home/task_details.dart';
import 'package:simple_timer_app/utils/navigation/navigation.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getTemporaryDirectory());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoBloc()..add(TodoStarted()),
      child: BlocProvider(
        create: (context) => NavigationBloc(navigatorKey: navigatorKey),
        child: MaterialApp(
          title: 'Simple Timer',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          navigatorKey: navigatorKey,
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case '/home_dashboard':
                return MaterialPageRoute(builder: (_) => HomeDashboard());
              case '/create_task':
                return MaterialPageRoute(builder: (_) => CreateTimer(description: '',));
              default:
                return null;
            }
          },
          home: HomeDashboard(),
        ),
      ),
    );
  }
}
