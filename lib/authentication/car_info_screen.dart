import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '/global/global.dart';
import '/splashScreen/splash_screen.dart';


class CarInfoScreen extends StatefulWidget
{


  @override
  State<CarInfoScreen> createState() => _CarInfoScreenState();
}



class _CarInfoScreenState extends State<CarInfoScreen>
{
  TextEditingController carModeltextEditingController = TextEditingController();
  TextEditingController carNumbertextEditingController = TextEditingController();
  TextEditingController carColortextEditingController = TextEditingController();


  List<String> carTypeList = ["Honda city","Hyndai i 10 ", "Hyndayi i 20","tata indica ","yamaha Fzs","trimpuh street triple"];
  String? selectedCarType;

  saveCarInfo()
  {
    Map carInfoMap =
    {
      "car_color": carColortextEditingController.text.trim(),
      "car_number": carNumbertextEditingController.text.trim(),
      "car_model": carModeltextEditingController.text.trim(),
      "type":selectedCarType,

    };
    DatabaseReference bikersRef = FirebaseDatabase.instance.ref().child("cars");
    bikersRef.child(currentFirebaseUser!.uid).child("car_details").set(carInfoMap);
    
    
    Fluttertoast.showToast(msg: "Car details has been saved. Congratulations");
    Navigator.push(context, MaterialPageRoute(builder: (c) => const MySplashScreen()));




  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [

              const SizedBox(height: 24,),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset("images/pngegg.png"),
              ),

              const SizedBox(height: 10,),

              const  Text(
                "Write Car Details",
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),

              TextField(
                controller: carModeltextEditingController,
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: const InputDecoration(
                  labelText: "Car Model",
                  hintText: "Car Model",
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
                controller: carNumbertextEditingController,
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: const InputDecoration(
                  labelText: "Car Number",
                  hintText: "Car Number",
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
                controller: carColortextEditingController,
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: const InputDecoration(
                  labelText: "Car Color",
                  hintText: "Car Color",
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


              DropdownButton(
                iconSize: 26,
                dropdownColor: Colors.black54,
                hint: const Text(
                    "Please Choose Car ",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ),

                ),
                value: selectedCarType,
                onChanged: (newVaule)
                {
                  setState(() {
                    selectedCarType = newVaule.toString();
                  });
                },
                items: carTypeList.map((car){
                   return DropdownMenuItem(
                       child: Text(
                         car,
                         style: const TextStyle(color: Color(0xFF15b495)),
                       ),
                     value: car,
                   );
                }).toList(),
              ),

              const SizedBox(height: 20,),

              ElevatedButton(
                onPressed: ()
                {
                  if(carColortextEditingController.text.isNotEmpty
                      && carNumbertextEditingController.text.isNotEmpty
                      && carModeltextEditingController.text.isNotEmpty && selectedCarType != null)
                  {
                    saveCarInfo();

                  }

                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF15b495),
                ),
                child: const Text(
                  "Save Now",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),

                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
