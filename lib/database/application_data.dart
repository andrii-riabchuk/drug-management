import 'package:drug_management/constants/constants.dart';
import 'package:drug_management/database/models/config/config.dart';
import 'package:drug_management/database/models/record/record.dart';
import 'package:drug_management/pages/history/history_service.dart';
import 'package:drug_management/services/config_service.dart';

class ApplicationData {
  static Record? lastUseRecord;
  static String whyWaitMessage = "";
  static String whyStaySoberMessage = "";

  static bool setupCompleted = false;
  static int iWantItCount = 0;

  static Function homePageReload = () => {};

  static Future<bool> loadHomePageData() async {
    var historyService = HistoryService();
    lastUseRecord = await historyService.getLastUseDate();

    var configService = ConfigService();
    var requestConfigs = [
      StorageKeys.IsSetupCompleted,
      StorageKeys.I_WANT_IT,
      StorageKeys.Motivation_1,
      StorageKeys.Motivation_2
    ];
    var configs = await configService.getConfigsByKey(requestConfigs);
    setupCompletedFrom(configs[StorageKeys.IsSetupCompleted]);
    iwantitFrom(configs[StorageKeys.I_WANT_IT]);
    motivationMessagesFrom(
        configs[StorageKeys.Motivation_1], configs[StorageKeys.Motivation_2]);

    return true;
  }

  static setupCompletedFrom(Config? config) {
    if (config == null) return;
    if (config.value == 'true') setupCompleted = true;
  }

  static iwantitFrom(Config? config) {
    if (config == null) return;
    iWantItCount = int.parse(config.value);
  }

  static motivationMessagesFrom(Config? motConfig1, Config? motConfig2) {
    if (motConfig1 != null) {
      whyWaitMessage = motConfig1.value;
    }
    if (motConfig2 != null) {
      whyStaySoberMessage = motConfig2.value;
    }
  }

  static setSetupCompleted() {
    setupCompleted = true;
    ConfigService().insert(StorageKeys.IsSetupCompleted, "true");
  }

  static saveIwantItCount(int count) {
    iWantItCount = count;
    ConfigService().insert(StorageKeys.I_WANT_IT, count.toString());
  }
}
