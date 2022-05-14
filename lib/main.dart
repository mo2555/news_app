import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/Cubit/cubit.dart';
import 'package:news_app/Screens/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Cubit/states.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    MyApp(
      isDark: sharedPreferences.getBool('isDark'),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool? isDark;

  MyApp({Key? key, this.isDark}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AppCubit()
            ..getBusiness()
            ..getSports()
            ..getSciences()..changeTheme(fromShared: isDark),
        ),
        // BlocProvider(
        //   create: (BuildContext context) => AppCubit()..changeTheme(fromShared: isDark),
        // ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, state) {
          print(state);
        },
        builder: (BuildContext context, Object? state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'News App',
            theme: ThemeData(
              primarySwatch: Colors.deepOrange,
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white,
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                iconTheme: IconThemeData(
                  color: Colors.black,
                  size: 30,
                ),
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
                elevation: 0,
                titleSpacing: 20,
              ),
              scaffoldBackgroundColor: Colors.white,
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                backgroundColor: Colors.white,
                selectedItemColor: Colors.deepOrange,
                elevation: 20,
              ),
              textTheme: const TextTheme(
                bodyText1: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            darkTheme: ThemeData(
              primarySwatch: Colors.deepOrange,
              appBarTheme: AppBarTheme(
                backgroundColor: HexColor('333739'),
                titleTextStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                iconTheme: const IconThemeData(
                  color: Colors.white,
                  size: 30,
                ),
                systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: Colors.black,
                  statusBarIconBrightness: Brightness.light,
                ),
                elevation: 0,
                titleSpacing: 20,
              ),
              scaffoldBackgroundColor: HexColor('333739'),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  backgroundColor: HexColor('333739'),
                  selectedItemColor: Colors.deepOrange,
                  elevation: 20,
                  unselectedItemColor: Colors.grey),
              textTheme: const TextTheme(
                bodyText1: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: const MyHomePage(),
          );
        },
      ),
    );
  }
}
