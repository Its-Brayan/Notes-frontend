import 'package:flutter/material.dart';
class notetaker extends StatelessWidget {
  const notetaker({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black54,
      body: SafeArea(child: Column(
        children: [
          ListTile(
         leading: IconButton(onPressed: (){
           Navigator.pop(context);
         }, icon:Icon(Icons.arrow_back,
         color: Colors.white,
         )
      ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(onPressed: (){}, icon:Icon(Icons.push_pin_outlined,
                color:Colors.white)
                ),
                IconButton(onPressed: (){}, icon:Icon(Icons.lock_outline,
                  color: Colors.white,
                ),
                ),
                IconButton(onPressed: (){}, icon:Icon(Icons.check_circle_outline,
                color: Colors.white,
                )
                ),
              ],
            ),
    ),
          SizedBox(height: 10),
          Divider(
            color: Colors.grey.shade100,
          ),
          SizedBox(height: 30),

          
          ]
      )),
    );
  }
}
