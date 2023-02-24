import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../model/model.dart';
import 'state.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  final dataBase = FirebaseDatabase.instance.ref();
  final fire = FirebaseFirestore.instance;
  final firestore = FirebaseFirestore.instance.collection('prayers');
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  var currentPosition;

  Future requestPermission() async {
    await Geolocator.requestPermission().then((value) {
      if (value == LocationPermission.deniedForever) {
        emit(AppLocationErrorState(
            'Location permissions are permanently denied, we cannot request permissions.'));
        Geolocator.openLocationSettings();
      } else if (value == LocationPermission.denied) {
        emit(AppLocationErrorState('Location permissions are denied'));
        Geolocator.openLocationSettings();
      } else {
        getCurrentPosition();
        // emit(AppLocationSuccessState(
        //     currentPosition, 'Location permissions are granted'
        // ));
      }
    });
    emit(AppInitialState());
  }

  Future<void> getCurrentPosition() async {
    emit(AppLocationLoadingState());

    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      emit(AppLocationErrorState('Location services are disabled.'));
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        emit(AppLocationErrorState('Location permissions are denied'));
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      emit(AppLocationErrorState(
          'Location permissions are permanently denied, we cannot request permissions.'));
      return;
    }

    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      currentPosition = position;
      final address = await getAddressFromLatLng(position);
      emit(AppLocationSuccessState(position, address));
    }).catchError((e) {
      emit(AppLocationErrorState('Failed to get current location'));
    });
    return currentPosition;
  }

  Future<String> getAddressFromLatLng(Position position) async {
    final placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    if (placemarks.isNotEmpty) {
      final place = placemarks[0];
      return '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
    }
    return '';
  }

  calculateDistanse(double lat1, double lon1, double lat2, double lon2) {
    // var p = 0.017453292519943295;    // Math.PI / 180
    // var c = cos;
    // var a = 0.5 - c((lat2 - lat1) * p)/2 +
    //     c(lat1 * p) * c(lat2 * p) *
    //         (1 - c((lon2 - lon1) * p))/2;
    //
    // return 12742 * asin(sqrt(a));
    // 2 * R; R = 6371 km
    emit(AppLocationLoadingState());
    return Geolocator.distanceBetween(lat1, lon1, lat2, lon2);
  }

  void registerNotification() async {
    // 1. Initialize the Firebase app
    await Firebase.initializeApp();

    // 2. Instantiate Firebase Messaging
   var messaging = FirebaseMessaging.instance;

    // 3. On iOS, this helps to take the user permissions
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
      // TODO: handle the received notifications
    } else {
      print('User declined or has not accepted permission');
    }
  }

  permissions() async {
    await FirebaseMessaging.instance.setAutoInitEnabled(true);
    final fcmToken = await FirebaseMessaging.instance.getToken();
    FirebaseMessaging.instance.onTokenRefresh
        .listen((fcmToken) {
      // TODO: If necessary send token to application server.

      // Note: This callback is fired at each app startup and whenever a new
      // token is generated.
    })
        .onError((err) {
      // Error getting token.
    });
    await FirebaseMessaging.instance
        .requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    )
        .then((value) {
      if (value.authorizationStatus == AuthorizationStatus.authorized) {
        print('User granted permission');
        emit(AppFirebaseNotificationSuccessState());
      } else if (value.authorizationStatus == AuthorizationStatus.provisional) {
        print('User granted provisional permission');
        emit(AppFirebaseNotificationSuccessState());
      } else {
        print('User declined or has not accepted permission');
        emit(AppFirebaseNotificationErrorState(
            'User declined or has not accepted permission'));
      }
    });
  }



  Model? model;
  List<Model> deceaseds_posts = [];
  Map<dynamic, dynamic> deceaseds_posts_map = {};

  clearCollectionFirestore() {
    firestore.get().then((querySnapshot) {
      querySnapshot.docs.forEach((document) {
        document.reference.delete();
      });
    });
    emit(ClearDeceasedPostSuccessState());
  }

  void createPost({
    required String name,
    required String masged,
    required double latitude,
    required double longitude,
    required String location,
    required String date,
    required String time,
  }) {
    emit(CreatDeceasedPostLoadingState());
    String postId = firestore.doc().id;
    Model model = Model(
      name: name,
      id: postId,
      masged: masged,
      latitude: latitude,
      longitude: longitude,
      date: date,
      time: time,
      location: location,
    );

    firestore.add(model.toJson()).then((value) async {
      deceaseds_posts_map.addAll({
        model.id: [model.time, model.date]
      });
      final message = {
        'notification': {
          'title': 'New post added',
          'body': 'New post added by $name',
        },
        'data': {
          'postId': postId,
        },
        'topic': 'new-posts',
      };
      //await admin.messaging().sendToTopic('new-posts', message);;
      emit(CreateDeceasedPostSuccessState());
    }).catchError((error) {
      emit(CreateDeceasedPostErrorState(error.toString()));
    });
  }

  void getPosts() {
    deceaseds_posts = [];
    markers = [
      TileLayer(
        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        userAgentPackageName: 'open_street_map_search_and_pick',
        subdomains: ['a', 'b', 'c'],
      ),
    ];
    emit(GetDeceasedPostLoadingState());
    firestore
        .orderBy('date', descending: true)
        .snapshots()
        .listen((event) async {
      event.docs.forEach((element) {
        deceaseds_posts.add(Model.fromJson(element.data()));
        addMarker(element.data()['latitude'], element.data()['longitude']);
      });
      emit(GetDeceasedPostSuccessState(deceaseds_posts));

    });
  }

  void deletePost(String? postId) {
    firestore.doc(postId).delete().then((value) {
      getPosts();
      emit(DeleteDeceasesdPostSuccessState());
    });
  }

  var scaffoldkey = GlobalKey<ScaffoldState>();
  DateTime selectedDate = DateTime.now();
  var nameController = TextEditingController();
  var masgedController = TextEditingController();
  var dateController = TextEditingController();
  var timeController = TextEditingController();
  var locationController = TextEditingController();
  var placeController = TextEditingController();
  var longitudeController;
  var latitudeController;
  var dateTimeController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  Future<void> selectDate(BuildContext context) async {
    emit(PikeDateLoadingState());
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 30)));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      dateController.text = picked.toString();
      emit(PikeDateSuccessState());
    }
  }

  Future<void> selectTime(BuildContext context) async {
    emit(PikeTimeLoadingState());
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (picked != null) {
      timeController.text = picked.format(context).toString();

      emit(PikeTimeSuccessState());
    }
  }

  Future<void> selectDateTime(BuildContext context) async {
    emit(PikeDateTimeLoadingState());
    selectDate(context).then((date) {
      selectTime(context).then((time) {
        var dateString = (dateController.text).toString() +
            ' ' +
            timeController.text.toString();
        dateTimeController.text = DateTime.parse(dateString).toString();
        emit(PikeDateTimeSuccessState());
      }).catchError((error) {
        selectDateTime(context);
        emit(PikeDateTimeErrorState(error.toString()));
      });
    }).then((value) {
      emit(PikeDateTimeSuccessState());
    }).catchError((error) {
      selectDateTime(context);
      emit(PikeDateTimeErrorState(error.toString()));
    });
  }

  List<Widget> markers = [
    TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      userAgentPackageName: 'open_street_map_search_and_pick',
      subdomains: ['a', 'b', 'c'],
    ),
  ];
  var item;
  addMarker(
    dynamic latitude,
    dynamic longitude,
  ) {
    for (item in deceaseds_posts) {
      markers.add(LocationMarkerLayer(
        position: LocationMarkerPosition(
            latitude: item.latitude, longitude: item.longitude, accuracy: 0),
        style: LocationMarkerStyle(
          showAccuracyCircle: false,
          showHeadingSector: false,
          marker: const DefaultLocationMarker(
            color: Colors.transparent,
            child: Image(
              image: AssetImage(
                'assets/images/location.png',
              ),
            ),
          ),
          markerSize: const Size(50, 50),
          markerDirection: MarkerDirection.heading,
        ),
      ));
    }
  }

  Future sendNotificationFirebase() async {

  }
}
