import 'package:geolocator/geolocator.dart';

import '../model/login_model.dart';
import '../model/model.dart';

abstract class AppStates {}

class AppInitialState extends AppStates {}
class AppLocationLoadingState extends AppStates {}
class AppLocationSuccessState extends AppStates {
  final Position position;
  final String address;

  AppLocationSuccessState(this.position, this.address);
}
class AppLocationErrorState extends AppStates {
  final String error;

  AppLocationErrorState(this.error);
}
class AppUploadDataLoadingState extends AppStates {}
class AppUploadDataSuccessState extends AppStates {}
class AppUploadDataErrorState extends AppStates {
  final String error;

  AppUploadDataErrorState(this.error);
}
class AppFacebookLoginLoadingState extends AppStates {}
class AppFacebookLoginSuccessState extends AppStates {
  final uid;

  AppFacebookLoginSuccessState(this.uid);
}
class AppFacebookLoginErrorState extends AppStates {
  final String error;

  AppFacebookLoginErrorState(this.error);
}
class AppGoogleLoginLoadingState extends AppStates {}
class AppGoogleLoginSuccessState extends AppStates {
  final uid;

  AppGoogleLoginSuccessState(this.uid);
}
class AppGoogleLoginErrorState extends AppStates {
  final String error;

  AppGoogleLoginErrorState(this.error);
}
class CreatDeceasedPostLoadingState extends AppStates {}
class CreateDeceasedPostSuccessState extends AppStates {}
class CreateDeceasedPostErrorState extends AppStates {
  final String error;

  CreateDeceasedPostErrorState(this.error);
}
class DeleteDeceasesdPostSuccessState extends AppStates {}
class GetDeceasedPostLoadingState extends AppStates {}
class GetDeceasedPostSuccessState extends AppStates {
  final List<Model> deceasedList;

  GetDeceasedPostSuccessState(this.deceasedList);
}
class GetDeceasedPostErrorState extends AppStates {
  final String error;

  GetDeceasedPostErrorState(this.error);
}
class PikeDateLoadingState extends AppStates {}
class PikeDateSuccessState extends AppStates {}
class PikeDateErrorState extends AppStates {
  final String error;

  PikeDateErrorState(this.error);
}
class PikeTimeLoadingState extends AppStates {}
class PikeTimeSuccessState extends AppStates {}
class PikeTimeErrorState extends AppStates {
  final String error;

  PikeTimeErrorState(this.error);
}
class AppFirebaseNotificationSuccessState extends AppStates {}
class AppFirebaseNotificationErrorState extends AppStates {
  final String error;

  AppFirebaseNotificationErrorState(this.error);
}
class DataSetting extends AppStates{}
class AddMarkerLoadingState extends AppStates {}
class AddMarkerSuccessState extends AppStates {}
class AddMarkerErrorState extends AppStates {
  final String error;

  AddMarkerErrorState(this.error);
}
class GetMarkerLoadingState extends AppStates {}
class GetLocationSuccessState extends AppStates {
  final Position position;
  final String address;

  GetLocationSuccessState(this.position, this.address);
}
class GetLocationErrorState extends AppStates {
  final String error;

  GetLocationErrorState(this.error);
}
class ClearDeceasedPostSuccessState extends AppStates {}
class PikeDateTimeLoadingState extends AppStates {}
class PikeDateTimeSuccessState extends AppStates {}
class PikeDateTimeErrorState extends AppStates {
  final String error;

  PikeDateTimeErrorState(this.error);
}