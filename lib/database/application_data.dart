import 'package:drug_management/constants/constants.dart';
import 'package:drug_management/pages/history_page/history_service.dart';
import 'package:drug_management/services/config_service.dart';

class ApplicationData {
  static DateTime? lastUseDate;
  static String? laConfig;
  static bool setupCompleted = false;
  static int iWantItCount = 0;

  static Future<bool> loadHomePageData() async {
    var historyService = HistoryService();
    lastUseDate = await historyService.getLastUseDate();

    var configService = ConfigService();
    for (var config in await configService.getConfigs()) {
      if (config.key == StorageKeys.IsSetupCompleted &&
          config.value == 'true') {
        setupCompleted = true;
      } else if (config.key == StorageKeys.I_WANT_IT) {
        iWantItCount = int.parse(config.value);
      }
    }

    return true;
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
