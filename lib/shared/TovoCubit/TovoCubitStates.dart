
abstract class flowerStates {}
class flowerInitialState extends flowerStates {}
class flowerTabChangeState extends flowerStates {}
class flowerAddWidgetState extends flowerStates {}
class flowerCreateDatabaseState extends flowerStates {}
class flowerGetRecordState extends flowerStates {}
class flowerInsertRecordState extends flowerStates {}
class flowerModifyRecordState extends flowerStates {}
class flowerDeleteRecordState extends flowerStates {}
class flowerClearState extends flowerStates {}
class flowerAllTabState extends flowerStates {}
class flowerLowTabState extends flowerStates {}
class flowerMediumTabState extends flowerStates {}
class flowerHighTabState extends flowerStates {}
class flowerVHighTabState extends flowerStates {}
class flowerNavigateState extends flowerStates{}
class flowerGetSearchRes extends flowerStates{}
class flowerChangeTheme extends flowerStates{}
class flowerWeatherLoadingState extends flowerStates{}
class flowerWeatherSuccessState extends flowerStates{}
class flowerWeatherErrorState extends flowerStates{
  String error;
  flowerWeatherErrorState(this.error);
}
class flowerUserGetRecordState extends flowerStates {}
class flowerUserInsertRecordState extends flowerStates {}
class flowerUserModifyRecordState extends flowerStates {}
class flowerUserDeleteRecordState extends flowerStates {}
class flowerUserLoginState extends flowerStates {}
class flowerShowPasswordState extends flowerStates {}
class flowerFailedLoginState extends flowerStates {}
class flowerSignOutState extends flowerStates {}
class flowerFailedModifyState extends flowerStates {}