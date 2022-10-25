import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tovo/shared/TovoCubit/TovoCubit.dart';
import 'package:tovo/shared/TovoCubit/TovoCubitStates.dart';
import '../../shared/components/components.dart';

class searchScreen extends StatelessWidget
{
  final TextEditingController searchController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<flowerCubit, flowerStates>
      (builder: (context, state) {
      flowerCubit flwCubit = flowerCubit.get(context);
      return Scaffold(
          appBar: AppBar(toolbarHeight: 30, elevation: 0, backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            iconTheme: IconThemeData(color: Colors.black),),
          body: Column(children:
          [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                  decoration: BoxDecoration(color: Theme.of(context).textTheme.headline4?.color, borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 3, color: (Theme.of(context).textTheme.bodyText1?.color)!)),
                  child: defaultTextField(controller: searchController, type: TextInputType.text, label: "Search for Tasks ...",
                      prefixIcon: Icon(Icons.search_outlined, color: Colors.black,), inputBorder: InputBorder.none,
                      focusedBorder: InputBorder.none, enabledBorder: InputBorder.none
                      ,suffixIcon: Icon(Icons.settings_backup_restore,
                        color: Colors.black,), onChange: (value)
                      {
                        flwCubit.search(value);
                      })
              ),
            ),
            searchController.text != '' ? Expanded(
              child: SingleChildScrollView(
                child: Column(children:

                [
                  ListView.separated(itemBuilder: (context, index) =>
                      nonDisDefaultPanelBuilder(model: flwCubit.searchRecords[index], backgroundColor: const Color(0xFFeddfaf),
                          min_color: const Color(0xFF8dc49a), name_color: Colors.white, context: context),
                    separatorBuilder: (context, index)
                    {
                      return SizedBox(height: 10);},
                    itemCount: flwCubit.searchRecords.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true, padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    physics: NeverScrollableScrollPhysics(),),
                ],),
              ),
            ):
            Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 300, 0, 0),
                    child: Center(child: Text("Search For Tasks ...",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Theme.of(context).textTheme.bodyText1?.color), ),),
                  ),
                  SizedBox(height: 20,),
                ],
              ),
            )
          ],)
        );
      },
        listener: (context, state){});
  }

}