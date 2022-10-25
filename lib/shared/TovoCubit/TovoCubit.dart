// imports
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tovo/shared/network/local/cache_helper.dart';
import 'package:tovo/shared/network/remote/dio_helper.dart';
import 'package:uuid/uuid.dart';
import '../../layout/TovoLayout/TovoLayout.dart';
import '../../modules/flower_done/flowerTasksDone.dart';
import '../../modules/flower_settings/flowerSettings.dart';
import '../../modules/flower_tasks/flowerTasks.dart';
import '../../modules/flower_weather/flowerWeather.dart';
import '../components/components.dart';
import 'TovoCubitStates.dart';

class flowerCubit extends Cubit<flowerStates>
{
  // init flowerCubit superClass state and get object:
  flowerCubit() : super(flowerInitialState());
  static flowerCubit get(context) => BlocProvider.of(context);
  // class variables
  bool isDark = true;
  int isSelected = 1;
  int screenIndex = 0;
  Database? database;
  List<Widget> PanelWidgets = <Widget>[];
  List<Map> loadedRecords = [];
  List<Map> users = [];
  List user = [];
  List<Map> searchRecords = [];
  List <Map> lowRecords = [];
  List <Map> mediumRecords = [];
  List <Map> highRecords = [];
  List <Map> vHighRecords = [];
  List <Map> selectedList = [];
  List <Map> allRecords = [];
  List <Map> doneRecords = [];
  List <Map> inRecords = [];
  List <Map> outRecords = [];
  dynamic weatherRecord = [];
  String userID = "";
  String displayUserID = "";
  String tasksID = "";
  String displayUsername = "";
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  Icon passwordIcon = Icon(Iconsax.eye, color: Color(0xFF6b54fe), size: 19,);
  String TextFail = "";
  String TextFailM = "";
  bool isConnect = true;



  List<Widget> flowerScreenBodies =
  [
    FlowerHomeScreen(),
    flowerDone(),
    flowerWeather(),
    flowerSettings(),
  ];
  // change screen
  void navigate(int index)
  {
    screenIndex = index;
    print(doneRecords);
    if(index == 0)
    {
      changeTabScreen(1);
    }
    if(index == 2)
    {
      checkConnection();
      getWeatherData();
    }
    emit(flowerNavigateState());
  }

  Future<bool> checkConnection() async
  {
    bool isConnected = await InternetConnectionChecker().hasConnection.then((value)
    {
      isConnect = value;
      return value;
    });
    return isConnected;
  }

  bool isShown = false;
  void showPassword()
  {
    isShown = !isShown;
    if(isShown)
    {
      passwordIcon = Icon(Iconsax.eye_slash, color: Color(0xFF6b54fe));
    }
    if(!isShown)
    {
      passwordIcon = Icon(Iconsax.eye, color: Color(0xFF6b54fe));
    }
    emit(flowerShowPasswordState());
  }

  void initPrevLogin()
  {
    userNameController.text = cacheHelper.getString("username") ?? "";
    passwordController.text = cacheHelper.getString("password") ?? "";
  }

