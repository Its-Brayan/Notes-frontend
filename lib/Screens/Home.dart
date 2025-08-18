import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
    body: SafeArea(

      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
           ListTile(
             leading: CircleAvatar(
               radius: 20,

               child: Image.network('https://cdn-icons-png.flaticon.com/128/3048/3048122.png',
                 width: 25,
                 height: 30,
                 fit: BoxFit.cover,
               ),
             ),
             title: Text('Hello Brayan',
             style: TextStyle(
               color: Colors.white,
               fontWeight: FontWeight.bold,
             ),
             ),
               trailing:Row(
                mainAxisAlignment:MainAxisAlignment.end,
                 mainAxisSize: MainAxisSize.min,
                 children: [

                   IconButton(onPressed: (){}, icon:Icon(Icons.search),
                   ),
                   IconButton(onPressed: (){}, icon:Icon(Icons.settings),
                   ),

                   ]
               )
           ),
            SizedBox(height: 10),
            Divider(

              color: Colors.grey.shade100,
            ),
            SizedBox(height: 30),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
               Expanded(
                 child: Card(

                   color: Colors.grey.shade500,
                   elevation: 20,
                   child: ListTile(

                     tileColor: Colors.grey.shade600,
                     title: Text("Beautiful notes app Ui concept",
                     style: TextStyle(
                       color: Colors.white,
                     ),),
                     subtitle: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris vehicula maximus nisl vitae volutpat. Praesent elit leo, ornare iaculis mattis sed, tempor eu sem. Duis sodales lectus quis venenatis egestas.'),
                     onTap: (){
                       Navigator.pushNamed(context, '/takenotes');
                     }
                   ),

                 ),
               ),
               Expanded(
                 child: Card(
                   surfaceTintColor: Colors.blue,

                   color: Colors.grey.shade500,
                   elevation: 20,
                   child: ListTile(
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(20),
                     ),
                       tileColor: Colors.grey.shade600,
                       title: Text("Beautiful notes app Ui concept",
                         style: TextStyle(
                           color: Colors.white,
                         ),),
                       subtitle: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris vehicula maximus nisl vitae volutpat. Praesent elit leo, ornare iaculis mattis sed, tempor eu sem. Duis sodales lectus quis venenatis egestas.'),
                       onTap: (){
                         Navigator.pushNamed(context, '/takenotes');
                       }
                   ),

                 ),
               ),
             ],
           )

          ],

        ),
      ),
    ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        elevation: 20,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        onPressed: (){
          Navigator.pushNamed(context, '/takenotes');
        },
        child: Icon(Icons.add,
        size: 30,
        color: Colors.white,),
      ),
    );
  }
}
