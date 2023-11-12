import 'package:drug_management/constants/constants.dart';
import 'package:drug_management/pages/history_page/history_service.dart';
import 'package:drug_management/services/config_service.dart';

class ApplicationData {
  static DateTime? lastUseDate;
  static String? laConfig;
  static bool setupCompleted = false;

  static loadHomePageData() async {
    var historyService = HistoryService();
    lastUseDate = await historyService.getLastUseDate();

    var configService = ConfigService();
    for (var config in await configService.getConfigs()) {
      if (config.key == "la") {
        laConfig = config.value;
      }
    }
  }

  static setSetupCompleted() {
    setupCompleted = true;
    ConfigService().insert(StorageKeys.IsSetupCompleted, "true");
  }
}
