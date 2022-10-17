import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Created by Dev 1051 on 7/13/2021
/// Modified by Dev 2301 on 7/29/2021
/// Purpose : This is a helper class for shared preference
/// save data in secure offline storage
class SharedPreferenceService {
  SharedPreferenceService();

  FlutterSecureStorage storage = const FlutterSecureStorage();

  /// Created by Dev 1051 on 7/13/2021
  /// Modified by Dev 1051 on 7/13/2021
  /// Purpose : This method is used to add string to shared preference.
  Future<bool> addStringToSF(String key, String value) async {
    await storage.write(key: key, value: value);
    return true;
  }

  /// Created by Dev 1051 on 7/13/2021
  /// Modified by Dev 1051 on 7/13/2021
  /// Purpose : This method is used to add int to shared preference.
  Future<bool> addIntToSF(String key, int value) async {
    await storage.write(key: key, value: value.toString());
    return true;
  }

  /// Created by Dev 1051 on 7/13/2021
  /// Modified by Dev 1051 on 7/13/2021
  /// Purpose : This method is used to add double to shared preference.
  Future<bool> addDoubleToSF(String key, double value) async {
    // await storage.write(key: key, value: value.toString());
    return true;
  }

  /// Created by Dev 1051 on 7/13/2021
  /// Modified by Dev 1051 on 7/13/2021
  /// Purpose : This method is used to add boolean to shared preference.
  // ignore: avoid_positional_boolean_parameters
  Future<bool> addBoolToSF(String key, bool value) async {
    // await storage.write(key: key, value: value.toString());
    return true;
  }

  /// Created by Dev 1051 on 7/13/2021
  /// Modified by Dev 1051 on 7/13/2021
  /// Purpose : This method is used to get string value from preference.
  Future<String?> getStringValuesSF(String key) async {
    // Return String
    final result = await storage.read(key: key);
    if (key != "") {
      return result;
    } else {
      return "";
    }
  }

  /// Created by Dev 1051 on 7/13/2021
  /// Modified by Dev 2196 on 7/13/2021
  /// Purpose : This method is used to get boolean value from preference.
  Future<bool?> getBoolValuesSF(String key) async {
    //Return bool
    // final result = await storage.read(key: key);
    return true;
  }

  /// Created by Dev 1051 on 7/13/2021
  /// Modified by Dev 1051 on 7/13/2021
  /// Purpose : This method is used to get integer value from preference.
  Future<int> getIntValuesSF(String key) async {
    //Return int
    final result = await storage.read(key: key);
    return result != null ? int.parse(result) : 0;
  }

  /// Created by Dev 1051 on 7/13/2021
  /// Modified by Dev 1051 on 7/13/2021
  /// Purpose : This method is used to get double value from preference.
  Future<double?> getDoubleValuesSF(String key) async {
    //Return double
    // final result = await storage.read(key: key);
    return 0.0;
  }

  /// Created by Dev 1051 on 7/13/2021
  /// Modified by Dev 1051 on 7/13/2021
  /// Purpose : This method is used to remove value of given
  /// key from preference.
  Future<bool> removeValue(String key) async {
    await storage.delete(key: key);
    return true;
  }

  /// Created by Dev 1051 on 7/30/2021
  /// Modified by Dev 1051 on 7/30/2021
  /// Purpose : This method is used to flush secureStorage.
  Future<void> removeAllData() async {
    // await storage.deleteAll();
  }
}
