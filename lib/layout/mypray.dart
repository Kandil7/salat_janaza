import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:salat_janaza/cubit/cubit.dart';

import '../cubit/state.dart';
import 'add_location.dart';

class MyPray extends StatelessWidget {
  const MyPray({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state) {},
      builder: (context,state) {
        var cubit = AppCubit.get(context);
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: AppBar(
              title: Text('صلواتي',
              ),

            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.blue,
              onPressed: () {
                cubit.clearCollectionFirestore();
              },
              child: Icon(Icons.add_location_alt,),
            ),
            body: cubit.deceaseds_posts.length == 0 ? Center(child: Text('لا يوجد صلاة جنازة',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white
            )
            ),) : ListView.separated(
              itemBuilder: (context,index) => Card(
                child: ListTile(
                  title: Text(cubit.deceaseds_posts[index].name!),
                  subtitle: Text(cubit.deceaseds_posts[index].time!),
                  trailing: Text('${round(cubit.calculateDistanse(cubit.deceaseds_posts[index].latitude!, cubit.deceaseds_posts[index].longitude!, cubit.currentPosition!.latitude, cubit.currentPosition!.longitude),decimals: 2).floorToDouble()/1000} كم '),
                ),
              ),
              separatorBuilder: (context,index) => SizedBox(height: 10,),
              itemCount: cubit.deceaseds_posts.length,
              // child: Card(
              //   child: ListTile(
              //     title: Text(cubit.deceaseds_posts[0].name!),
              //     subtitle: Text(cubit.deceaseds_posts[0].time!),
              //     trailing: Text('${round(cubit.calculateDistanse(cubit.deceaseds_posts[0].latitude!, cubit.deceaseds_posts[0].longitude!, cubit.currentPosition!.latitude, cubit.currentPosition!.longitude),decimals: 2)} كم'),
              //   ),
              // ),
            ),


            )

        );
      }
    );
  }
}
