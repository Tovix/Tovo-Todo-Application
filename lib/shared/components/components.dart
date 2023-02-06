import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tovo/shared/TovoCubit/TovoCubit.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';

Color checkCategory(category)
{
  if (category == "low")
  {
    return Color(0xFF90E39A);
  }
  if (category == "medium")
  {
    return Color(0xFFDDF093);
  }
  if (category == "high")
  {
    return Color(0xFFF6D0B1);
  }
  if (category == "very high")
  {
    return Color(0xFFE65C75);
  }
  else
  {
    return Colors.red;
  }
}

String checkType(model, context)
{
  if(model == "indoor")
  {
    return "⊝";
  }
  else
  {
    if(flowerCubit.get(context).weatherRecord['main']['temp'] <= 305.15 &&
        flowerCubit.get(context).weatherRecord['main']['temp'] >= 292.15)
    {
      return "☉";
    }
    else
    {
      return "☇";
    }

  }
}

String returnReport(temp)
{
  String Note = "Note:\nThis Suggestions is not to be forced upon the user and sometimes may not go with the current real life situations "
      "in case of unstable weather outdoor tasks are marked with (☇) so that they can be noticed.";
  if (temp <= 32 && temp >= 19)
  {
    return "You can practice any outdoor activities safely since the temps are in the reasonable range.\n${Note}";
  }
  else
  {
    return "You shouldn't practice any outdoor activities since the temps aren't in the reasonable range, "
        "It's advised to stay indoors.\n${Note}";
  }
}


Widget defaultButton(
    {
      double width = double.infinity, Color color = Colors.blue, required function,
      required String text, bool isCapital = true, double radius = 8.0, required BuildContext context}) => Container(
  width: width,
  child: MaterialButton(onPressed: function,
    height: 35.0,
    child:
    Text(isCapital ? text.toUpperCase() : text.toLowerCase(), style: TextStyle(color: Colors.black, fontSize: 17.0,
        fontWeight: FontWeight.bold), ),),
  decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius), color: color, border:
  Border.all(color: (Theme.of(context).textTheme.bodyText1?.color)!, width: 3.0)),
);

Widget defaultPanelBuilder(
    {
      required Color backgroundColor, required Color min_color, required Color name_color, required Map model,
      required BuildContext context, required addFormKey,
      required TextEditingController TitleController, required TextEditingController DurationController,
      required TextEditingController AuthorController, required TextEditingController ParagraphController,
      required TextEditingController priorityController, required TextEditingController typeController}) => GestureDetector(
        onDoubleTap: ()
        {
          final List <String> priorityList = ["low", "medium", "high", "very high"];
          final List <String> typesList = ["indoor", "outdoor"];
          TitleController.text = model['title'];
          DurationController.text = model['duration'];
          AuthorController.text = model['author'];
          ParagraphController.text = model['paragraph'];
          priorityController.text = model['category'];
          typeController.text = model['type'];
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
                          SizedBox(height: 10,),
                          Container(
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
                          SizedBox(height: 10,),
                          Container(
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
                          SizedBox(height: 10,),
                          Container(
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
                          SizedBox(height: 10,),
                          Container(
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
                          SizedBox(height: 10,),
                          Container(
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
                          SizedBox(height: 10,),
                          Container(
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
                            child: defaultButton(text:"Modify Panel", color: (Theme.of(context).textTheme.headline5?.color)!, radius: 80 ,function: ()
                            {
                              if((addFormKey.currentState?.validate())!)
                              {
                                flowerCubit.get(context).flowerUpdateWholeRecord(TitleController.text, AuthorController.text, DurationController.text,
                                    ParagraphController.text, priorityController.text, typeController.text,model['id'], model['taskID']);
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
          openDialog();
        },
        child: Dismissible(

        key: UniqueKey(),
        onDismissed: (direction)
        {
          flowerCubit.get(context).flowerUpdateRecord('done', model['id'], flowerCubit.get(context).userID);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
                Container(
                  padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                      color: Theme.of(context).textTheme.headline2?.color,
                      border: Border.all(color: (Theme.of(context).textTheme.bodyText1?.color)!, width: 3)),
                  child: Text('${model['duration']} ${checkType(model['type'], context)}', textAlign: TextAlign.center,
                    style: TextStyle(color: Theme.of(context).textTheme.bodyText1?.color,
                        fontWeight: FontWeight.bold),), ),
                const SizedBox(width: 5,),
                Container(
                  padding: const EdgeInsets.fromLTRB(5, 6.5, 5, 6.5),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Theme.of(context).textTheme.headline3?.color,
                      border: Border.all(color: (Theme.of(context).textTheme.bodyText1?.color)!, width: 3)),
                  child: Text(model['author'], textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black,
                        fontWeight: FontWeight.bold),), ),
                Spacer(),
                Container(
                  padding: const EdgeInsets.fromLTRB(7, 5, 7, 5),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: checkCategory(model['category']),
                      border: Border.all(color: (Theme.of(context).textTheme.bodyText1?.color)!, width: 3)),
                  child: Text(model['category'], textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black,
                        fontWeight: FontWeight.bold),), ),
              ],),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Text(model['title'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Theme.of(context).textTheme.bodyText1?.color),),
            ),
            Text(model['paragraph'],
                style: TextStyle(color: Theme.of(context).textTheme.bodyText1?.color,
                    fontSize: 14, fontWeight: FontWeight.bold),textAlign: TextAlign.start),
            SizedBox(height: 10,),
            Container(
              padding: const EdgeInsets.fromLTRB(18, 5, 18, 5),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Color(0xffEAFFDA),
                  border: Border.all(color: (Theme.of(context).textTheme.bodyText1?.color)!, width: 3)),
              child: Text("ID: ${model['taskID']}-${model['id']}", textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black,
                    fontWeight: FontWeight.bold, fontSize: 12.5),), ),
          ],),
    ),
  ),
),
      );

