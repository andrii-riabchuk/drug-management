import 'package:drug_management/constants/constants.dart';
import 'package:drug_management/custom_widgets/awaiting_data.dart';
import 'package:drug_management/custom_widgets/text_input.dart';
import 'package:drug_management/services/config_service.dart';
import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  Settings({super.key});
  final TextEditingController motivation1 = TextEditingController();

  Future<List<String>> getInitialTexts() async {
    var configService = ConfigService();
    List<String> res = [];

    final whyWait = await configService.getConfig(StorageKeys.Motivation_1);
    final whyStaySober =
        await configService.getConfig(StorageKeys.Motivation_2);

    res.add(whyWait == null ? "" : whyWait.value);
    res.add(whyStaySober == null ? "" : whyStaySober.value);

    return res;
  }

  late final loadData = getInitialTexts();

  @override
  Widget build(BuildContext context) {
    final configService = ConfigService();
    updateKey(String key, String val) {
      configService.insert(key, val);
    }

    onWhyWaitChanged(String val) => updateKey(StorageKeys.Motivation_1, val);
    onWhyStayChanged(String val) => updateKey(StorageKeys.Motivation_2, val);

    return FutureBuilder<List<String>>(
        future: loadData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final initialTexts = snapshot.data!;
            final whyWait = initialTexts[0], whyStaySober = initialTexts[1];

            return Scaffold(
                appBar: AppBar(
                    title: Text("Settings"),
                    leading: BackButton(onPressed: () {
                      Navigator.pop(context, "reload");
                    })),
                body: Center(
                    child: Padding(
                        padding: EdgeInsets.only(top: 0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SettingsTextField(
                                  "Why wait?", whyWait, onWhyWaitChanged),
                              SettingsTextField("Why stay sober?", whyStaySober,
                                  onWhyStayChanged)
                            ]))));
          } else if (snapshot.hasError) {
            return Text("Error");
          } else {
            return AwaitingData();
          }
        });
  }
}

class SettingsTextField extends StatelessWidget {
  const SettingsTextField(this.name, this.initialValue, this.onChange,
      {super.key});

  final String name;
  final String initialValue;
  final Function(String) onChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 20),
        child: Column(children: [
          Text(name),
          SizedBox(height: 10),
          SizedBox(
              width: 300,
              child: Container(
                  width: 200,
                  height: 150,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 28, 34, 44))),
                  child: TextFormField(
                    initialValue: initialValue,
                    expands: true,
                    maxLines: null,
                    keyboardType: TextInputType.text,
                    onChanged: onChange,
                  )))
        ]));
  }
}
