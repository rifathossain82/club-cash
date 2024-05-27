import 'package:club_cash/src/core/enums/app_enum.dart';
import 'package:club_cash/src/core/utils/app_constants.dart';
import 'package:get_storage/get_storage.dart';

class LocalStorage{
  static final _box = GetStorage(AppConstants.packageName);

  static saveData({required LocalStorageKey key, required dynamic data})async{
    await _box.write(key.toString(), data);
  }

  static getData({required LocalStorageKey key}){
    return _box.read(key.toString());
  }

  static removeData({required LocalStorageKey key})async{
    await _box.remove(key.toString());
  }

  static removeAllData()async{
    await _box.erase();
  }
}