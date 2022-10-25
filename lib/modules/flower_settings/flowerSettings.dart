import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tovo/modules/flower_login/flowerLogin.dart';
import 'package:tovo/shared/components/components.dart';
import '../../shared/TovoCubit/TovoCubit.dart';
import '../../shared/TovoCubit/TovoCubitStates.dart';
class flowerSettings extends StatefulWidget
{

  @override
  State<flowerSettings> createState() => _flowerSettingsState();
}

class _flowerSettingsState extends State<flowerSettings> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<flowerCubit, flowerStates>(builder: (context, state)
    {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(toolbarHeight: 0,backgroundColor: const Color(0xFFDAD6D6), elevation: 0,) ,
        body: Column(children:
        [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 10),
            child: Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              decoration: BoxDecoration(color: Theme.of(context).textTheme.headline2?.color, borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: (Theme.of(context).textTheme.bodyText1?.color)!, width: 3)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                    child: Row(children:
                    [
                      Icon(Icons.settings_applications_outlined, color: Theme.of(context).textTheme.bodyText1?.color, size: 25,),
                      SizedBox(width: 5,),
                      Text("Settings", style: TextStyle(color: Theme.of(context).textTheme.bodyText1?.color, fontSize: 23,
                          fontWeight: FontWeight.bold),),
                    ],),
                  ),


                ],),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(color: Theme.of(context).textTheme.headline1?.color, borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: (Theme.of(context).textTheme.bodyText1?.color)!, width: 3)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: Row(children:
                    [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                        [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:
                              [
                                Text("TOVO - Tasks Management App 0.1", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17
                                ,color: (Theme.of(context).textTheme.bodyText1?.color)!),),
                                SizedBox(height: 20,),

                                Container(
                                  padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                                      color: Theme.of(context).textTheme.headline3?.color,
                                      border: Border.all(color: (Theme.of(context).textTheme.bodyText1?.color)!, width: 3)),
                                  child: Text('Username: ${flowerCubit.get(context).user[0][0]}', textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.black,
                                        fontWeight: FontWeight.bold),), ),
                                Container(
                                  padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                                      color: Theme.of(context).textTheme.headline3?.color,
                                      border: Border.all(color: (Theme.of(context).textTheme.bodyText1?.color)!, width: 3)),
                                  child: Text('Password: ${flowerCubit.get(context).user[0][1]}', textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.black,
                                        fontWeight: FontWeight.bold),), ),
                                Container(
                                  padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                                      color: Theme.of(context).textTheme.headline3?.color,
                                      border: Border.all(color: (Theme.of(context).textTheme.bodyText1?.color)!, width: 3)),
                                  child: Text('Email Address: ${flowerCubit.get(context).user[0][2]}', textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.black,
                                        fontWeight: FontWeight.bold),), ),
                                Container(
                                  padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                                      color: Theme.of(context).textTheme.headline3?.color,
                                      border: Border.all(color: (Theme.of(context).textTheme.bodyText1?.color)!, width: 3)),
                                  child: Text('Phone Number: ${flowerCubit.get(context).user[0][3]}', textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.black,
                                        fontWeight: FontWeight.bold),), ),
                              ],),
                          ),
                        ],)

                    ],),
                  ),

                ],),
            ),
          ),
          Padding(
            
            padding: EdgeInsets.all(20),
            child: Material(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: InkWell(
                splashColor: Colors.black,
                onTap: ()
                {
                  flowerCubit.get(context).signOut();
                  navigateTo(context, flowerLogin());
                },
                child: Container(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).textTheme.headline2?.color,
                      border: Border.all(color: (Theme.of(context).textTheme.bodyText1?.color)!, width: 3)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                    [
                      Text("Sign Out",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: (Theme.of(context).textTheme.bodyText1?.color)!,
                            fontWeight: FontWeight.bold, fontSize: 20),),
                      SizedBox(width: 5,),
                      Icon(Iconsax.logout, color: Color(0xFF6b54fe)),

                    ],)
                  , ),
              ),
            ),
          ),
          SizedBox(height: 150,),
          Text("Version 0.1 - developed by Tovix (Mostafa Mohamed Mostafa)", style:
          TextStyle(fontSize:10, color: (Theme.of(context).textTheme.bodyText1?.color)!,),)
        ],)
    );
    }, listener: (context, state){});

  }
}
