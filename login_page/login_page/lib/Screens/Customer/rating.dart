import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:login_page/constants.dart';

class CustomerRating extends StatefulWidget {

  final String id;
  CustomerRating({this.id});
  @override
  _CustomerRatingState createState() => _CustomerRatingState();
}
final TextStyle lblStyle = TextStyle(
  fontSize: 18.0,
  color: Colors.black87);
final TextStyle hintstyle = TextStyle(
  fontSize: 18.0,
  color: Colors.black12);
class _CustomerRatingState extends State<CustomerRating> {
  String Feedback='';
  double rating=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rating Customer') ,
        backgroundColor: kDarkBlue,
      ),
      body:
      Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            end: Alignment.topRight,
            begin: Alignment.bottomLeft,
            colors: [
              Color(0xFF0e233f),
              //kDarkBlue,
              Colors.black,
            ],
          ),
        ),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: RatingBar.builder(
                initialRating: 3,
                minRating: 1,
                itemSize: 50,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rate) {
                  rating=rate;
                },
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Center(
              child: Container(
                margin: EdgeInsets.all(10.0),
                child: TextField(
                  maxLines: 1,
                  //controller: control,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kDarkBlue),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(1),
                      borderSide: BorderSide(width: 1, color: kDarkBlue),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    labelStyle: lblStyle,
                    icon: Icon(Icons.feedback , color: Colors.white,),
                    hintText: 'Your Feedback',
                    hintStyle: hintstyle,
                  ),
                  // keyboardType: keyboard,
                  //
                  onChanged: (value) {
                    Feedback = value;
                  },
                ),
              ),

            ),
            SizedBox(
              height: 35,
            ),
            Padding(
              padding: EdgeInsets.only(left:50,right:50),
              child: Container(
                  width: 150,
                  height: 50,
                  color: Colors.deepOrange,
                  child: GestureDetector(
                    onTap: () {

                      print('send');
                      String problem;
                      if(rating == 0)
                        problem = 'Please rate the request first.';
                      if(Feedback.isEmpty)
                        problem = 'Please write your feadback first.';

                      if(problem != null)
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: Text('Error'),
                            content: Text(problem),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'OK'),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      else
                        sendRating();

                      updateWorkerRating();


                      Navigator.pop(context, 'Ok');



                    },
                    child: Center(
                      child: Text(
                        'Send Feedback',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )),
            ),



          ],
        ),
      ),

    );
  }


  void sendRating() async {

    var collection = FirebaseFirestore.instance.collection('Request');
    String id = widget.id;
    await collection.doc(id).update({
      'rating': rating,
      'feedback': Feedback,
    });

  }

  // void updateWorkerRating() async {
  //   var collection = FirebaseFirestore.instance.collection('Request');
  //   String id = widget.id;
  //
  //   String worker;
  //   double totalRating; // new worker old rating
  //   double numberOfRatings;
  //   double oldRating; // old worker old rating
  //
  //   var docSnapshot = await collection.doc('$id').get();
  //   if (docSnapshot.exists) {
  //     Map<String, dynamic> data = docSnapshot.data();
  //     worker = data['worker_email'];
  //   }
  //
  //   collection = FirebaseFirestore.instance.collection('User');
  //
  //   await collection
  //       .where('email', isEqualTo: worker)
  //       .get()
  //       .then((QuerySnapshot snapshot) async => {
  //     snapshot.docs.forEach((f) async {
  //
  //       id = f.reference.id;
  //       var info = f.data();
  //       print(info['rating'].runtimeType);
  //       oldRating = double.parse('${info['rating']}');
  //       numberOfRatings = double.parse('${info['number_of_ratings']}');
  //
  //
  //       double newNumbeOfRatings = numberOfRatings + 1;
  //       totalRating = (rating + oldRating * numberOfRatings) / newNumbeOfRatings;
  //
  //       print(totalRating);
  //
  //       //new rating = rating + oldRating(numberOfRatings) / numberOfRatings++
  //
  //       collection
  //           .doc(id)
  //           .update({
  //
  //
  //       });
  //     })
  //   });
  //
  // }


  void updateWorkerRating() async {
    var collection = FirebaseFirestore.instance.collection('Request');
    String id = widget.id;

    String worker;
    double totalRating=0;
    double numberOfRatings=0;
    double averageRating; // new worker old rating

    var docSnapshot = await collection.doc('$id').get();
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data();
      worker = data['worker_email'];
    }
    var info;
    await collection
        .where('worker_email', isEqualTo: worker)
        .get()
        .then((QuerySnapshot snapshot) async => {
      snapshot.docs.forEach((f) async {
        info = f.data();
        if(info['rating']==0)
        //any thing
          print('nkjvndfjkvn');
        else
        {
          print('----------------------------------');
          print('${info['customer_email']}');
          totalRating=totalRating +info['rating'] ;
          numberOfRatings=numberOfRatings+1;
        }

      })
    });
    totalRating=totalRating + rating ;
    //numberOfRatings=numberOfRatings+1;
    averageRating=totalRating/numberOfRatings;

    print('average rating $averageRating');
    print(numberOfRatings);

    collection = FirebaseFirestore.instance.collection('User');

    String workerId ='';
    await collection
        .where('email', isEqualTo: worker)
        .get()
        .then((QuerySnapshot snapshot) async => {
      snapshot.docs.forEach((f) async {
        workerId = f.reference.id;
      })
    });


    //double rounded = Math.Round(averageRating * 2, MidpointRounding.AwayFromZero) / 2;
    double roundedRating =  ((averageRating*2).round()) /2 ;
    print(roundedRating);

    collection
        .doc(workerId)
        .update({'rating':roundedRating});

    collection = FirebaseFirestore.instance.collection('Request');
    collection
        .doc(widget.id)
        .update({'isRated':true});

  }





}