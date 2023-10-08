import 'package:drug_management/home_page.dart';
import 'package:drug_management/intro_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // prefs.clear();
  
  runApp(MaterialApp(
    // debugShowCheckedModeBanner: false,
    title: 'DrugManagement',
    // theme: ThemeData(
    //   useMaterial3: true,
    //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
    // ),
    initialRoute: "/",
    // home: MyHomePage()
    routes: {
      '/': (context) => ChangeNotifierProvider(
          create: (context) =>
              MyAppState(current: prefs.getInt("wantMeph") ?? 0),
          child: MyHomePage(sp: prefs)),
      '/setup': (context) => const MyIntroPage()
    },
  ));
}
