import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:login_page/HelpWidget/Location.dart';

import '../constants.dart';

const double CAMERA_ZOOM = 14;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 30;
var _SOURCE_LOCATION ;
var _DEST_LOCATION = LatLng(32.10077638764247, 36.1881733706461);



class GoogleMapsPainter extends StatefulWidget {
  @override
  _MyGoogleMapsPainter createState() => _MyGoogleMapsPainter();
}

class _MyGoogleMapsPainter extends State<GoogleMapsPainter> {
  @override
  void initState() {
    super.initState();
    getlocation();

  }


  static final CameraPosition _map = CameraPosition(target: LatLng(31.963158, 35.930359), zoom: 10);
  GoogleMapController _controller ;
  Set<Marker> _markers = {};
  CameraPosition cam;

  double pinPillPosition = -100;

  PinInformation currentlySelectedPin = PinInformation(
    avatarPath: '',
    location: LatLng(0, 0),
    locationName: '',
  );
  PinInformation customerLocation;
  PinInformation workerLocation;


  void getlocation() async {
    Location loc=Location();
    await loc.getCurrentLocation();
    _SOURCE_LOCATION = LatLng(loc.latitude, loc.longitude);
    cam = CameraPosition(target: _SOURCE_LOCATION , zoom: CAMERA_ZOOM ,bearing: CAMERA_BEARING,tilt: CAMERA_TILT,);


  }



  @override
  Widget build(BuildContext context) {
    // CameraPosition initialLocation = cam;
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Painter'),
        backgroundColor: kLightBlue,

      ),
      body: Stack(
        children: [
          GoogleMap(
            myLocationEnabled: true,
            compassEnabled: true,
            tiltGesturesEnabled: false,
            markers: _markers,
            mapType: MapType.normal,
            initialCameraPosition: _map,
            onMapCreated: (GoogleMapController controller){
              setState(() {
                _controller = controller;
                getlocation();
                setMapPins();
              });

            },
            // handle the tapping on the map
            // to dismiss the info pill by
            // resetting its position
            onTap: (LatLng location) {
              setState(() {
                pinPillPosition = -100;
              });
            },
          ),
          AnimatedPositioned(

            bottom: pinPillPosition,
            right: 0,
            left: 0,
            duration: Duration(milliseconds: 200),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.all(20),
                height: 70,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          blurRadius: 20,
                          offset: Offset.zero,
                          color: Colors.grey.withOpacity(0.5))
                    ]),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(left: 10),
                        width: 50,
                        height: 50,
                        child:CircleAvatar( radius: 50.0,
                          backgroundImage: AssetImage('images/profilePic.png'),)                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Asaad Mahmoud'),
                            // workerLocation.name != null ? workerLocation.name :

                            Text( 'Painter',style: TextStyle(
                                fontSize: 12, color: Colors.grey)),
                            //'Latitude: ${currentlySelectedPin.location.latitude.toString()}'
                            //workerLocation.spec != null ? workerLocation.spec : 'hamza KNN',

                            Text('0787144786', style:
                            TextStyle(fontSize: 12, color: Colors.grey)),
                            //‘Longitude: ${currentlySelectedPin.location.longitude.toString()}’
                            //workerLocation.phone != null ? workerLocation.phone :

                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: RaisedButton(
                        color: kLightBlue,
                        onPressed: (){
                          Navigator.pushNamed(context, '/sendrequest');
                        },
                        child: Text('Request' ,style: TextStyle(color: Colors.white),),

                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  onMapCreated(GoogleMapController controller) {
    setState(() {
      _controller = controller;
    });
    getlocation();
    setMapPins();
  }

  void setMapPins() {
    markers:
    _markers
      ..add(Marker(

          markerId: MarkerId("sourcePin"),
          infoWindow: InfoWindow(title: "My Location"),
          onTap: () {
            setState(() {
              currentlySelectedPin = customerLocation;
              pinPillPosition = 0;
            });
          },
          position: _SOURCE_LOCATION))
      ..add(Marker(

          markerId: MarkerId("destPin"),
          infoWindow: InfoWindow(title: "My Location"),
          onTap: () {
            setState(() {
              currentlySelectedPin = workerLocation;
              pinPillPosition = 0;
            });
          },
          position: _DEST_LOCATION));

    customerLocation = PinInformation(

      locationName: 'My Location',
      location: _SOURCE_LOCATION,
      avatarPath: 'images/profilePic.png',
      name: 'Abbas Mohammad',
      phone: '0787147786',

    );
    workerLocation = PinInformation(
      locationName: 'Worker Location',
      location: _DEST_LOCATION,
      avatarPath: 'images/profilePic.png',
      name: 'Anwar Mohammad',
      phone: '0787147786',
    );


  }
}

class PinInformation {
  String name;
  String phone;
  String avatarPath;
  LatLng location;
  String locationName;
  String spec='AC Maintenance';

  PinInformation({
    this.name,
    this.avatarPath,
    this.location,
    this.locationName,
    this.phone

  });
}