Widget nonDisDefaultPanelBuilder(
    {
      required Color backgroundColor, required Color min_color, required Color name_color,
      required Map model, required BuildContext context,}) => Padding(
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
                Container(
                  padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                      color: Theme.of(context).textTheme.headline2?.color, border: Border.all(color: (Theme.of(context).textTheme.bodyText1?.color)!, width: 3)),
                  child: Text(model['duration'], textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black,
                        fontWeight: FontWeight.bold),), ),
                const SizedBox(width: 10,),
                Container(
                  padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Theme.of(context).textTheme.headline3?.color,
                      border: Border.all(color: (Theme.of(context).textTheme.bodyText1?.color)!, width: 3)),
                  child: Text(model['author'], textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black,
                        fontWeight: FontWeight.bold),), ),
                Spacer(),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: checkCategory(model['category']),
                      border: Border.all(color: (Theme.of(context).textTheme.bodyText1?.color)!, width: 3)),
                  child: Text(model['category'], textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black,
                        fontWeight: FontWeight.bold),), ),
              ],),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Text(model['title'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Theme.of(context).textTheme.bodyText1?.color),),
            ),
            Text(model['paragraph'],
                style: TextStyle(color: Theme.of(context).textTheme.bodyText1?.color,
                    fontSize: 14, fontWeight: FontWeight.bold),textAlign: TextAlign.start),
          ],),
      ),
    );

Widget defaultTextField(
    {
      required TextEditingController controller, required TextInputType type, required String label, required Icon prefixIcon,
      Widget? suffixIcon, bool obscureText = false, onChange, onSubmit, onTap, inputBorder, validateFunction,
      hintColor = const Color(0xFF6b54fe), enabledBorder =
    const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF968AD8), width: 2)),
      focusedBorder = const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF968AD8), width: 3)),
    }) => TextFormField(
  controller: controller,
  decoration: InputDecoration
    (
      prefixIcon: prefixIcon, suffixIcon: suffixIcon, hintText: label,
      hintStyle: TextStyle(fontWeight: FontWeight.bold, color: hintColor, fontSize: 13),
      border: inputBorder,
      enabledBorder: enabledBorder,
      focusedBorder: focusedBorder ,iconColor: Color(0xFF6b54fe),
      errorStyle: TextStyle(color: Colors.black, fontSize: 11),
      focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent, width: 1)),
      errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent, width: 3))
  ),
  keyboardType: type, obscureText: obscureText,
  validator: validateFunction,
  onChanged: onChange,
  onFieldSubmitted: onSubmit,
  onTap: onTap,
);

Widget tabHeadSelector({@required flwCubit, @required index, @required text, bgColor, textColor, context}) => Container(
  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
      color: flwCubit.isSelected == index ? Colors.black : bgColor,
      border: Border.all(width: 3, color: (Theme.of(context).textTheme.bodyText1?.color)!)),
  child: Text("$text", style: TextStyle(color: flwCubit.isSelected == index ? Colors.white : textColor,
      fontSize: 15, fontWeight: FontWeight.bold),textAlign: TextAlign.center),);

Route _createRoute(screen) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => screen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0,2);
      const end = Offset.zero;
      const curve = Curves.linear;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

void navigateTo(context, screen) => Navigator.of(context).push(_createRoute(screen));

Future chooseImage({source=ImageSource.gallery}) async {
  final ImagePicker picker = ImagePicker();
  var image = await picker.pickImage(source: source);
  List<int> bytes = await (image?.readAsBytes())!;
  print(bytes);
}


AssetImage returnProfileImage(String username) {
  List alphaLetters = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n',
    'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'];
  if(alphaLetters.contains(username[0].toLowerCase()) == false)
  {
    return AssetImage("assets/alpha/other.png");

  }
  else
  {
    String fileName = username[0].toLowerCase() + ".png";
    return AssetImage("assets/alpha/${fileName}");
  }



}

Widget nonDisDefaultPanel(context, cB, wB, fB) => Conditional.single(context: context,
    conditionBuilder: cB, widgetBuilder: wB, fallbackBuilder: fB);


