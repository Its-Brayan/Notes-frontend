import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
class settings extends StatelessWidget {
  const settings({super.key});

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
          ListTile(
            leading: Icon(Icons.fingerprint_outlined),
            title: Text('Change 4-Digit pin'),
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
