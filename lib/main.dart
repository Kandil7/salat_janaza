import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:salat_janaza/colors/colors.dart';
import 'package:salat_janaza/layout/splash_screen.dart';
import 'package:salat_janaza/services/database_helper.dart';

import 'cubit/cubit.dart';
import 'cubit/state.dart';
import 'firebase_options.dart';
import 'layout/component/component.dart';
import 'layout/login/login_screen.dart';



main() async
{
  WidgetsFlutterBinding.ensureInitialized();

WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );




runApp(MyApp());}

class MyApp extends StatelessWidget {




  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..getCurrentPosition()..getPosts(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(

            theme: ThemeData(
              switchTheme: SwitchThemeData(
                thumbColor: MaterialStateProperty.all(Colors.white),
                trackColor: MaterialStateProperty.all(Colors.grey),
              ),
              primarySwatch: Colors.red,
              primaryColor: primaryColor,
              canvasColor: canvasColor,
              appBarTheme: AppBarTheme(
                centerTitle: true,
                backgroundColor: canvasColor,


                iconTheme: IconThemeData(color: Colors.white),
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'assets/fonts/alfont_com_DGAgnadeen-Extrabold.ttf',
                ),
              ),

              textTheme:  TextTheme(
                headlineSmall: TextStyle(
                  color: Colors.white,
                  fontSize: 46,
                  //fontWeight: FontWeight.w800,
                  fontFamily: 'DGAgnadeen',
                ),
              ),
            ),
            debugShowCheckedModeBanner: false,
            home: SplashScreen(),
          );
        }
      ),
    );
  }
}



class DeliveryApp extends StatefulWidget {
  @override
  _DeliveryAppState createState() => _DeliveryAppState();
}

class _DeliveryAppState extends State<DeliveryApp> {
  final deliveryLocations = [
    {
      'name': 'Restaurant 1',
      'location': Coords(37.7874, -122.4082),
    },
    {
      'name': 'Restaurant 2',
      'location': Coords(37.7901, -122.4004),
    },
    {
      'name': 'Restaurant 3',
      'location': Coords(37.7986, -122.4067),
    },
  ];
  late Coords selectedLocation;

  void _selectDeliveryLocation(BuildContext context) async {
    selectedLocation = (await showModalBottomSheet<Coords>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Select a delivery location:',
                style: TextStyle(fontSize: 20),
              ),
              for (var location in deliveryLocations)
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(location['location']);
                  },
                  child: Text(location['name'].toString()),
                ),
            ],
          ),
        );
      },
    ))!;

    if (selectedLocation != null) {
      MapsLauncher.launchCoordinates(
        selectedLocation.latitude,
        selectedLocation.longitude,
        'Delivery Location',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delivery App'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            MapsLauncher.launchQuery('restaurants near me');
          },
          child: Text('Find Restaurants'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _selectDeliveryLocation(context);
        },
        child: Icon(Icons.add_location),
      ),
    );
  }
}

class MapsLauncher {
  MapsLauncher._();

  static Future<void> launchCoordinates(
    double latitude,
    double longitude,
    String title,
  ) async {
    final availableMaps = await MapLauncher.installedMaps;

    await availableMaps.first.showMarker(
      coords: Coords(latitude, longitude),
      title: title,
    );
  }

  static Future<void> launchQuery(String query) async {
    final availableMaps = await MapLauncher.installedMaps;

    await availableMaps.first.showDirections(
      destination: Coords(37.4219999, -122.0862462),
      destinationTitle: 'Googleplex',
    );
  }
}



