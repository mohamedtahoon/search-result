import 'package:search_task/core/base/prefs/pref_keys.dart';
import 'package:search_task/core/base/prefs/pref_util.dart';

class PrefManager {
  PrefUtils prefUtils = PrefUtils();

  setLang(String data) {
    return prefUtils.saveData<String>(PrefKeys.lang, data);
  }

  Future<String?> getLang() async {
    return await prefUtils.getData<String?>(PrefKeys.lang);
  }
}
