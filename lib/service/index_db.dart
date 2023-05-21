import 'dart:async';
import 'package:custom_search_page/service/store_key.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast_web/sembast_web.dart';

class IndexDB {
  final DatabaseFactory idbFactory = databaseFactoryWeb;
  final String _dbName = 'shadow._db';
  final String _storeName = 'search_records';
  late final Database _db;
  late final StoreRef _store;

  Future<void> init() async {
    _db = await idbFactory.openDatabase(_dbName);
    _store = stringMapStoreFactory.store(_storeName);
    if (await get(StoreKey.isCustomBackImg) == null) {
      await put(StoreKey.isCustomBackImg, false);
    }
    if (await get(StoreKey.customBackImgEncode) == null) {
      await put(StoreKey.customBackImgEncode, '');
    }
  }

  Future<void> put(String key, dynamic value) async {
    await _store.record(key).put(_db, value);
  }

  Future<Object?> get(String key) async {
    final Object? value = await _store.record(key).get(_db);
    print('value == null');
    print(value == null);
    return value;
  }

  Future<void> delete(String key) async {
    await _store.record(key).delete(_db);
  }
}