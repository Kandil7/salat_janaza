// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:lottie/lottie.dart';
// import 'package:salat_janaza/cubit/cubit.dart';
// import 'package:salat_janaza/cubit/state.dart';
//
// import '../../services/database_helper.dart';
// import '../component/component.dart';
// import '../home.dart';
// // import com.facebook.FacebookSdk;
// // import com.facebook.appevents.AppEventsLogger;
//
//
//
// // reusable components
//
// // 1. timing
// // 2. refactor
// // 3. quality
// // 4. clean code
//
// class LoginScreen extends StatefulWidget {
//    LoginScreen({super.key});
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   var emailController = TextEditingController();
//   var passwordController = TextEditingController();
//   var formKey = GlobalKey<FormState>();
//   bool isPassword = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AppCubit,AppStates>(
//       listener: (context,state) {
//         if (state is AppFacebookLoginSuccessState || state is AppGoogleLoginSuccessState ) {
//           Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => HomePage()));
//         }
//       },
//       builder: (context,state) {
//         var cubit = AppCubit.get(context);
//         return Scaffold(
//           appBar: AppBar(),
//           body: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Center(
//               child: SingleChildScrollView(
//                 child: Form(
//                   key: formKey,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                    children: [
//
//                      Center(child: Lottie.asset('assets/images/login.json')
//                      ),
//
//                      MaterialButton(onPressed: ()async{
//                        await cubit.signInWithFacebook().then((value) {
//                          active=true;
//                          CachHelper.putData(key: 'active', value: true);
//                          return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage())
//                        );
//                        }).catchError((error) {
//                          CachHelper.putData(key: 'active', value: true);
//                          return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage())
//                        );
//                        });
//                      },
//                      child:Container(
//
//                         height: 50,
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(6)
//                         ),
//
//                        child: Row(
//                          children: [
//                            Image.asset('assets/images/img_1.png',width: 100,height: 100,),
//                             SizedBox(width: 10,),
//                            Text('Sign in with Facebook')
//                          ],
//                        ),
//                      ),
//                      ),
//                      SizedBox(height: 20,),
//
//                       MaterialButton(onPressed: ()async{
//                         await cubit.signInWithGoogle().then((value) {
//                           active=true;
//                           CachHelper.putData(key: 'active', value: true);
//                           return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage())
//
//                         );
//                         }).catchError((error) {
//                           CachHelper.putData(key: 'active', value: true);
//                           return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage())
//
//                         );
//                         });
//                       },
//                         child:Container(
//
//                           height: 50,
//                           decoration: BoxDecoration(
//                               color: Colors.redAccent,
//                               borderRadius: BorderRadius.circular(6)
//                           ),
//
//                           child: Row(
//                             children: [
//                               Image.asset('assets/images/img_3.png',width: 100,height: 100,),
//                               SizedBox(width: 10,),
//                               Text('Sign in with Google')
//                             ],
//                           ),
//                         ),
//                       ),
//                    ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       }
//     );
//   }
// }
