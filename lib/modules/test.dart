import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tovo/shared/TovoCubit/TovoCubit.dart';
import 'package:tovo/shared/TovoCubit/TovoCubitStates.dart';
import 'package:tovo/shared/components/components.dart';
import 'package:iconsax/iconsax.dart';

import 'flower_login/flowerLogin.dart';

class testScreen extends StatelessWidget {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController checkPasswordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<flowerCubit, flowerStates>(builder: (context, state)
    {return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(toolbarHeight: 0,backgroundColor: const Color(0xFFDAD6D6), elevation: 0,) ,
        body: Column(children:
        [
          Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
            child: Container(
              padding: const EdgeInsets.fromLTRB(15, 20, 15, 15),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).textTheme.headline2?.color,
                  border: Border.all(color: Color(0xFF6b54fe), width: 3)),
              child: Row(children:
              [
                Icon(Iconsax.task, color: Color(0xFF6b54fe), size: 20,),
                SizedBox(width: 5,),
                Text("TOVO", textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF6b54fe),
                    fontWeight: FontWeight.bold, fontSize: 20),),


              ],)
              , ),
          ),
          Image.asset("assets/images/login6.png", scale: 2.7,),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                [
                  Expanded(
                    child: Container(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      decoration: BoxDecoration(color: Color(0xffffe8ff), borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Color(0xFF6b54fe), width: 3)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                        [
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                  color: Theme.of(context).textTheme.headline2?.color,
                                  border: Border.all(color: Color(0xFF6b54fe), width: 3)),
                              child: Row(children:
                              [
                                Text("Register", textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF6b54fe),
                                    fontWeight: FontWeight.bold, fontSize: 20),),
                                SizedBox(width: 5,),
                                Icon(Icons.app_registration_outlined, color: Color(0xFF6b54fe)),

                              ],)
                              , ),
                          ),
                          Form
                            (child: Column(children:
                          [
                            defaultTextField(controller: userNameController, type: TextInputType.text, label: "Enter your username",
                                prefixIcon: Icon(Iconsax.user_add, color: Color(0xFF6b54fe),), validateFunction: (String? value)
                                {
                                  if((value?.isEmpty)!)
                                  {
                                    return "Username is required";
                                  }
                                  if((value?.length)! < 10 || (value?.length)! > 16)
                                  {
                                    return "username length is between 10 & 16 chars";
                                  }
                                }),
                            SizedBox(height: 10,),
                            defaultTextField(controller: passwordController, type: TextInputType.text, label: "Enter your password",
                                prefixIcon: Icon(Iconsax.password_check, color: Color(0xFF6b54fe),), obscureText: true, validateFunction: (String? value)
                                {
                                  if((value?.isEmpty)!)
                                  {
                                    return "Password is required";
                                  }
                                  if((value?.length)! < 10 || (value?.length)! > 20)
                                  {
                                    return "password length is between 10 & 20 chars";
                                  }

                                }),
                            SizedBox(height: 10,),
                            defaultTextField(controller: checkPasswordController, type: TextInputType.text, label: "Renter your password",
                                prefixIcon: Icon(Icons.password_rounded, color: Color(0xFF6b54fe),), obscureText: true, validateFunction: (String? value)
                                {
                                  if((value?.isEmpty)!)
                                  {
                                    return "Password retype is required";
                                  }
                                  if(value != "${passwordController.text}")
                                  {
                                    return "Password retype must match original password";
                                  }
                                }),
                            SizedBox(height: 10,),
                            defaultTextField(controller: emailController, type: TextInputType.emailAddress, label: "Enter your Email",
                                prefixIcon: Icon(Icons.alternate_email_outlined, color: Color(0xFF6b54fe),),validateFunction: (value)
                                {
                                  if((value?.isEmpty)!)
                                  {
                                    return "Email is required";
                                  }
                                  bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]"
                                  r"+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
                                  if(!emailValid)
                                  {
                                    return "please enter a valid email";
                                  }
                                }),
                            SizedBox(height: 10,),
                            defaultTextField(controller: phoneController, type: TextInputType.number, label: "Enter your phone number",
                                prefixIcon: Icon(Icons.phone_android_rounded, color: Color(0xFF6b54fe),),validateFunction: (value)
                                {
                                  if((value?.isEmpty)!)
                                  {
                                    return "Phone number is required";
                                  }
                                }),
                          ],),key: formKey, ),
                          SizedBox(height: 15,),
                          Material(
                            child: InkWell(
                              splashColor: Colors.black,
                              onTap: ()
                              {

                              },
                              child: Material(
                                child: InkWell(
                                  onTap: ()
                                  {
                                    if ((formKey.currentState?.validate())!)
                                    {
                                      flowerCubit.get(context).insertUserFlwRecord(userNameController.text, passwordController.text,
                                          emailController.text, phoneController.text);
                                      navigateTo(context, flowerLogin());
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                        color: Theme.of(context).textTheme.headline2?.color,
                                        border: Border.all(color: Color(0xFF6b54fe), width: 3)),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children:
                                      [
                                        Text("Sign Up",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Color(0xFF6b54fe),
                                              fontWeight: FontWeight.bold, fontSize: 20),),
                                        SizedBox(width: 5,),
                                        Icon(Iconsax.key, color: Color(0xFF6b54fe)),

                                      ],)
                                    , ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 15,),
                          Text("Welcome to Tovo Task monitoring app "
                              "please review the following basic rules (terms of use) "
                              "that govern your use of and/or purchase of products through our app.",
                            style: TextStyle(fontSize: 10,
                                color: Color(0xFF968AD8)),),
                          InkWell(
                              onTap: ()
                              {

                              },
                              child: Text("Please note that your use of the app means your full agreement with Terms of Use.",
                                style: TextStyle(color: Color(0xFF6b54fe),
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold),))

                        ],),
                    ),
                  ),
                ],),
            ),
          )
        ],)
    );
    }, listener: (context, state){});

  }
}
