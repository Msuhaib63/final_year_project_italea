

import 'package:final_year_project_italea/Content/Quiz/Loser.dart';
import 'package:final_year_project_italea/Content/Quiz/Winner.dart';
import 'package:final_year_project_italea/Theme/theme.dart';
import 'package:final_year_project_italea/Content/Belajar/Topic.dart';
import 'package:final_year_project_italea/Content/Quiz/Question.dart';
import 'package:final_year_project_italea/Content/Quiz/Quiz_intro.dart';
import 'package:final_year_project_italea/Home_page.dart';
import 'package:final_year_project_italea/Theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:final_year_project_italea/firebase_options.dart';

import 'Database/localDB.dart';
import 'Sub_Page/Loading_page.dart';
import 'Sub_Page/Log_Register/Login_page.dart';


// Variable to store the initial screen
int? initScreen;

// Main function
Future<void> main() async{

  // Ensure that widgets are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SharedPreferences to store user preferences
  SharedPreferences preferences = await SharedPreferences.getInstance();

  // Retrieve the stored value for the initial screen
  initScreen = await preferences.getInt('initScreen');

  // Set the initial screen value to 1 and store it in SharedPreferences
  await preferences.setInt('initScreen', 1);

  // Initialize Firebase with the specified options
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Run the application
  /*runApp(
    ChangeNotifierProvider(create: (context) => ThemeProvider(),
    child: const MyApp(),
    ),
  );*/
  runApp(const MyApp());
}

// MyApp class, which is the root of the application
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool isLogIn = false;

  getLoggedInState() async{
    await LocalDB.getUserID().then((value){
      setState((){
        isLogIn = value.toString() != "null" ;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getLoggedInState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // Configuration for the GetX state management library
      debugShowCheckedModeBanner: false,
      title: 'I-TaLea Application',
      //theme: Provider.of<ThemeProvider>(context).themeData,
      theme: ThemeData(
        fontFamily: 'RobotoMono',
        textTheme: TextTheme(),
        useMaterial3: true,
      ),

      home: isLogIn ? const HomePage() : const LoginPage(),

      // Set the initial route based on the value of initScreen
      initialRoute: initScreen == 0 || initScreen == null ? 'onboard' : 'login',

      // Define named routes for the application
      routes: {
        'login' : (context) => const LoginPage(),
        'onboard' : (context) => const LoadPage(),
        'home' : (context) => const HomePage(),
      },
    );
  }
}