  // login
  bool login(context, String? username, String? password)
  {
    users.forEach((element)
    {
      if(element['username'] ==  username && element['password'] == password)
      {
        userID = element['accountID'];
        tasksID = element['accountID'];
        user.add([element['username'], element['password'], element['email'], element['phone']]);
      }
    });
    if (userID != "")
    {
      cacheHelper.setString("username", username!);
      cacheHelper.setString("password", password!);
      if(cacheHelper.getString("isLogged") == "yes")
      {
        displayUsername = cacheHelper.getString("username")!;
      }
      else
      {
        displayUsername = username;
      }
      navigateTo(context, flowerLayout());
      getFlwRecord(database, userID);
      navigate(0);
      changeTabScreen(1);
      print("${username}, ${password}, ${userID}");
      displayUserID = userID;
      TextFail = "";
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(systemNavigationBarColor: Color(0xffFDECEF),));
      return true;
    }
    print("${username}, ${password}, ${userID}");
    return false;
  }

  void checkFailLogin(bool value)
  {
    if(value == false)
    {
      TextFail = "Incorrect Username or Password";
      emit(flowerFailedLoginState());
    }
  }

  void signOut()
  {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(systemNavigationBarColor: Color(0xffFDECEF),));
    userID = "";
    userNameController.text = cacheHelper.getString("username")!;
    passwordController.text = cacheHelper.getString("password")!;
    emit(flowerSignOutState());
  }

  // change tab function
  void changeTabScreen(int selectedScreen)
  {
    isSelected = selectedScreen;
    if(selectedScreen == 1)
    {
      selectedList = allRecords;
      emit(flowerAllTabState());
    }
    else if(selectedScreen == 2)
    {
      selectedList = lowRecords;
      emit(flowerLowTabState());
    }
    else if(selectedScreen == 3)
    {
      selectedList = mediumRecords;
      emit(flowerMediumTabState());
    }
    else if(selectedScreen == 4)
    {
      selectedList = highRecords;
      emit(flowerHighTabState());
    }
    else if(selectedScreen == 5)
    {
      selectedList = vHighRecords;
      emit(flowerVHighTabState());
    }
  }

  // create flowerDataBase
  void createFlowerDatabase()
  {
    openDatabase('flowerDB.db',
        onCreate: (database, version)
        {
          database.execute("CREATE TABLE users (id INTEGER PRIMARY KEY, username TEXT, password TEXT, email TEXT, phone TEXT, "
              "accountID TEXT)").then((value) => {
            print("users created")
          });
          database.execute("CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, author TEXT, duration TEXT, paragraph TEXT,"
              "category TEXT, type TEXT, taskID TEXT)").then((value)
          {
            print("DataBase Created !");
          }).catchError((error)
          {

            print("Error creating Database ERROR_CODE0[$error]");
          });
        },
        onOpen: (database)
        {

          getUserFlwRecord(database);
          emit(flowerGetRecordState());
          if(isSelected == 1)
          {
            changeTabScreen(1);
            emit(flowerAllTabState());
          }
        },
        version: 1).then((value)
    {
      database = value;
      emit(flowerCreateDatabaseState());
    });
  }

  // insertRecord to flowerDataBase
  Future insertFlwRecord(String title, String author, String duration, String paragraph, String category, String type, String id) async
  {
    return await database?.transaction((txn)
    {
      print("INSERT INTO tasks (title, author, duration, paragraph, category, type, taskID) "
          "VALUES ('$title', '$author', '$duration', '$paragraph', '$category', '$type', '$id')");
      return txn.rawInsert("INSERT INTO tasks (title, author, duration, paragraph, category, type, taskID) "
          "VALUES ('$title', '$author', '$duration', '$paragraph', '$category', '$type', '$id')").then((value)
      {
        emit(flowerInsertRecordState());
        getFlwRecord(database, id);
        if(isSelected == 1)
        {
          changeTabScreen(1);
          emit(flowerAllTabState());
        }
        else if(isSelected == 2)
        {
          changeTabScreen(2);
          emit(flowerLowTabState());
        }
        else if(isSelected == 3)
        {
          changeTabScreen(3);
          emit(flowerMediumTabState());
        }
        else if(isSelected == 4)
        {
          changeTabScreen(4);
          emit(flowerHighTabState());
        }
        else if(isSelected == 5) {
          changeTabScreen(5);
          emit(flowerVHighTabState());
        }

      }).catchError((error)
      {
        print("Error inserting record into Database ERROR_CODE0[$error]");
      });
    });
  }

  Future insertUserFlwRecord(String username, String password, String email, String phone) async
  {
    return await database?.transaction((txn)
    {
      var uuid = Uuid();
      String id = uuid.v4();
      return txn.rawInsert("INSERT INTO users (username, password, email, phone, accountID) "
          "VALUES ('$username', '$password', '$email', '$phone', '${id}')").then((value)
      {
        emit(flowerInsertRecordState());
        getUserFlwRecord(database);

      }).catchError((error)
      {
        print("Error inserting record into Database ERROR_CODE0[$error]");
      });
    });
  }

  // getRecord from flowerDataBase
  void getFlwRecord(database, userID)
  {
    allRecords = [];
    lowRecords = [];
    mediumRecords = [];
    highRecords = [];
    vHighRecords = [];
    doneRecords = [];
    searchRecords = [];
    inRecords = [];
    outRecords = [];
    database.rawQuery("SELECT * FROM tasks where taskID='${userID}'").then((value)
    {
      loadedRecords = value;
      value.forEach((element)
      {
        if(element['category'] == 'low')
        {
          allRecords.add(element);
          lowRecords.add(element);
        }
        else if(element['category'] == 'medium')
        {
          allRecords.add(element);
          mediumRecords.add(element);
        }
        else if(element['category'] == 'high')
        {
          allRecords.add(element);
          highRecords.add(element);
        }
        else if(element['category'] == 'very high')
        {
          allRecords.add(element);
          vHighRecords.add(element);
        }
        if(element['type'] == 'indoor')
        {
          inRecords.add(element);
        }
        if(element['type'] == 'outdoor')
        {
          outRecords.add(element);
        }

        if(element['category'] == 'done')
        {
          doneRecords.add(element);
        }
      });
      emit(flowerGetRecordState());
    });
  }

  void getUserFlwRecord(database)
  {
    users = [];
    database.rawQuery("SELECT * FROM users").then((value)
    {
      users = value;
      emit(flowerGetRecordState());
    });
  }

  void flowerUpdateRecord(String stat, int id, String taskID)
  {
    print("UPDATE tasks SET category = ${stat}, type = 'done' WHERE id = ${id}");
    database?.rawUpdate(
        "UPDATE tasks SET category = ?, type = 'done' WHERE id = ?",
        ['${stat}', id]).then((value)
    {

    }).then((value)
    {
      print("the task Id is ${userID}");
      getFlwRecord(database, taskID);
      if(isSelected == 1)
      {
        changeTabScreen(1);
        emit(flowerAllTabState());
      }
      else if(isSelected == 2)
      {
        changeTabScreen(2);
        emit(flowerLowTabState());
      }
      else if(isSelected == 3)
      {
        changeTabScreen(3);
        emit(flowerMediumTabState());
      }
      else if(isSelected == 4)
      {
        changeTabScreen(4);
        emit(flowerHighTabState());
      }
      else if(isSelected == 5) {
        changeTabScreen(5);
        emit(flowerVHighTabState());
      }
      emit(flowerModifyRecordState());
    });
  }

  bool flowerUpdatePasswordRecord(context, String username, String password, String newPassword)
  {
    database?.rawUpdate(
        "UPDATE users SET password = ? WHERE username = ? AND password = ?",
        ['${newPassword}', '${username}', '${password}']).then((value)
    {

    }).then((value)
    {
      bool val = login(context, username, password);
      if(val == true)
      {
        getUserFlwRecord(database);
        TextFailM = "Password Changed !";
        emit(flowerModifyRecordState());
        return true;
      }
      else
      {
        TextFailM = "incorrect username/password";
        emit(flowerFailedModifyState());
        return false;

      }
    }).catchError((error){
      print("error");
    });
    return false;
  }

  void flowerUpdateWholeRecord(String title, String author, String duration, String paragraph,
      String category, String type, int id, String taskID)
  {

    database?.rawUpdate(
        "UPDATE tasks SET title = ?, author = ?, duration = ?, category = ?, paragraph = ?, type = ? WHERE id = ?",
        ['${title}', '${author}', '${duration}', '${category}', '${paragraph}', '${type}', id]).then((value)
    {
    }).then((value)
    {
      getFlwRecord(database, taskID);
      if(isSelected == 1)
      {
        changeTabScreen(1);
        emit(flowerAllTabState());
      }
      else if(isSelected == 2)
      {
        changeTabScreen(2);
        emit(flowerLowTabState());
      }
      else if(isSelected == 3)
      {
        changeTabScreen(3);
        emit(flowerMediumTabState());
      }
      else if(isSelected == 4)
      {
        changeTabScreen(4);
        emit(flowerHighTabState());
      }
      else if(isSelected == 5) {
        changeTabScreen(5);
        emit(flowerVHighTabState());
      }
      emit(flowerModifyRecordState());
    });
  }

  // search for records
  void search(String searchText)
  {
    searchRecords = [];
    loadedRecords.forEach((element)
    {
      if(element['title'].contains(searchText))
      {
        searchRecords.add(element);
      }
    });

    emit(flowerGetSearchRes());
  }

  // fetch weather data
  void getWeatherData()
  {
    emit(flowerWeatherLoadingState());
    dioHelper.getData("/data/2.5/weather",
        {
          "q":"cairo",
          "appid": "28be3802c6ecbbddd43f4a5a785a20d0"
        }).then((value)
    {
      weatherRecord = value?.data;
      emit(flowerWeatherSuccessState());
    });
  }

  // deleteRecord from flowerDataBase
  void deleteDoneRecord(TaskID)
  {
    if(cacheHelper.getString("isLogged") == "yes")
    {
      TaskID = cacheHelper.getString("userID");
    }
    database?.rawDelete("DELETE FROM tasks WHERE category = 'done'").then((value)
    {
      getFlwRecord(database, TaskID);
      emit(flowerDeleteRecordState());
    });
  }


  void changeTheme()
  {
    isDark = !isDark;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(systemNavigationBarColor: isDark ?
    Color(0xFF150811) : Color(0xffFDECEF), statusBarColor:isDark ? Color(0xFF5B5B5B): Color(0xFFF0F3BD),
      statusBarIconBrightness: isDark ? Brightness.dark: Brightness.light));
    emit(flowerChangeTheme());
  }

}