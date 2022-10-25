import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tovo/shared/TovoCubit/TovoCubit.dart';
import 'package:tovo/shared/TovoCubit/TovoCubitStates.dart';
import 'package:tovo/shared/components/components.dart';

class flowerWeather extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<flowerCubit, flowerStates>
      (builder: (context, state)
    {
      flowerCubit flwCubit = flowerCubit.get(context);
      return Scaffold(
        appBar: AppBar(toolbarHeight: 0,backgroundColor: const Color(0xFFDAD6D6), elevation: 0,) ,
        body:  flowerCubit.get(context).isConnect ? Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 10),
            child: Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              decoration: BoxDecoration(color: Theme.of(context).textTheme.headline2?.color, borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: (Theme.of(context).textTheme.bodyText1?.color)!, width: 3)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Row(children:
                    [
                      Icon(Icons.wb_sunny_outlined, color: Theme.of(context).textTheme.bodyText1?.color, size: 25,),
                      SizedBox(width: 5,),
                      Text("Weather Status", style: TextStyle(color: Theme.of(context).textTheme.bodyText1?.color,
                          fontSize: 23, fontWeight: FontWeight.bold),),
                      Spacer(),
                      IconButton(onPressed: ()
                      {
                        flwCubit.getWeatherData();
                      }, icon: Icon(Icons.restart_alt, color: Theme.of(context).textTheme.bodyText1?.color, size: 35,)),
                    ],),
                  ),

                ],),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              decoration: BoxDecoration(color: Theme.of(context).textTheme.headline1?.color, borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: (Theme.of(context).textTheme.bodyText1?.color)!, width: 3)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: Row(
                          children:
                          [
                            Image(image: NetworkImage("http://openweathermap.org/img/wn/${flwCubit.weatherRecord['weather'][0]['icon']}@2x.png"),
                              width: 70, height: 70, color: Color(0xFFC8C2F1),),
                            Text("${flwCubit.weatherRecord['weather'][0]['main']}, ${flwCubit.weatherRecord['weather'][0]['description']}",
                              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),)
                          ],),
                      ),
                      decoration: BoxDecoration(color: Theme.of(context).textTheme.headline3?.color,
                          border: Border.all(color: (Theme.of(context).textTheme.bodyText1?.color)!, width: 3),
                          borderRadius: BorderRadius.circular(15)),),
                  ),
                  SizedBox(height: 20,),
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                        [
                          Container(
                              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Theme.of(context).textTheme.headline3?.color,
                                  border: Border.all(color: (Theme.of(context).textTheme.bodyText1?.color)!, width: 3)),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children:
                                [
                                  Text("Temperature Data", textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.black,
                                        fontWeight: FontWeight.bold),),
                                  SizedBox(width: 5,),
                                  Icon(Iconsax.sun),
                                ],)
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            child: Column(children:
                            [
                              Text('Avg Temperature: ${(flwCubit.weatherRecord['main']['temp'] - 273.15).round()}°C, '
                                  'What It Feels Like: ${(flwCubit.weatherRecord['main']['feels_like'] - 273.15).round()}°C',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Theme.of(context).textTheme.bodyText1?.color),),
                              Text('Min Temperature: ${(flwCubit.weatherRecord['main']['temp_min'] - 273.15).round()}°C, Max Temperature: ${(flwCubit.weatherRecord['main']['temp_max'] - 273.15).round()}°C',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Theme.of(context).textTheme.bodyText1?.color),),
                            ],),
                          ),
                          Container(
                              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Theme.of(context).textTheme.headline3?.color,
                                  border: Border.all(color: (Theme.of(context).textTheme.bodyText1?.color)!, width: 3)),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children:
                                [
                                  Text("General Wind Data", textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.black,
                                        fontWeight: FontWeight.bold),),
                                  SizedBox(width: 5,),
                                  Icon(Iconsax.wind),
                                ],) ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            child: Column(children:
                            [
                              Text('Wind Speed (miles per hour): ${(flwCubit.weatherRecord['wind']['speed']).round()} Mph, '
                                  'Degree: ${(flwCubit.weatherRecord['wind']['deg']).round()}°',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Theme.of(context).textTheme.bodyText1?.color,),),
                            ],),
                          ),
                          Container(
                              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Theme.of(context).textTheme.headline3?.color,
                                  border: Border.all(color: (Theme.of(context).textTheme.bodyText1?.color)!, width: 3)),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children:
                                [
                                  Text("General Weather Data", textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.black,
                                        fontWeight: FontWeight.bold),),
                                  SizedBox(width: 5,),
                                  Icon(Icons.select_all),
                                ],) ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            child: Column(children:
                            [
                              Text('Pressure: ${(flwCubit.weatherRecord['main']['pressure']).round()} PA, '
                                  'Humidity: ${(flwCubit.weatherRecord['main']['humidity']).round()} %, Visibility: ${(flwCubit.weatherRecord['visibility']/1000).round()} Km',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Theme.of(context).textTheme.bodyText1?.color),),
                            ],),
                          ),


                        ],)
                  ),
                ],),
            ),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              decoration: BoxDecoration(color: Theme.of(context).textTheme.headline1?.color, borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: (Theme.of(context).textTheme.bodyText1?.color)!, width: 3)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                    child: Padding(padding: const EdgeInsets.all(0), child:Container(
                      child: Row(children:
                      [
                        Text("Suggestion(s) Based on Current Weather",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                        SizedBox(width: 5),
                        Icon(Icons.add_card_rounded)
                      ],),
                      decoration: BoxDecoration(color: Theme.of(context).textTheme.headline3?.color,
                          border: Border.all(color: (Theme.of(context).textTheme.bodyText1?.color)!, width: 3),
                          borderRadius:BorderRadius.circular(10) ),
                      padding: EdgeInsets.all(10),),),
                  ),
                  SizedBox(height: 5,),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children:
                    [
                      Text("You have ${flwCubit.outRecords.length} outdoor task(s)", style: TextStyle(fontWeight: FontWeight.bold,
                          fontSize: 19, color: Theme.of(context).textTheme.bodyText1?.color),),
                      SizedBox(height: 3,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Text("${returnReport(flwCubit.weatherRecord['main']['temp']-273.15)}",
                          style: TextStyle(color: Theme.of(context).textTheme.bodyText1?.color),),
                      ),
                    ],),),
                ],),
            ),
          ),

        ],) : Padding(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 10),
          child: Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            decoration: BoxDecoration(color: Theme.of(context).textTheme.headline1?.color, borderRadius: BorderRadius.circular(10),
                border: Border.all(color: (Theme.of(context).textTheme.bodyText1?.color)!, width: 3)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Row(children:
                  [
                    Text("No Internet Connection", style: TextStyle(color: Theme.of(context).textTheme.bodyText1?.color,
                        fontSize: 20, fontWeight: FontWeight.bold),),
                    Spacer(),
                    Icon(Icons.clear_all_outlined, color: Theme.of(context).textTheme.bodyText1?.color, size: 35,)
                  ],),
                ),


              ],),
          ),
        ),



      );
    },
        listener: (content, state){});
  }

}




