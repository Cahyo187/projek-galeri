import 'package:get_storage/get_storage.dart';

class StorageProvider {
  static write(key, String value) async {
    await GetStorage().write(key, value);
  }

  static String read(key) {
    try {
      var value = GetStorage().read(key);
      if (value is String) {
        return value;
      } else {
        return "";
      }
    } catch (e) {
      return "";
    }
  }

  static void clearAll() {
    GetStorage().erase();
  }
}

class StorageKey {
  static const String status = "status";
  static const String nama = "nama";
  static const String idUser = "idUser";
  static const String tokenUser = "tokenUser";
  static const String email = "email";
  static const String showBanner = "true";
  static const String username = "username";
}
