import 'package:firebase_auth/firebase_auth.dart';
import 'package:location/location.dart';

Future<LocationData> getLocation() async {
  Location location = new Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return null;
    }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      return null;
    }
  }

  _locationData = await location.getLocation();
  return _locationData;
}

Future<User> getCurrentUser() async {

  var auth = FirebaseAuth.instance;
  final User user = auth.currentUser;

  if(user == null) {
    print('Error');
  }
  return user;
}


bool validateEmail(String email){
  return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
}
bool validatePassword(String password){
  return password.length >= 6 ? true : false;
}

bool validateMobile(String number){
  int num;
  try{
    num = int.parse(number);
  }catch (e){
    return false;
  }

  print(number.length);
  if (number.length < 10)
    return false;
  else
    return true;
}



