import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '/authentication/car_info_screen.dart';
import '/authentication/login_screen.dart';
import '/global/global.dart';
import '/rolls/roll_options.dart';
import '/widgets/progress_dialog.dart';


class SignUpScreen extends StatefulWidget
{

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}
enum Gender { male, female, other }

class _SignUpScreenState extends State<SignUpScreen>
{
  TextEditingController nametextEditingController = TextEditingController();
  TextEditingController emailtextEditingController = TextEditingController();
  TextEditingController phonetextEditingController = TextEditingController();
  TextEditingController passwordtextEditingController = TextEditingController();
  TextEditingController confirmpasswordtextEditingController = TextEditingController();




  validateForm()
  {
    if(nametextEditingController.text.length < 3)
      {
        Fluttertoast.showToast(msg: "name must be atleast 3 characters");

      }
    else if(!emailtextEditingController.text.contains("@"))
      {
        Fluttertoast.showToast(msg: "Email address is not vaild.");
      }
    else if(phonetextEditingController.text.isEmpty)
      {
        Fluttertoast.showToast(msg: "Phone Number is required.");
      }
    else if(phonetextEditingController.text.length < 10)
      {
        Fluttertoast.showToast(msg: "Phone Number invaild");
      }

    else if(passwordtextEditingController.text.length < 8)
      {
        Fluttertoast.showToast(msg: "Password must be atleast 6 Characters.");
      }
    else if(confirmpasswordtextEditingController.text != passwordtextEditingController.text){
      Fluttertoast.showToast(msg: "password doesn't match.");
    }
    else{
      saveCarInfonow();
    }
  }


  saveCarInfonow() async
  {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c)
        {
          return ProgressDialog(message:"Processing, Please Wait",);
        }
    );

    final User? firebaseUser = (
        await fAuth.createUserWithEmailAndPassword(
          email: emailtextEditingController.text.trim(),
          password: passwordtextEditingController.text.trim(),
        ).catchError((msg){
          Navigator.pop(context);
          Fluttertoast.showToast(msg: "Error: " + msg.toString());
        })
    ).user;

    if(firebaseUser != null)
    {
      Map CarMap =
      {
        "id": firebaseUser.uid,
        "name": nametextEditingController.text.trim(),
        "email":emailtextEditingController.text.trim(),
        "phone":phonetextEditingController.text.trim(),

      };

      DatabaseReference carsRef = FirebaseDatabase.instance.ref().child("Cars");
      carsRef.child(firebaseUser.uid).set(CarMap);

      currentFirebaseUser = firebaseUser;
      Fluttertoast.showToast(msg: "Account has been Created");
      Navigator.push(context, MaterialPageRoute(builder: (c) => RollOption()));



    }
    else
      {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: "Account has not been Created ");
      }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF010536) ,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [

              const SizedBox(height: 10,),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset("images/pngegg.png"),
              ),
              const SizedBox(height: 10,),

             const  Text(
                "Register as Ally",
                 style: TextStyle(
                  fontSize: 26,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              ),

              TextField(
            controller: nametextEditingController,
            style: const TextStyle(
              color: Colors.white,
            ),
            decoration: const InputDecoration(
              labelText: "Name",
              hintText: "Name",
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color:Colors.grey),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color:Colors.grey),
              ),
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
              labelStyle: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ),

              TextField(
                controller: emailtextEditingController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: const InputDecoration(
                  labelText: "Email",
                  hintText: "Email",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color:Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color:Colors.grey),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ),

              TextField(
                controller: phonetextEditingController,
                keyboardType: TextInputType.phone,
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: const InputDecoration(
                  labelText: "Phone",
                  hintText: "Phone",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color:Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color:Colors.grey),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ),
              TextField(
                controller: passwordtextEditingController,
                keyboardType: TextInputType.text,
                obscureText: true,
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: const InputDecoration(
                  labelText: "Password",
                  hintText: "Password",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color:Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color:Colors.grey),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ),

              TextField(
                controller: confirmpasswordtextEditingController,
                keyboardType: TextInputType.text,
                obscureText: true,
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: const InputDecoration(
                  labelText: "Confirm Password",
                  hintText: "Confirm Password",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color:Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color:Colors.grey),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ),

              const SizedBox(height: 20,),

              ElevatedButton(
                onPressed: ()
                {
                  validateForm();

                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF15b495),
                ),
                child: const Text(
                  "Create Account",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),

                ),
              ),

              TextButton(
                child: Text(
                  "Already have an Account? Login Here",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (c)=> LoginScreen()));
                },
              ),


            ],
          ),
        ),
      ),
    );
  }
}
