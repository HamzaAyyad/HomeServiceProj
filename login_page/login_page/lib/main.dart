import 'package:flutter/material.dart';
import 'package:login_page/Google_Map_Screen/GMElec.dart';
import 'package:login_page/Google_Map_Screen/GMPainter.dart';
import 'package:login_page/Google_Map_Screen/GMPlumber.dart';
import 'package:login_page/Screens/Customer/google_maps.dart';
import 'package:login_page/Google_Map_Screen/GMgeneral.dart';
import 'package:login_page/Screens/Customer/request.dart';
import 'package:login_page/Screens/Customer/send_request.dart';
import 'package:login_page/Screens/first_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:login_page/Screens/Customer/home_page.dart';
import 'package:login_page/Screens/home_page_worker.dart';
import 'package:login_page/Screens/Customer/my_requets.dart';
import 'package:login_page/Screens/pending_request_worker.dart';
import 'package:login_page/Screens/signin.dart';
import 'package:login_page/Screens/worker_signup.dart';
import 'package:login_page/Screens/worker_profile.dart';
import 'package:login_page/constants.dart';
import 'package:login_page/Screens/finished_request.dart';
import 'Google_Map_Screen/GMAC.dart';
import 'Navigation.dart';
import 'Screens/WorkerNavigation.dart';
import 'Screens/contact_us.dart';
import 'Screens/Customer/customer_signup.dart';
import 'Screens/faq.dart';
import 'Screens/Customer/customer_profile.dart';
import 'Screens/shops_map.dart';
import 'Screens/finished_information.dart';
import 'Screens/signin_worker.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/home': (context) => Home(),
        '/signin': (context) => SignIn(),
        '/signup_customer': (context) => CustomerSignup(),
        '/signup_worker': (context) => WorkerSignup(),
        '/home_page': (context) => HomePage(),
        '/faq': (context) => FAQPage(),
        '/profile': (context) => ProfilePage(),
        '/worker_profile': (context) => ProfilePageWorker(),
        '/finished_request': (context) => FinishedRequest(),
        '/shops': (context) => ShopsMaps(),
        '/myrequests': (context) => MyRequests(),
        //'/contact': (context) => ContactHomeService(),
        '/homeworker': (context) => HomePageWorker(),
        //'/requestworker': (context) => RequestWorker(),
        '/request': (context) => RequestPage(),
        '/sendrequest': (context) => SendRequest(),
        '/finishedinfo': (context) => FinishedRequestInfo(),
        '/acMap': (context) => GoogleMapsAC(),
        '/elecMap': (context) => GoogleMapsElec(),
        '/generalMap': (context) => GoogleMapsGeneral(),
        '/painterMap': (context) => GoogleMapsPainter(),
        '/plumberMap': (context) => GoogleMapsPlumber(),
        '/tilerMap': (context) => GoogleMaps(),
        '/signinWorker' : (context) => SigninWorker(),
        '/Navigation' :(context) => MyBottomNavigationBar(),
        '/WorkerNavigation' :(context) =>WorkerBottomNavigationBar(),




      },
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: _fbApp,
        builder: (context, snapshot) {
          if (snapshot.hasError)
            return Text('daaaaaaaaamn error');
          else if (snapshot.hasData) {
            print('noiceeee');
            return Home();
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      //
    );
  }
}
