import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tovo/modules/search_Screen/searchScreen.dart';
import '../../shared/TovoCubit/TovoCubit.dart';
import '../../shared/TovoCubit/TovoCubitStates.dart';
import '../../shared/components/components.dart';


class FlowerHomeScreen extends StatelessWidget
{

  final TextEditingController TitleController = new TextEditingController();
  final TextEditingController DurationController = new TextEditingController();
  final TextEditingController AuthorController = new TextEditingController();
  final TextEditingController ParagraphController = new TextEditingController();
  final TextEditingController searchController = new TextEditingController();
  final TextEditingController priorityController = new TextEditingController();
  final TextEditingController typeController = new TextEditingController();
  final addFormKey = GlobalKey<FormState>();
  final List <String> priorityList = ["low", "medium", "high", "very high"];
  final String priority = "low";
  final String type = "indoor";
  final List <String> typesList = ["indoor", "outdoor"];
  final List<Map> selectedFlowerList = [];


  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<flowerCubit, flowerStates>(
      listener: (context, state) {},
      builder: (context, state)
      {

        flowerCubit flwCubit = flowerCubit.get(context);
        Future openDialog() => showDialog(context: context, builder: (context)=> Dialog (
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children:
                  [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 5),
                          borderRadius: BorderRadius.circular(30)),
                      child: Form(
                        key: addFormKey,
                        child: Column(children:
                        [
                          Container(
                              margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
                              decoration: BoxDecoration(color: Theme.of(context).textTheme.headline4?.color,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(width: 3, color: Colors.black)),
                              child: defaultTextField(controller: TitleController, type: TextInputType.text, label: "Enter Title",
                                prefixIcon: Icon(Iconsax.text, color: Colors.black,),hintColor: Colors.grey[500],
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none, validateFunction: (String? value)
                                  {
                                    if((value?.isEmpty)!)
                                    {
                                      return "Task Title is required";
                                    }
                                    if((value?.length)! < 10 || (value?.length)! > 32)
                                    {
                                      return "username length is between 10 & 32 chars";
                                    }
                                  } )
                          ),
                          Container(
                              margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
                              decoration: BoxDecoration(color: Theme.of(context).textTheme.headline4?.color,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(width: 3, color: Colors.black)),
                              child: defaultTextField(controller: DurationController, type: TextInputType.text, label: "Enter Duration",
                                  prefixIcon: Icon(Iconsax.timer, color: Colors.black,),hintColor: Colors.grey[500],
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none, validateFunction: (String? value)
                                  {
                                    if((value?.isEmpty)!)
                                    {
                                      return "Task Duration is required";
                                    }
                                    if((value?.length)! > 12)
                                    {
                                      return "duration length is max 12 chars";
                                    }
                                    if(!(value?.contains("minutes"))! && !(value?.contains("hours"))! && (value?.contains("seconds"))!
                                        && (value?.contains("days"))!)
                                    {
                                      return "duration doesn't contain measuring unit (seconds/minutes/hours)";
                                    }
                                  })
                          ),
                          Container(
                              margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
                              decoration: BoxDecoration(color: Theme.of(context).textTheme.headline4?.color,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(width: 3, color: Colors.black)),
                              child: defaultTextField(controller: AuthorController, type: TextInputType.text, label: "Enter Author",
                                  prefixIcon: Icon(Iconsax.pen_tool, color: Colors.black,),hintColor: Colors.grey[500],
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none, validateFunction: (String? value)
                                  {
                                    if((value?.isEmpty)!)
                                    {
                                      return "Task Author is required";
                                    }
                                    if((value?.length)! > 32)
                                    {
                                      return "Author length is max 12 chars";
                                    }
                                  })
                          ),
                          Container(
                              margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
                              decoration: BoxDecoration(color: Theme.of(context).textTheme.headline4?.color,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(width: 3, color: Colors.black)),
                              child: defaultTextField(controller: ParagraphController, type: TextInputType.text, label: "Enter Paragraph",
                                  prefixIcon: Icon(Iconsax.text_block, color: Colors.black,),hintColor: Colors.grey[500],
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none, validateFunction: (String? value)
                                  {
                                    if((value?.isEmpty)!)
                                    {
                                      return "Task paragraph is required";
                                    }
                                  })
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
                            padding: EdgeInsets.symmetric(vertical: 3, horizontal: 0),
                            decoration: BoxDecoration(color: Theme.of(context).textTheme.headline4?.color,
                                border: Border.all(color: Colors.black, width: 3),
                                borderRadius: BorderRadius.circular(15)),

                            child: DropdownButtonFormField<String>
                              (items: priorityList.map<DropdownMenuItem<String>>((String value)
                            {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                              onChanged: (value)
                              {
                                priorityController.text = value!;
                              }, hint: Text("Select Priority"),
                              decoration: InputDecoration(focusedBorder: InputBorder.none, border: InputBorder.none,
                                  prefixIcon: Icon(Iconsax.level, color: Colors.black),errorStyle: TextStyle(color: Colors.black),
                                  hintStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[500])),
                              borderRadius: BorderRadius.circular(20),validator: (value)
                              {
                                if(value == null){
                                  return "Task Priority is required";
                                }
                                return null;
                              },),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
                            padding: EdgeInsets.symmetric(vertical: 3, horizontal: 0),
                            decoration: BoxDecoration(color: Theme.of(context).textTheme.headline4?.color, border: Border.all(color: Colors.black, width: 3),
                                borderRadius: BorderRadius.circular(15),),

                            child: DropdownButtonFormField<String>
                              (items: typesList.map<DropdownMenuItem<String>>((String value)
                            {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                              onChanged: (value)
                              {
                                typeController.text = value!;
                              }, hint: Text("Select Type"),
                              decoration: InputDecoration(focusedBorder: InputBorder.none, border: InputBorder.none,
                                  prefixIcon: Icon(Iconsax.category, color: Colors.black), errorStyle: TextStyle(color: Colors.black),
                                  hintStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[500])),
                              borderRadius: BorderRadius.circular(20), validator: (value)
                              {
                                if(value == null){
                                  return "Task Type is required";
                                }
                                return null;
                              },),
                          ),
                          SizedBox(height: 5,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                            child: defaultButton(text:"Create Panel", color: (Theme.of(context).textTheme.headline5?.color)!, radius: 80 ,function: ()
                            {
                              if((addFormKey.currentState?.validate())!)
                              {
                                flwCubit.insertFlwRecord(TitleController.text, AuthorController.text, DurationController.text,
                                    ParagraphController.text, priorityController.text, typeController.text, flwCubit.tasksID);
                                TitleController.clear();
                                AuthorController.clear();
                                DurationController.clear();
                                ParagraphController.clear();
                                typeController.clear();
                                Navigator.of(context).pop();
                              }

                            }, context: context),
                          ),
                        ], mainAxisSize: MainAxisSize.min,),),
                    )
                  ],),
                )
            ));

        return Scaffold(
          appBar: AppBar(toolbarHeight: 0,backgroundColor: const Color(0xFFDAD6D6), elevation: 0,) ,
          body:
          Column(children:
          [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 10),
              child: Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                decoration: BoxDecoration(color: Theme.of(context).textTheme.headline2?.color,
                    borderRadius: BorderRadius.circular(10), border: Border.all(color: (Theme.of(context).textTheme.bodyText1?.color)!, width: 3)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                  [
                    Row(
                      children:
                      [
                        Expanded(child:
                        Padding(padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
                          child: Row(children:
                          [
                            Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(80),
                                  border: Border.all(color: (Theme.of(context).textTheme.bodyText2?.color)!, width: 2)),
                              child: CircleAvatar(backgroundImage: returnProfileImage(flowerCubit.get(context).displayUsername),
                                radius: 25, backgroundColor: Color(0xFF6b54fe),),
                            ),
                            const SizedBox(width: 10.0,),
                            Column(children: [
                              Text("Welcome Back,",
                                style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.bodyText1?.color, fontSize: 14.0),),
                              Text("${flowerCubit.get(context).displayUsername}",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0, color: Theme.of(context).textTheme.bodyText1?.color),)
                            ],mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start,),
                            Spacer(),
                            IconButton(onPressed: ()
                            {
                              flwCubit.searchRecords.clear();
                              navigateTo(context, searchScreen());
                            },
                              icon: const Icon(Icons.search_rounded),iconSize: 32, color: Theme.of(context).textTheme.bodyText1?.color,),
                            IconButton(onPressed: ()
                            {
                              flwCubit.changeTheme();
                            },
                              icon: flwCubit.isDark ? Icon(Icons.brightness_4) : Icon(Icons.brightness_4_outlined),iconSize: 32,
                              color: Theme.of(context).textTheme.bodyText1?.color,)
                          ],),))

                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 0, 10),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Color(0xffEAFFDA),
                            border: Border.all(color: (Theme.of(context).textTheme.bodyText1?.color)!, width: 3)),
                        child: Text("UID: ${flowerCubit.get(context).displayUserID}", textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black,
                              fontWeight: FontWeight.bold, fontSize: 12.5),), ),
                    ),


                  ],),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Row(children:
                [
                  GestureDetector(
                    onTap: ()
                    {
                      flwCubit.changeTabScreen(1);

                    },
                    child: tabHeadSelector(flwCubit: flwCubit, index: 1, text: "All",
                        bgColor: Color(0xFF638475), textColor: Colors.black, context: context),
                  ),
                  const SizedBox(width: 5,),
                  GestureDetector(
                    onTap: ()
                    {
                      flwCubit.changeTabScreen(2);
                    },
                    child: tabHeadSelector(flwCubit: flwCubit, index: 2, text: "Low",
                        bgColor: Color(0xFF90E39A), textColor: Colors.black, context: context),
                  ),
                  const SizedBox(width: 5,),
                  GestureDetector(
                    onTap: ()
                    {
                      flwCubit.changeTabScreen(3);
                    },
                    child: tabHeadSelector(flwCubit: flwCubit, index: 3, text: "Medium",
                        bgColor: Color(0xFFDDF093), textColor: Colors.black, context: context),
                  ),
                  const SizedBox(width: 5,),
                  GestureDetector(
                    onTap: ()
                    {
                      flwCubit.changeTabScreen(4);
                    },
                    child: tabHeadSelector(flwCubit: flwCubit, index: 4, text: "High",
                        bgColor: Color(0xFFF6D0B1), textColor: Colors.black, context: context),
                  ),
                  const SizedBox(width: 5,),
                  GestureDetector(
                    onTap: ()
                    {
                      flwCubit.changeTabScreen(5);
                    },
                    child: tabHeadSelector(flwCubit: flwCubit, index: 5, text: "Very High",
                        bgColor: Color(0xFFE65C75), textColor: Colors.black, context: context),
                  ),
                  const SizedBox(width: 5,),
                ],),
              ),
            ),
            SizedBox(height: 5,),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: flwCubit.selectedList.length != 0 ? Column(children:
                [
                  ListView.separated(itemBuilder: (context, index) =>
                      defaultPanelBuilder(model: flwCubit.selectedList[index], backgroundColor: const Color(0xFFeddfaf),
                          min_color: const Color(0xFF8dc49a), name_color: Colors.white, context: context,
                          TitleController: TitleController, typeController: typeController, AuthorController: AuthorController,
                          ParagraphController: ParagraphController, priorityController: priorityController,
                        DurationController: DurationController, addFormKey: addFormKey, ),
                    separatorBuilder: (context, index)
                    {
                      return SizedBox(height: 10);},
                    itemCount: flwCubit.selectedList.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true, padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    physics: BouncingScrollPhysics(),),
                  flwCubit.selectedList == flwCubit.allRecords ?
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Material(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: InkWell(
                        splashColor: Colors.black,
                        onTap: ()
                        {
                          openDialog();
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
                              Text("Add New Task",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: (Theme.of(context).textTheme.bodyText1?.color)!,
                                    fontWeight: FontWeight.bold, fontSize: 20),),
                              SizedBox(width: 5,),
                              Icon(Iconsax.add, color: Color(0xFF6b54fe)),

                            ],)
                          , ),
                      ),
                    ),
                  )
                   : Container(),

                ],):
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 200, 0, 0),
                      child: Center(child: Text("No Tasks Yet",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.grey[500]), ),),
                    ),
                    SizedBox(height: 50,),
                    flwCubit.selectedList == flwCubit.allRecords ? Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Material(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: InkWell(
                          splashColor: Colors.black,
                          onTap: ()
                          {
                            openDialog();
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
                                Text("Add New Task",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: (Theme.of(context).textTheme.bodyText1?.color)!,
                                      fontWeight: FontWeight.bold, fontSize: 20),),
                                SizedBox(width: 5,),
                                Icon(Iconsax.add, color: Color(0xFF6b54fe)),

                              ],)
                            , ),
                        ),
                      ),
                    )
                        : Container(),
                  ],
                ),
              ),
            ),
          ],),
        );
      },);

  }

}
