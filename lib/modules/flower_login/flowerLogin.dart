import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tovo/modules/flower_register/flowerRegister.dart';
import 'package:tovo/shared/TovoCubit/TovoCubit.dart';
import 'package:tovo/shared/TovoCubit/TovoCubitStates.dart';
import 'package:tovo/shared/components/components.dart';
import 'package:iconsax/iconsax.dart';

class flowerLogin extends StatelessWidget {
  final logFormKey = GlobalKey<FormState>();
  final passFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return BlocConsumer<flowerCubit, flowerStates>(
        builder: (context, state) {
          return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                toolbarHeight: 0,
                backgroundColor: const Color(0xFFDAD6D6),
                elevation: 0,
              ),
              body: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).textTheme.headline2?.color,
                          border: Border.all(color: Color(0xFF6b54fe), width: 3)),
                      child: Row(
                        children: [
                          Icon(
                            Iconsax.task,
                            color: Color(0xFF6b54fe),
                            size: 20,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "LOGIN",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Color(0xFF6b54fe), fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            "assets/images/log2.png",
                            scale: 1.5,
                          )),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(25, 10, 25, 25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: Container(
                                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                                      decoration: BoxDecoration(
                                          color: Color(0xffffe8ff),
                                          borderRadius: BorderRadius.circular(15),
                                          border: Border.all(color: Color(0xFF6b54fe), width: 3)),
                                      child: Column(children:
                                      [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Center(
                                                  child: Text(
                                                    "${flowerCubit.get(context).TextFail}",
                                                    style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF6b54fe)),
                                                  )),
                                              // the username and password fields
                                              Expanded(
                                                flex:3,
                                                child: Form(
                                                  key: logFormKey,
                                                  child: Column(
                                                    children: [
                                                      Expanded(
                                                        child: defaultTextField(
                                                            controller: flowerCubit.get(context).userNameController,
                                                            type: TextInputType.text,
                                                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 3,
                                                                color: Color(0xFF8D7EF3)),
                                                                borderRadius: BorderRadius.circular(10)),
                                                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 3,
                                                                color: Color(0xFF6b54fe)),
                                                                borderRadius: BorderRadius.circular(15)),
                                                            label: "Username",
                                                            prefixIcon: Icon(
                                                              Iconsax.user,
                                                              color: Color(0xFF6b54fe), size: 17,
                                                            ),
                                                            validateFunction: (String? value) {
                                                              if ((value?.isEmpty)!) {
                                                                return "Username is required";
                                                              }
                                                            }),
                                                      ),
                                                      Expanded(
                                                        child: defaultTextField(
                                                            controller: flowerCubit.get(context).passwordController,
                                                            type: TextInputType.text,
                                                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 3,
                                                                color: Color(0xFF8D7EF3)),
                                                                borderRadius: BorderRadius.circular(10)),
                                                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 3,
                                                                color: Color(0xFF6b54fe)), borderRadius: BorderRadius.circular(15)),
                                                            label: "Password",
                                                            prefixIcon: Icon(
                                                              Iconsax.password_check,
                                                              color: Color(0xFF6b54fe), size: 17,
                                                            ),
                                                            obscureText: !flowerCubit.get(context).isShown,
                                                            suffixIcon: IconButton(
                                                              icon: flowerCubit.get(context).passwordIcon,
                                                              onPressed: () {
                                                                flowerCubit.get(context).showPassword();
                                                              },
                                                            ),
                                                            validateFunction: (String? value) {
                                                              if ((value?.isEmpty)!) {
                                                                return "Password is required";
                                                              }
                                                            }),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              // the sign in button
                                              Expanded(
                                                flex: 1,
                                                child: Material(
                                                  color: Color(0xffffe8ff),
                                                  child: InkWell(
                                                    splashColor: Color(0xFF6b54fe),
                                                    onTap: () {
                                                      if ((logFormKey.currentState?.validate())!) {
                                                        bool val = flowerCubit.get(context).login(
                                                            context,
                                                            flowerCubit.get(context).userNameController.text,
                                                            flowerCubit.get(context).passwordController.text);
                                                        flowerCubit.get(context).checkFailLogin(val);
                                                      }
                                                    },
                                                    child: Container(
                                                      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          color: Theme.of(context).textTheme.headline2?.color,
                                                          border: Border.all(color: Color(0xFF6b54fe), width: 3)),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Icon(Iconsax.login, color: Color(0xFF6b54fe), size: 25,)
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 15,),
                                              // the forget password and register buttons
                                              Expanded(
                                                flex: 1,
                                                child: Column(children:
                                              [
                                                Row(children: [
                                                  Spacer(),
                                                  Text(
                                                    "Forget Your Password ",
                                                    style: TextStyle(fontSize: 10, color: Color(0xFF968AD8)),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      TextEditingController uControl = new TextEditingController();
                                                      TextEditingController pControl = new TextEditingController();
                                                      TextEditingController nControl = new TextEditingController();

                                                      Future openDialog() => showDialog(
                                                          context: context,
                                                          builder: (context) => Dialog(
                                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                                              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                                              child: SingleChildScrollView(
                                                                child: Column(
                                                                  mainAxisSize: MainAxisSize.min,
                                                                  children: [
                                                                    Container(
                                                                      width: double.infinity,
                                                                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                                                                      decoration: BoxDecoration(
                                                                          border: Border.all(color: Colors.black, width: 5),
                                                                          borderRadius: BorderRadius.circular(30)),
                                                                      child: Form(
                                                                        key: passFormKey,
                                                                        child: Column(
                                                                          children: [
                                                                            Center(
                                                                                child: Text(
                                                                                  "${flowerCubit.get(context).TextFailM}",
                                                                                  style: TextStyle(
                                                                                      fontWeight: FontWeight.bold, color: Color(0xFF6b54fe)),
                                                                                )),
                                                                            SizedBox(
                                                                              height: 10,
                                                                            ),
                                                                            Container(
                                                                                decoration: BoxDecoration(
                                                                                    color: Theme.of(context).textTheme.headline4?.color,
                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                    border: Border.all(width: 3, color: Colors.black)),
                                                                                child: defaultTextField(
                                                                                    controller: uControl,
                                                                                    type: TextInputType.text,
                                                                                    label: "Enter username",
                                                                                    prefixIcon: Icon(
                                                                                      Iconsax.user_square,
                                                                                      color: Colors.black,
                                                                                    ),
                                                                                    hintColor: Colors.grey[500],
                                                                                    enabledBorder: InputBorder.none,
                                                                                    focusedBorder: InputBorder.none,
                                                                                    validateFunction: (String? value) {
                                                                                      if ((value?.isEmpty)!) {
                                                                                        return "Username is required";
                                                                                      }
                                                                                    })),
                                                                            SizedBox(
                                                                              height: 10,
                                                                            ),
                                                                            Container(
                                                                                decoration: BoxDecoration(
                                                                                    color: Theme.of(context).textTheme.headline4?.color,
                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                    border: Border.all(width: 3, color: Colors.black)),
                                                                                child: defaultTextField(
                                                                                    controller: pControl,
                                                                                    type: TextInputType.text,
                                                                                    label: "Enter Old Password",
                                                                                    prefixIcon: Icon(
                                                                                      Iconsax.password_check,
                                                                                      color: Colors.black,
                                                                                    ),
                                                                                    hintColor: Colors.grey[500],
                                                                                    enabledBorder: InputBorder.none,
                                                                                    focusedBorder: InputBorder.none,
                                                                                    validateFunction: (String? value) {
                                                                                      if ((value?.isEmpty)!) {
                                                                                        return "Old Password is required";
                                                                                      }
                                                                                    })),
                                                                            SizedBox(
                                                                              height: 10,
                                                                            ),
                                                                            Container(
                                                                                decoration: BoxDecoration(
                                                                                    color: Theme.of(context).textTheme.headline4?.color,
                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                    border: Border.all(width: 3, color: Colors.black)),
                                                                                child: defaultTextField(
                                                                                    controller: nControl,
                                                                                    type: TextInputType.text,
                                                                                    label: "Enter New Password",
                                                                                    prefixIcon: Icon(
                                                                                      Iconsax.pen_add,
                                                                                      color: Colors.black,
                                                                                    ),
                                                                                    hintColor: Colors.grey[500],
                                                                                    enabledBorder: InputBorder.none,
                                                                                    focusedBorder: InputBorder.none,
                                                                                    validateFunction: (String? value) {
                                                                                      if ((value?.isEmpty)!) {
                                                                                        return "New Password is required";
                                                                                      }
                                                                                      if ((value?.length)! < 10 || (value?.length)! > 20) {
                                                                                        return "password length is between 10 & 20 chars";
                                                                                      }
                                                                                    })),
                                                                            SizedBox(
                                                                              height: 10,
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                                                              child: defaultButton(
                                                                                  text: "Update Password",
                                                                                  color: (Theme.of(context).textTheme.headline5?.color)!,
                                                                                  radius: 80,
                                                                                  function: () {
                                                                                    if ((passFormKey.currentState?.validate())!) {
                                                                                      flowerCubit.get(context).flowerUpdatePasswordRecord(
                                                                                          context, uControl.text, pControl.text, nControl.text);
                                                                                    }
                                                                                  },
                                                                                  context: context),
                                                                            ),
                                                                          ],
                                                                          mainAxisSize: MainAxisSize.min,
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              )));
                                                      flowerCubit.get(context).TextFailM = "";
                                                      openDialog();
                                                    },
                                                    child: Text("Click Here",
                                                        style: TextStyle(fontSize: 10, color: Color(0xFF6b54fe), fontWeight: FontWeight.bold)),
                                                  ),
                                                ]),
                                                Row(
                                                  children: [
                                                    Spacer(),
                                                    Text(
                                                      "If you don't have an account you can ",
                                                      style: TextStyle(fontSize: 10, color: Color(0xFF968AD8)),
                                                    ),
                                                    InkWell(
                                                        onTap: () {
                                                          navigateTo(context, flowerRegister());
                                                        },
                                                        child: Text(
                                                          "Register Now",
                                                          style: TextStyle(color: Color(0xFF6b54fe), fontSize: 10, fontWeight: FontWeight.bold),
                                                        )),
                                                  ],
                                                )
                                              ],),),
                                            ],
                                          ),
                                        ),
                                      ],)
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                // the terms of the agreements and usage panel
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    padding: const EdgeInsets.fromLTRB(20, 25, 20, 0),
                                    decoration: BoxDecoration(
                                        color: Color(0xffffe8ff),
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(color: Color(0xFF6b54fe), width: 3)),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Container(child:Text(
                                            "Welcome to Tovo Task monitoring app "
                                                "please review the following basic rules (terms of use) "
                                                "that govern your use of and/or purchase of products through our app. "
                                                "All purchases done through the app help the developers to keep a healthy software development cycle."
                                                "So, In order to continue providing quality applications we welcome any incoming donations. ",
                                            style: TextStyle(fontSize: 9, color: Color(0xFF968AD8), overflow: TextOverflow.ellipsis,),
                                            maxLines: 4,),),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            child: InkWell(
                                                onTap: () {
                                                },
                                                child: Text(
                                                  "Note that your use of the app means your full agreement with Terms of Use.",
                                                  style: TextStyle(color: Color(0xFF6b54fe), fontSize: 9, fontWeight: FontWeight.bold),
                                                )),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ));
        },
        listener: (context, state) {});
  }
}
