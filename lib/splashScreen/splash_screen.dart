import 'dart:async';

import 'package:flutter/material.dart';
import '/authentication/login_screen.dart';
import '/authentication/sign_up_screen.dart';
import '/global/global.dart';
import '/mainScreens/main_screen.dart';


class MySplashScreen extends StatefulWidget 
{
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}



class _MySplashScreenState extends State<MySplashScreen> 
{
  startTimer()
  {
    Timer(const Duration(seconds: 3), () async
    {
      if(await fAuth.currentUser !=null)
        {
          currentFirebaseUser = fAuth.currentUser;
          Navigator.push(context, MaterialPageRoute(builder: (c)=> MainScreen()));

        }
      else
        {
          Navigator.push(context, MaterialPageRoute(builder: (c)=> LoginScreen()));

        }


    });
  }

  @override
  void initState(){
    super.initState();

    startTimer();
  }


  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Color(0xFF010536),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Image.asset("images/pngegg.png"),

             const SizedBox(height: 10,),

              const Text(
                "Makes Life Easier ",
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF15b495),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
