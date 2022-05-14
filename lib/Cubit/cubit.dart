import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Cubit/states.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Network/dio_helper.dart';
import '../Screens/business_screen.dart';
import '../Screens/science_screen.dart';
import '../Screens/settings_screen.dart';
import '../Screens/sport_screen.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(AppInitialStat());

  static AppCubit get(context)=>BlocProvider.of(context);

  List screens = [
    const BusinessScreen(),
    const SportScreen(),
    const ScienceScreen(),
  ];

  int currentIndex = 0;

  List business = [];

  List sports = [];

  List sciences = [];

  bool isDark = false;

  List search = [];


  List<BottomNavigationBarItem> bottomNavItem = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.business),
        label: 'Business'
    ),
    const BottomNavigationBarItem(
        icon: const Icon(Icons.sports),
        label: 'Sports'
    ),
    const BottomNavigationBarItem(
        icon: Icon(Icons.science),
        label: 'Sciences'
    ),
  ];

  changeBottomNavBarScreen(int index){
    currentIndex = index;
    emit(AppBottomNavState());
  }

  getBusiness(){
    emit(AppBusinessLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country':'eg',
        'category':'business',
        'apiKey':'8617b2e7ed1f43aeaaff85019305bc38'
      },
    ).then((value) {
      business = value.data['articles'];
      print(business);
      emit(AppBusinessSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(AppBusinessErrorState(error.toString()));
    });
  }

  getSports(){
    emit(AppSportsLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country':'eg',
        'category':'sports',
        'apiKey':'8617b2e7ed1f43aeaaff85019305bc38'
      },
    ).then((value) {
      sports = value.data['articles'];
      print(sports);
      emit(AppSportsSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(AppSportsErrorState(error.toString()));
    });
  }

  getSciences(){
    emit(AppSciencesLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country':'eg',
        'category':'science',
        'apiKey':'8617b2e7ed1f43aeaaff85019305bc38'
      },
    ).then((value) {
      sciences = value.data['articles'];
      print(sciences);
      emit(AppSciencesSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(AppSciencesErrorState(error.toString()));
    });
  }

  changeTheme({fromShared})async{
    if(fromShared!=null) {
      isDark = fromShared;
    } else {
      isDark = !isDark;
    }
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool('isDark', isDark).then((value) {
      print('$isDark');
      print(state);

    } );
    emit(AppChangeThemeState());
  }

  getSearch(String value){

    emit(AppSearchLoadingState());
    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q':'$value',
        'apiKey':'8617b2e7ed1f43aeaaff85019305bc38'
      },
    ).then((value) {
      search = value.data['articles'];
      print(search);
      emit(AppSearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(AppSearchErrorState(error.toString()));
    });
  }

}