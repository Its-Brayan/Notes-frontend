import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class usernamepage extends StatefulWidget {
  const usernamepage({super.key});

  @override
  State<usernamepage> createState() => _usernamepageState();
}

class _usernamepageState extends State<usernamepage> {
  final TextEditingController _controller = TextEditingController();

  Future<void> _saveUsername() async{
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('username', _controller.text);
  Navigator.pushReplacementNamed(context, '/home');
}

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
             controller: _controller,

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
               _saveUsername();

           }, child: Text("Continue"))
           ]
       ),
     )),
    );
  }
}
