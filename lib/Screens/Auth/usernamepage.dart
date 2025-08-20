import 'package:flutter/material.dart';
class usernamepage extends StatelessWidget {
  const usernamepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
     body: SafeArea(child: Center(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
             Text("Please enter your name",
             style: TextStyle(
               color: Colors.white,
               fontSize: 20,
             ),

             ),
         SizedBox(height: 10),
         Padding(
           padding: const EdgeInsets.all(15.0),
           child: Form(child: TextFormField(
             decoration: InputDecoration(
               border:OutlineInputBorder(
                 borderRadius: BorderRadius.circular(40),
                 borderSide: BorderSide(
                   color: Colors.orange,
                 ),
               ),
               hintText: 'Name',
               hintStyle: TextStyle(
                 color: Colors.white,
               ),

           ),
           )

           ),
         ),
         SizedBox(height: 10),
           ElevatedButton(

             style: ElevatedButton.styleFrom(
               minimumSize: Size(350, 50),
             ),
               onPressed: (){
             Navigator.pushNamed(context, '/home');
           }, child: Text("Continue"))
           ]
       ),
     )),
    );
  }
}
