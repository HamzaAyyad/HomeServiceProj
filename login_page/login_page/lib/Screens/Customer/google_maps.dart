import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:login_page/HelpWidget/Location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_page/Screens/Customer/send_request.dart';
import '../../constants.dart';

const double CAMERA_ZOOM = 16;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 30;
var _SOURCE_LOCATION;
var _DEST_LOCATION = LatLng(32.10077638764247, 36.1881733706461);

class GoogleMaps extends StatefulWidget {


  final String specialization;
  GoogleMaps({this.specialization});



  @override
  _MyGoogleMaps createState() => _MyGoogleMaps();
}

class _MyGoogleMaps extends State<GoogleMaps> {


  static CameraPosition _map =
  CameraPosition(target: LatLng(32.100015, 36.185597), zoom: 12);
  //CameraPosition(target: LatLng(31.963158, 35.930359), zoom: 16);

  // 32.100015, 36.185597
  GoogleMapController _controller;
  Set<Marker> _markers = {};
  CameraPosition cam;

  String name='';
  String price_range='';
  double rating=1;
  String imageurl='';
  double pin=-100.0;
  String workerEmail = '';


  @override
  void initState() {
    super.initState();
    getlocation();
    getData();
  }

  void getData() async {
    String id;

    var collection = FirebaseFirestore.instance.collection('User');
    await collection
        .where('type', isEqualTo: 1)
        .where('specialization', isEqualTo: widget.specialization)
        .get()
        .then((QuerySnapshot snapshot) async => {
      snapshot.docs.forEach((f) async {
        id = f.reference.id;
        var docSnapshot = await collection.doc(id).get();
        Map<String, dynamic> data = docSnapshot.data();
        setState(() {
          _markers.add(Marker(
            markerId: MarkerId(f.reference.id),
            position: LatLng(data['location'].latitude,
                data['location'].longitude),
            onTap: () {
              setState(() {
                workerEmail = data['email'];
                name= data['full_name'];
                price_range= data['price_range'];
                rating= double.parse(data['rating'].toString());
                imageurl= data['imageURL'];
                pin= 0;

              });

            },
          ),

          );
        });
      })
    });
  }

  void getlocation() async {
    Location loc = Location();
    await loc.getCurrentLocation();
    _SOURCE_LOCATION = LatLng(loc.latitude, loc.longitude);
    cam = CameraPosition(
      target: _SOURCE_LOCATION,
      zoom: CAMERA_ZOOM,
      bearing: CAMERA_BEARING,
      tilt: CAMERA_TILT,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request ${widget.specialization}'),
        backgroundColor: kDarkBlue,
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
            onMapCreated: (GoogleMapController controller) {
              setState(() {
                _controller = controller;
                getlocation();
                // setMapPins();
              });
            },
          ),
          AnimatedPositioned(
            top: pin,
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
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundImage:
                          imageurl.isEmpty?
                          AssetImage('images/profilePic.png')
                              : NetworkImage(imageurl),
                        )
                      //Image.asset('images/profilePic.png')
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(name, style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold)),
                            // workerLocation.name != null ? workerLocation.name :

                            Text("Price Range: "+price_range+"\$",
                                style: TextStyle(fontSize: 12, color: Colors.grey)),

                            Row(
                                mainAxisSize: MainAxisSize.min,
                                children: getStarsIcon(rating)
                                // List.generate(5, (index) {
                                //   return Icon(
                                //     index < rating ? Icons.star : Icons.star_border,
                                //     color: Colors.orange,
                                //     size: 20,
                                //   );
                                // }
                                // )

                            )
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
                        onPressed: () {
                          //Navigator.pushNamed(context, '/sendrequest');
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SendRequest(workerEmail: workerEmail)),
                          );
                        },
                        child: Text(
                          'Request',
                          style: TextStyle(color: Colors.white),
                        ),
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
    // setMapPins();
  }

  List<Widget> getStarsIcon(double rating) {
    List<Widget> stars = [];
    for (int i = 0; i < rating - 0.5; i++) {
      stars.add(
        Icon(
          Icons.star,
          color: kStarColor,
          size: 20,
        ),
      );
    }
    if(rating % 1 != 0)
      stars.add(
        Icon(
          Icons.star_half,
          color: kStarColor,
          size: 20,
        ),
      );
    for(int i = 0 ; i< 5- rating - 0.5 ; i++)
      stars.add(
        Icon(
          Icons.star_border,
          color: kStarColor,
          size: 20,
        ),
      );

    return stars;
  }


}

