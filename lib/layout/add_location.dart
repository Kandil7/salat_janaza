import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:salat_janaza/cubit/cubit.dart';
import 'package:salat_janaza/layout/component/component.dart';
import 'package:top_modal_sheet/top_modal_sheet.dart';

import '../colors/colors.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';
import '../model/model.dart';
import 'home.dart';

class addLocation extends StatefulWidget {
  addLocation({Key? key}) : super(key: key);

  @override
  State<addLocation> createState() => _addLocationState();
}

class _addLocationState extends State<addLocation> {
  @override
  void initState() {
    super.initState();
    AppCubit.get(context).getCurrentPosition();

  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        var currentPosition = cubit.currentPosition;
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Form(
            key: cubit.formKey,
            child: Scaffold(

              appBar: AppBar(
                title: Center(
                    child: Text(
                  'صلاة الجنازة',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                )),
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.redAccent,
                onPressed: () {
                  showTopModalSheet(
                      context,
                      Stack(
                        children: [
                          Container(
                            height: 500,
                            child: Column(
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(0),
                                      color: Colors.white),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 250,
                                          height: 60,
                                          child: TextFormField(
                                            readOnly: true,
                                            onTap: () =>
                                                cubit.selectDate(context).then((value) => cubit.selectTime(context)),
                                            controller:
                                                cubit.timeController,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'موعد الصلاة مطلوب';
                                              }
                                            },
                                            decoration: InputDecoration(
                                              hintText: 'موعد الصلاة',
                                              hintTextDirection:
                                                  TextDirection.rtl,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            width: 80,
                                            height: 60,
                                            child: Image.asset(
                                                'assets/images/icons8-calendar-50.png')),
                                      ],
                                    ),
                                  ),
                                ),

                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(0),
                                      color: Colors.white),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 250,
                                          height: 60,
                                          child: TextFormField(
                                            controller: cubit.masgedController,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {

                                                return 'اسم المسجد مطلوب';
                                              }
                                            },
                                            decoration: InputDecoration(
                                                hintText: ' اسم المسجد',
                                                hintTextDirection:
                                                    TextDirection.rtl),
                                          ),
                                        ),
                                        SizedBox(
                                            width: 80,
                                            height: 60,
                                            child: Image.asset(
                                                'assets/images/icons8_ds.png')),
                                      ],
                                    ),
                                  ),
                                ),

                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(0),
                                      color: Colors.white),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 250,
                                          height: 60,
                                          child: TextFormField(
                                            controller:
                                                cubit.locationController,
                                            readOnly: true,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'عنوان المسجد مطلوب';
                                              }
                                              if (cubit.longitudeController ==
                                                      null ||
                                                  cubit.latitudeController ==
                                                      null) {

                                                return 'يجب اختيار موقع المسجد يدويا';
                                              }
                                            },
                                            decoration: InputDecoration(
                                                hintText: ' عنوان المسجد',
                                                hintTextDirection:
                                                    TextDirection.rtl),
                                          ),
                                        ),
                                        SizedBox(
                                            width: 80,
                                            height: 60,
                                            child: Image.asset(
                                                'assets/images/location.png')),
                                      ],
                                    ),
                                  ),
                                ),

                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(0),
                                      color: Colors.white),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 250,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.1,
                                          child: TextFormField(
                                            controller: cubit.nameController,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {

                                                return 'اسم المتوفي مطلوب';
                                              } else if (value.length < 3) {

                                                return 'اسم المتوفي يجب ان يكون اكثر من 3 حروف';
                                              }
                                            },
                                            decoration: InputDecoration(
                                                hintText: ' اسم المتوفي',
                                                hintTextDirection:
                                                    TextDirection.rtl),
                                          ),
                                        ),
                                        SizedBox(
                                            width: 80,
                                            height: 60,
                                            child: Image.asset(
                                                'assets/images/icons8-user-64.png')),
                                      ],
                                    ),
                                  ),
                                ),
                                // Spacer(flex: 1,),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: InkWell(
                              onTap: () {
                                if (cubit.formKey.currentState!.validate() &&
                                    (cubit.longitudeController != null) &&
                                    (cubit.latitudeController != null)) {
                                  cubit.createPost(
                                    name: cubit.nameController.text,
                                    location: cubit.locationController.text,
                                    masged: cubit.masgedController.text,
                                    time: cubit.timeController.text,
                                    date: cubit.dateController.text,
                                    latitude: cubit.latitudeController,
                                    longitude: cubit.longitudeController,
                                  );
                                  cubit.nameController.clear();
                                  cubit.locationController.clear();
                                  cubit.masgedController.clear();
                                  cubit.timeController.clear();
                                  cubit.latitudeController = null;
                                  cubit.longitudeController = null;
                                  cubit.dateController.clear();
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomePage()));
                                  print("done------------------------");
                                  showSnackBar(SnackBar(
                                    content: Text('تم اضافة الصلاة بنجاح'),
                                    backgroundColor: Colors.green,
                                  ));
                                } else {
                                  if (cubit.formKey.currentState != null) {
                                    showSnackBar(SnackBar(
                                      content: Text(
                                          'تاكد من ملي البيانات بطريقه صحيحه'),
                                      backgroundColor: Colors.red,
                                    ));

                                  }

                                  print("not done------------------------");
                                }
                              },
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white),
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.redAccent),
                                  child: Text(
                                    'اضافة صلاة',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.white),
                                  )),
                            ),
                          ),
                        ],
                      ));
                },
                child: Icon(Icons.location_on),
              ),
              body: OpenStreetMapSearchAndPick(
                  center: LatLong(
                      currentPosition!.latitude, currentPosition!.longitude),
                  buttonColor: canvasColor,
                  buttonText: 'تحديد مكان المسجد ',
                  locationPinIconColor: Colors.redAccent,
                  onPicked: (pickedData) async {
                    await pickedData.latLong.latitude;
                    await pickedData.latLong.longitude;
                    await pickedData.address;
                    cubit.locationController.text = pickedData.address;
                    cubit.longitudeController = pickedData.latLong.longitude;
                    cubit.latitudeController = pickedData.latLong.latitude;

                    print(pickedData);
                    print(pickedData.latLong.latitude);
                    print(pickedData.latLong.longitude);
                    print(pickedData.address);
                  }),
            ),
          ),
        );
      },
    );
  }

  void showSnackBar(SnackBar snackBar) {
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

