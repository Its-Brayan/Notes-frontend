import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class settings extends StatefulWidget {
  const settings({super.key});

  @override
  State<settings> createState() => _settingsState();
}

class _settingsState extends State<settings> {
  @override
  void initState() {
    super.initState();
    checkPasswordStatus();
  }
  Future<void> setGlobalPassword(BuildContext context) async{
    String pin = '';
    final enteredPin = await showDialog<String>(
    context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Enter Password'),
          content: TextField(
            keyboardType: TextInputType.number,
            maxLength: 4,
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Enter Pin',
            ),
            onChanged: (value) {
              pin = value;
            }
        ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, null);
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, pin);
              },
              child: Text('OK'),
            ),
          ],
        );
      }
    );
    if(enteredPin != null && enteredPin.length == 4){
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('global_password', enteredPin);
      setState(() {
        hasPassword = true;

      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Pin set successfully'),
          backgroundColor: Colors.orange,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
  bool hasPassword = false;
  Future<void> checkPasswordStatus() async{
    final prefs = await SharedPreferences.getInstance();
    final globalPassword = prefs.getString('global_password');
    setState(() {
      hasPassword = globalPassword != null;
    });
  }
  Future<void> changeGlobalPassword(BuildContext context) async {
    await setGlobalPassword(context); // reuse the same dialog
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
appBar: AppBar(
 automaticallyImplyLeading: true,
  title: Text('Settings'),
),
      body: SafeArea(child: Column(
        children: [
          if(!hasPassword)
          ListTile(
            onTap: (){
              setGlobalPassword(context);
            },
            leading: Icon(Icons.fingerprint_outlined),
            title: Text('Set 4-Digit pin'),
          ),
          if(hasPassword)
          ListTile(
            leading: Icon(Icons.fingerprint_outlined),
            title: Text('Change 4-Digit pin'),
            onTap: (){
              changeGlobalPassword(context);
            },
          ),
          ListTile(
            onTap: (){
              Navigator.pushNamed(context, '/about');
            },
            leading:Icon(
              CupertinoIcons.exclamationmark_circle,

            ),
            title: Text('About'),
          )
        ],
      )),
    );
  }
}
