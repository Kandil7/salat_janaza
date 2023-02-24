import 'package:geolocator/geolocator.dart';
abstract class LocationStates {}
class LocationInitialState extends LocationStates {}
class LocationLoadingState extends LocationStates {}
class LocationSuccessState extends LocationStates {
  final Position position;
  final String address;

  LocationSuccessState(this.position, this.address);
}
class LocationErrorState extends LocationStates {
  final String error;

  LocationErrorState(this.error);
}
class UploadDataLoadingState extends LocationStates {}
class UploadDataSuccessState extends LocationStates {}
class UploadDataErrorState extends LocationStates {
  final String error;

  UploadDataErrorState(this.error);
}

// class LocationState {
//   final bool isLoading;
//   final bool isSuccess;
//   final bool isError;
//   final String? errorMessage;
//   final Position? position;
//   final String? address;
//
//   LocationState(
//       this.isLoading,
//       this.isSuccess,
//       this.isError,
//       this.errorMessage,
//       this.position,
//       this.address,
//       );
//
//   LocationState.loading()
//       : isLoading = true,
//         isSuccess = false,
//         isError = false,
//         errorMessage = null,
//         position = null,
//         address = null;
//
//   LocationState.success(Position position, String? address)
//       : isLoading = false,
//         isSuccess = true,
//         isError = false,
//         errorMessage = null,
//         position = position,
//         address = address;
//
//   LocationState.error(String errorMessage)
//       : isLoading = false,
//         isSuccess = false,
//         isError = true,
//         errorMessage = errorMessage,
//         position = null,
//         address = null;
// }