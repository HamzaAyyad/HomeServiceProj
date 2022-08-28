import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:login_page/HelpWidget/NavigationDrawer.dart';
import 'package:login_page/constants.dart';
import 'package:login_page/main.dart';

class ShopsMaps extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search for General Shops'),
        backgroundColor: kLightBlue,
      ),
      drawer: NavigationDrawer(),
      body: Container(
        child: MapSample(),
      ),
      // debugShowCheckedModeBanner: false,
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final locationNyeeh = LatLng(31.9829207625, 35.8462687746);
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(31.9829207625, 35.8462687746),
    zoom: 16,
  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(
        //change the alignment below nyeeh mann nyeeeh
        alignment: AlignmentDirectional.topCenter,
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            myLocationEnabled: true,
            markers: _markers
              ..add(
                Marker(
                  markerId: MarkerId('MyLocation'),
                  position: LatLng(31.9829207625, 35.8462687746),
                ),
              ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(bottom: 125),
          //   child: FloatingActionButton.extended(
          //     onPressed: () {
          //       Navigator.pushNamed(context, '/home_page');
          //     },
          //     label: Text(
          //       'Home Service',
          //       style: TextStyle(fontFamily: 'Pacifico', fontSize: 18),
          //     ),
          //     icon: Icon(Icons.location_on),
          //     backgroundColor: kLightBlue,
          //   ),
          // ),
          Padding(
            padding: EdgeInsets.only(right: 60,top: 6 ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  GeneralShopsRaisedButton(
                    onPress: () {
                      setState(() {
                        print('noice2');
                        return _markers
                          ..add(
                            Marker(
                              markerId: MarkerId('Pharmacy'),
                              position: LatLng(31.9821675436, 35.8484221995),
                            ),
                          );
                      });
                    },
                    text: 'Pharmacies',
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GeneralShopsRaisedButton(
                    onPress: () {
                      //View near markets here
                    },
                    text: 'Markets',
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GeneralShopsRaisedButton(
                    onPress: () {
                      //View near restaurants here
                    },
                    text: 'Restaurants',
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GeneralShopsRaisedButton(
                    onPress: () {
                      //View near restaurants here
                    },
                    text: 'Bakeries',
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GeneralShopsRaisedButton(onPress: () {}, text: 'Gas'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _currentLocation() async {
    final GoogleMapController controller = await _controller.future;
    LocationData currentLocation;
    var location = new Location();
    try {
      currentLocation = await location.getLocation();
    } on Exception {
      currentLocation = null;
    }

    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: LatLng(currentLocation.latitude, currentLocation.longitude),
        zoom: 17.0,
      ),
    ));
  }
}

class GeneralShopsRaisedButton extends StatelessWidget {
  GeneralShopsRaisedButton({@required this.onPress, @required this.text});

  Function onPress;
  String text;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPress,
      color: kLightBlue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

/*import 'package:flutter/material.dart';


class ShopsMaps extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('General Shops Maps',),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_location,size: 50,color: Colors.red,),
            Text('This is a map',style: TextStyle(fontSize: 50),),
          ],
        ),
      ),
    );
  }
}
*/
