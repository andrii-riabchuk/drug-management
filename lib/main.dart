import 'package:drug_management/constants/constants.dart';
import 'package:drug_management/pages/history_page/history_page.dart';
import 'package:drug_management/pages/home_page/home_page.dart';
import 'package:drug_management/pages/intro_page/intro_page.dart';
import 'package:drug_management/pages/party/iwant_meph.dart';
import 'package:drug_management/pages/party/party.dart';
import 'package:drug_management/pages/party/secret_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();

  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.prefs,
  });

  final SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      title: 'DrugManagement',
      // theme: ThemeData(
      //   useMaterial3: true,
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      // ),
      initialRoute: Routes.Home,
      // home: MyHomePage()
      routes: {
        Routes.Setup: (context) => const MyIntroPage(),
        Routes.Home: (context) => ChangeNotifierProvider(
            create: (context) =>
                MyAppState(current: prefs.getInt("wantMeph") ?? 0),
            child: MyHomePage(sp: prefs)),
        Routes.Party: (context) => const PartyPage(),
        Routes.Secret: (context) => const SecretPage(),
        Routes.History: (context) => HistoryPage(sp: prefs)
      },
    );
  }
}
