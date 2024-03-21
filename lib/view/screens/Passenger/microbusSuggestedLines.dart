import 'package:flutter/material.dart';

class MicrobusSuggestedLines extends StatelessWidget {
  const MicrobusSuggestedLines({super.key});
  static String id='MicrobusSuggestedLines';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(   iconTheme: const IconThemeData(color: Colors.green),),
      floatingActionButton: FloatingActionButton(onPressed: (){
        showModalBottomSheet(
          backgroundColor: Colors.purpleAccent
          ,context: context, builder: (BuildContext context){
         return Center(
          child: Container(width: 12,height: 12,
            color: Colors.white,
          ),
         );
        });
      }),
      
   
      

    );
    
  }
}