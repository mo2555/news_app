abstract class AppStates{}

class AppInitialStat extends AppStates{}

class AppBottomNavState extends AppStates{}

class AppBusinessLoadingState extends AppStates{}

class AppBusinessSuccessState extends AppStates{}

class AppBusinessErrorState extends AppStates{
  final String error;

  AppBusinessErrorState(this.error);

}

class AppSportsLoadingState extends AppStates{}

class AppSportsSuccessState extends AppStates{}

class AppSportsErrorState extends AppStates{
  final String error;

  AppSportsErrorState(this.error);

}

class AppSciencesLoadingState extends AppStates{}

class AppSciencesSuccessState extends AppStates{}

class AppSciencesErrorState extends AppStates{
  final String error;

  AppSciencesErrorState(this.error);

}

class AppChangeThemeState extends AppStates{}

class AppSearchSuccessState extends AppStates{}

class AppSearchErrorState extends AppStates{
  final String error;

  AppSearchErrorState(this.error);

}

class AppSearchLoadingState extends AppStates{}



