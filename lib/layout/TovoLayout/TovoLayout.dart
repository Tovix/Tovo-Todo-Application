import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import '../../shared/TovoCubit/TovoCubit.dart';
import '../../shared/TovoCubit/TovoCubitStates.dart';

class flowerLayout extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<flowerCubit, flowerStates>(
      listener: (context, state) {} ,
      builder:(context, state)
      {
        flowerCubit flwCubit = flowerCubit.get(context);
        return Scaffold(
          body: flwCubit.flowerScreenBodies[flwCubit.screenIndex],
          bottomNavigationBar: Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 3),
            decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor ),
            child: Container(
              decoration: BoxDecoration(border: Border.all(color: (Theme.of(context).textTheme.bodyText1?.color)!, width: 3), boxShadow: [
                BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 0)], borderRadius: BorderRadius.circular(20)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  currentIndex: flwCubit.screenIndex,
                  onTap: (index)
                  {
                    flwCubit.navigate(index);
                  },
                  items:
                  [
                    BottomNavigationBarItem(icon: Icon(Iconsax.menu_board), label: "Todo"),
                    BottomNavigationBarItem(icon: Icon(Iconsax.task), label: "Done"),
                    BottomNavigationBarItem(icon: Icon(Iconsax.cloud_sunny), label: "Conditions"),
                    BottomNavigationBarItem(icon: Icon(Iconsax.setting), label: "Settings"),
                  ],
                  unselectedItemColor: Theme.of(context).textTheme.bodyText1?.color,
                  backgroundColor: Theme.of(context).textTheme.headline6?.color,
                  selectedItemColor: Color(0xFFE65C75),
                  unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
            ),
          ),
        );
      },
    );

  }





}
