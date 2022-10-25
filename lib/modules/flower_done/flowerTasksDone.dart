import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/TovoCubit/TovoCubit.dart';
import '../../shared/TovoCubit/TovoCubitStates.dart';
import '../../shared/components/components.dart';
class flowerDone extends StatelessWidget
{

  Widget build(BuildContext context) {
    return BlocConsumer<flowerCubit, flowerStates>
      (builder: (context, state)
    {
      flowerCubit flwCubit = flowerCubit.get(context);
      return Scaffold(
        appBar: AppBar(toolbarHeight: 0,backgroundColor: const Color(0xFFDAD6D6), elevation: 0,) ,
        body: Column(children:
        [
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
                      Icon(Icons.check_box_outlined, color: Theme.of(context).textTheme.bodyText1?.color, size: 25,),
                      SizedBox(width: 5,),
                      Text("Done Tasks", style: TextStyle(color: Theme.of(context).textTheme.bodyText1?.color,
                          fontSize: 23, fontWeight: FontWeight.bold),),
                      Spacer(),
                      IconButton(onPressed: ()
                      {
                        flwCubit.deleteDoneRecord(flwCubit.userID);
                        flwCubit.selectedList = flwCubit.allRecords;
                      }, icon: Icon(Icons.clear_all_outlined, color: Theme.of(context).textTheme.bodyText1?.color, size: 35,)),
                    ],),
                  ),


                ],),
            ),
          ),
          flwCubit.doneRecords.length != 0 ? Expanded(
            child: SingleChildScrollView(
              child: Column(children:

              [
                ListView.separated(itemBuilder: (context, index) =>
                    nonDisDefaultPanelBuilder(model: flwCubit.doneRecords[index], backgroundColor: const Color(0xFFeddfaf),
                        min_color: const Color(0xFF8dc49a), name_color: Colors.white, context: context),
                  separatorBuilder: (context, index)
                  {
                    return SizedBox(height: 10);},
                  itemCount: flwCubit.doneRecords.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true, padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  physics: NeverScrollableScrollPhysics(),),
              ],),
            ),
          ): Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 300, 0, 0),
                  child: Center(child: Text("No Tasks Done",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color:  (Theme.of(context).textTheme.bodyText1?.color)!), ),),
                ),
                SizedBox(height: 20,),
              ],
            ),
          )
        ],),
      );
    }, listener: (context, state) {});
  }

}

