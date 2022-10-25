import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tovo/modules/flower_login/flowerLogin.dart';
import 'package:tovo/modules/flower_register/flowerRegister.dart';
import 'package:tovo/modules/test.dart';
import 'package:tovo/shared/TovoCubit/TovoCubit.dart';
import 'package:tovo/shared/TovoCubit/TovoCubitStates.dart';
import 'package:tovo/shared/network/local/cache_helper.dart';
import 'package:tovo/shared/network/remote/dio_helper.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await cacheHelper.init();
  print("${cacheHelper.getString("username")}");
  print("${cacheHelper.getString("password")}");
  dioHelper.init();
  runApp(MyApp());
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=>flowerCubit()..createFlowerDatabase()..getWeatherData()..initPrevLogin(),
        child:BlocConsumer<flowerCubit, flowerStates>(
          builder: (context, state)
          {
            SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(systemNavigationBarColor: ThemeMode == ThemeMode.dark ?
            Color(0xFF7F95D1) : Color(0xffFDECEF)));
            return MaterialApp(

              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                inputDecorationTheme: InputDecorationTheme(),
                appBarTheme: AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark,
                  statusBarColor:Color(0xFFF0F3BD), systemStatusBarContrastEnforced: true, ), backgroundColor: Color(0xffFDECEF)),
                  scaffoldBackgroundColor: Color(0xffFDECEF),
                  textTheme: TextTheme(bodyText1: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
                      headline1: TextStyle(color: Color(0xFFC8C2F1)),
                      headline2: TextStyle(color: Color(0xFFF0F3BD)),
                      headline3: TextStyle(color: Color(0xFFF0F3BD)),
                      headline4: TextStyle(color: Color(0xFFEFF2C0)),
                      headline5: TextStyle(color: Color(0xFFEFF2C0)),
                      headline6: TextStyle(color: Color(0xFFEFF2C0))),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: Color(0xffFDECEF))),
              darkTheme: ThemeData(scaffoldBackgroundColor: Color(0xFF150811),buttonTheme:
              ButtonThemeData(buttonColor: Colors.white),
                  textTheme: TextTheme(bodyText1: TextStyle(color: Colors.white,
                      fontWeight: FontWeight.bold, fontSize: 20),
                      headline1: TextStyle(color: Color(0xFF353535)),
                      headline2: TextStyle(color: Color(0xFF5B5B5B)),
                      headline3: TextStyle(color: Color(0xFFD9D9D9)),
                      headline4: TextStyle(color: Color(0xFFD9D9D9)),
                      headline5: TextStyle(color: Color(0xFFD9D9D9)),
                      headline6: TextStyle(color: Color(0xFF150811))),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: Color(0xFF262730))),
              themeMode: flowerCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
              home: testScreen(),
              scrollBehavior: MyBehavior(),

        );
            },listener: (context, state){},) );
  }
}


