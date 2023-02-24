import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:lottie/lottie.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:salat_janaza/layout/rate.dart';
import 'package:salat_janaza/layout/setting.dart';
import 'package:salat_janaza/layout/share.dart';

import 'package:sidebarx/sidebarx.dart';
import '../colors/colors.dart';
import '../cubit/cubit.dart';

import '../cubit/cubit.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';
import 'about.dart';
import 'add_location.dart';
import 'component/component.dart';
import 'contact_with_us.dart';
import 'how_to_pray.dart';
import 'how_to_use.dart';
import 'mypray.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = SidebarXController(selectedIndex: 0, extended: true);

  final _key = GlobalKey<ScaffoldState>();
  @override
  void initState()  {

    super.initState();
     AppCubit.get(context).getCurrentPosition();


  }

  @override
  Widget build(BuildContext context) {


        return BlocConsumer<AppCubit,AppStates>(
            listener: (context, state) {},
        builder: (context, state) {
        var cubit = AppCubit.get(context);
        var currentPosition = cubit.currentPosition;
        final isSmallScreen = MediaQuery.of(context).size.width < 600;
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: canvasColor,
              onPressed: () {
                //cubit.clearCollectionFirestore();
                Navigator.push(context, MaterialPageRoute(builder: (context) => addLocation()));
              },
              child: Icon(Icons.add_location_alt,),
            ),

                      key: _key,
                      appBar: isSmallScreen
                          ? AppBar(
                        title: Center(child: Text('صلاة الجنازة',
                        style: TextStyle(

                          fontWeight: FontWeight.bold,
                          fontSize: 24
                        ),)),
                        backgroundColor: canvasColor,
                        leading: IconButton(
                          onPressed: () {

                            _key.currentState?.openDrawer();
                          },
                          icon: const Icon(Icons.menu),
                        ),
                        actions: [
                          MaterialButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => MyPray()));
                          }, child: CircleAvatar(
                            radius: 18,
                              backgroundColor: Colors.redAccent,
                              child: Image.asset('assets/images/icons8_ds.png',)))
                        ],
                      )
                          : null,
                      drawer: ExampleSidebarX(controller: _controller),
                      body: Row(
                        children: [
                          if (!isSmallScreen) ExampleSidebarX(controller: _controller),
                           Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ConditionalBuilder(
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
                                        children: cubit.markers,
                                    );
                                  }
                                      ),
                              ),
                            ),
                        ],
                      ),
                    ),
        );
                },
               );

} }

class ExampleSidebarX extends StatelessWidget {
  const ExampleSidebarX({
    Key? key,
    required SidebarXController controller,
  })  : _controller = controller,
        super(key: key);

  final SidebarXController _controller;

  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: _controller,
      theme: SidebarXTheme(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: canvasColor,
          borderRadius: BorderRadius.circular(20),
        ),
        textStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
        selectedTextStyle: const TextStyle(color: Colors.white),
        itemTextPadding: const EdgeInsets.only(left: 30),
        selectedItemTextPadding: const EdgeInsets.only(left: 30),
        itemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: canvasColor),
        ),
        selectedItemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: actionColor.withOpacity(0.37),
          ),
          gradient: const LinearGradient(
            colors: [accentCanvasColor, canvasColor],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.28),
              blurRadius: 30,
            )
          ],
        ),
        iconTheme: IconThemeData(
          color: Colors.white.withOpacity(0.7),
          size: 20,
        ),
        selectedIconTheme: const IconThemeData(
          color: Colors.white,
          size: 20,
        ),
      ),
      extendedTheme: const SidebarXTheme(
        width: 200,
        decoration: BoxDecoration(
          color: canvasColor,
        ),
      ),
      footerDivider: divider,
      headerBuilder: (context, extended) {
        return SizedBox(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Lottie.asset('assets/images/home.json'),
          ),
        );
      },
      items: [
         SidebarXItem(
          icon: Icons.home,
          label: 'صلاة الجنازة',
          onTap: () {
          },
        ),
         SidebarXItem(
           onTap: (){
             Navigator.push(context, MaterialPageRoute(builder: (context)=>MyPray()));

           },
          icon: Icons.people,
          label: 'صلواتي',
        ),
         SidebarXItem(
           onTap: (){
             Navigator.push(context, MaterialPageRoute(builder: (context)=>HowToPray()));

           },
          icon: Icons.how_to_vote_rounded,
          label: 'كيفيه صلاه الجنازه',
        ),
         SidebarXItem(
           onTap: (){
             Navigator.push(context, MaterialPageRoute(builder: (context)=>ShareApp()));

           },
          icon: Icons.share,

          label: 'مشاركة',
        ),
         SidebarXItem(
           onTap: (){
             Navigator.push(context, MaterialPageRoute(builder: (context)=>HowToUse()));

           },
          icon: Icons.how_to_reg_rounded,

          label: 'كيفيه الاستخدام',
        ),
         SidebarXItem(
           onTap: (){


             Navigator.push(context, MaterialPageRoute(builder: (context)=>About()));

           },
          icon: Icons.info,

          label: 'عن التطبيق',
        ),
         SidebarXItem(
           onTap: (){
             Navigator.push(context, MaterialPageRoute(builder: (context)=>RateMyApp()));

           },
          icon: Icons.star_rate_outlined,

          label: 'تقييم التطبيق',
        ),
         SidebarXItem(
           onTap: (){
             Navigator.push(context, MaterialPageRoute(builder: (context)=>Setting()));

           },
          icon: Icons.settings,

          label: ' الاعدادات',
        ),
         SidebarXItem(
           onTap: (){
             Navigator.push(context, MaterialPageRoute(builder: (context)=>ContactWithUs()));

           },
          icon: Icons.messenger,

          label: ' تواصل معنا',
        ),
      ],
    );
  }
}

