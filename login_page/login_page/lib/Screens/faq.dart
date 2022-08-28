import 'package:flutter/material.dart';
import 'package:login_page/HelpWidget/NavigationDrawer.dart';
import 'package:login_page/constants.dart';


class FAQPage extends StatelessWidget {
  const FAQPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // drawer: NavigationDrawer(),
      appBar: AppBar(
          automaticallyImplyLeading: false,
        title: Text('Frequently Asked Questions'),
        backgroundColor: kDarkBlue,
      ),
      body: Container(
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

        child: SafeArea(
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    CreateListTile(Question: 'What is Home Service ?',Answer: 'Home Service is an app that helps customers find workers to do maintenance jobs and find the nearest general shops in their area',),

                    SizedBox(height: 20),
                    CreateListTile(Question: 'What are the worker\'s  specializations ?',Answer: 'We have a variety of workers specializing in: Plumbing, Electricians, AC maintenance, Tile workers, general maintenance and Painters.',),

                    SizedBox(height: 20),
                    CreateListTile(Question: 'Does the app show the workers on a map ?',Answer: 'Yes, the app shows the workers location on google maps and you can hire whichever worker you like from it.',),

                    SizedBox(height: 20),
                    CreateListTile(Question: 'How to hire a worker that I want ?',Answer: 'All you have to do is choose the type of work you want done and choose the desired worker from the map.',),

                    SizedBox(height: 20),
                    CreateListTile(Question: 'How to use the app?',Answer: 'First of all.. A quick step which is to create an account if you don\'t have one. After you login you will be taken to the app\'s home page where you can choose between a variety of categories. When you choose a specfic category suchas electrical you will be taken to a map that includes all the electrical workers available with their locations and info.',),


                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CreateListTile extends StatelessWidget {
  final String Question;
  final String Answer;
  CreateListTile({this.Question , this.Answer});


  @override
  Widget build(BuildContext context) {
    return ListTile(


      tileColor: kDarkBlue,
      //trailing: Icon(Icons.more_vert),
      isThreeLine: true,
      contentPadding: EdgeInsets.all(8),
      title: Text(Question, style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
      subtitle: Text(Answer,style: TextStyle(color: Colors.white70,fontSize:14)),
    );
  }
}
