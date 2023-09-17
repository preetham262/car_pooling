import 'package:Carpooling/tabPages/schedule_page.dart';
import 'package:flutter/material.dart';
import '/global/global.dart';
import '/splashScreen/splash_screen.dart';


class ProfileTabPage extends StatefulWidget {
  const ProfileTabPage({Key? key}) : super(key: key);

  @override
  State<ProfileTabPage> createState() => _ProfileTabPageState();
}

class _ProfileTabPageState extends State<ProfileTabPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: (
          Center(
            child: ElevatedButton(
              child: Text(
                "sign Out",
                textAlign: TextAlign.start,
              ),
              onPressed: (){
                fAuth.signOut();
                Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));

              },
            ),
          )
      ),
    );
  }
}


class OriginalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Original Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to the schedules page when the button is pressed
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SchedulesPage(), // Navigate to the schedules page
              ),
            );
          },
          child: Text('View Schedules'),
        ),
      ),
    );
  }
}
