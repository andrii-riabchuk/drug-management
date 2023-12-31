import 'package:drug_management/constants/constants.dart';
import 'package:drug_management/pages/history/history_page.dart';
import 'package:drug_management/pages/history/record_page.dart';
import 'package:drug_management/pages/home/home_page.dart';
import 'package:drug_management/pages/intro/intro_page.dart';
import 'package:drug_management/pages/party/i_want_it.dart';
import 'package:drug_management/pages/party/party.dart';
import 'package:drug_management/pages/secret/secret_page.dart';
import 'package:drug_management/pages/secret/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      title: 'DrugManagement',
      theme: ThemeData(
        useMaterial3: false,
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      initialRoute: Routes.Home,
      // home: MyHomePage()
      routes: {
        Routes.Setup: (context) => const MyIntroPage(),
        Routes.Home: (context) => ChangeNotifierProvider(
            create: (context) => MyAppState(), child: Home()),
        Routes.Party: (context) => const PartyPage(),
        Routes.Secret: (context) => const SecretPage(),
        Routes.History: (context) => ChangeNotifierProvider(
            create: (context) => HistoryRowsState(), child: HistoryPage()),
        Routes.Record: (context) => RecordPage(),
        Routes.Settings: (context) => Settings()
      },
    );
  }
}
