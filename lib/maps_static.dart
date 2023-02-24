import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'cubit/cubit.dart';
import 'cubit/state.dart';
import 'layout/component/component.dart';


class LocationPage extends StatelessWidget {



  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        var currentPosition = cubit.currentPosition;
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // addMarker(currentPosition.latitude, currentPosition.longitude);
            },
            child: Icon(Icons.add),
          ),
          body: ConditionalBuilder(
            condition: currentPosition!=null,
            fallback: (context) => Center(child: CircularProgressIndicator()),
            builder: (context) {
              return  FlutterMap(
                options: MapOptions(
                  center: LatLng(currentPosition!.latitude, currentPosition.longitude),
                  zoom: 9.2,
                ),
                nonRotatedChildren: [
                  AttributionWidget.defaultWidget(
                    source: 'OpenStreetMap contributors',
                    onSourceTapped: () => print('OpenStreetMap contributors'),
                  ),

                ],
                mapController: MapController(),
                children: markers
              );
            }
          ),
          //drawer: ExampleSidebarX(controller: _controller),,
        );
      }
    );
  }

  LocationMarkerLayer markerMethod(currentPosition) {
    return LocationMarkerLayer(position: LocationMarkerPosition(

                   latitude: currentPosition.latitude, longitude: currentPosition.longitude, accuracy: 0

                ),
                  style: LocationMarkerStyle(
                    marker: const DefaultLocationMarker(
                      child: Icon(
                        Icons.location_on,
                        color: Colors.red,
                      ),
                    ),
                    markerSize: const Size(40, 40),
                    markerDirection: MarkerDirection.heading,
                  ),
                );
  }
}

class marker extends StatelessWidget {
   marker({
    super.key, required double latitude, required double longitude,
  });

  @override
  Widget build(BuildContext context) {
    return LocationMarkerLayer(position: LocationMarkerPosition(

        latitude: 31.205753, longitude: 29.924526, accuracy: 5

    ),
      style: LocationMarkerStyle(
        marker: const DefaultLocationMarker(
          child: Icon(
            Icons.location_on,
            color: Colors.red,
          ),
        ),
        markerSize: const Size(40, 40),
        markerDirection: MarkerDirection.heading,
      ),
    );
  }
}
Widget buildCurrentLocation() {
  return CurrentLocationLayer(
    followOnLocationUpdate: FollowOnLocationUpdate.always,
    turnOnHeadingUpdate: TurnOnHeadingUpdate.never,
    style: LocationMarkerStyle(
      marker: const DefaultLocationMarker(
        child: Icon(
          Icons.navigation,
          color: Colors.white,
        ),
      ),
      markerSize: const Size(40, 40),
      markerDirection: MarkerDirection.heading,
    ),
  );
}







Widget markerWidget ({
required double latitude,
  required double longitude,
}) {
  return LocationMarkerLayer(position: LocationMarkerPosition(

      latitude: latitude, longitude: longitude, accuracy: 0

  ),
    style: LocationMarkerStyle(
      marker: const DefaultLocationMarker(
        child: Icon(
          Icons.location_on,
          color: Colors.red,
        ),
      ),
      markerSize: const Size(40, 40),
      markerDirection: MarkerDirection.heading,
    ),
  );

}
var testdic=  {
  LocationMarkerLayer(
    position: LocationMarkerPosition(
        latitude: 31.205753, longitude: 29.924526, accuracy: 0),
    style: const LocationMarkerStyle(
      marker: DefaultLocationMarker(
        child: Icon(
          Icons.location_on,
          color: Colors.red,
        ),
      ),
      markerSize: Size(40, 40),
      markerDirection: MarkerDirection.heading,
    ),
  ),
  LocationMarkerLayer(
    position: LocationMarkerPosition(
        latitude: 31.205753, longitude: 30.924526, accuracy: 0),
    style: LocationMarkerStyle(
      marker: const DefaultLocationMarker(
        child: Icon(
          Icons.location_on,
          color: Colors.red,
        ),
      ),
      markerSize: const Size(40, 40),
      markerDirection: MarkerDirection.heading,
    ),
  ),
  LocationMarkerLayer(
    position: LocationMarkerPosition(
        latitude: 31.205753, longitude: 31.924526, accuracy: 0),
    style: LocationMarkerStyle(
      marker: const DefaultLocationMarker(
        child: Icon(
          Icons.location_on,
          color: Colors.red,
        ),
      ),
      markerSize: const Size(40, 40),
      markerDirection: MarkerDirection.heading,
    ),
  ),
};

