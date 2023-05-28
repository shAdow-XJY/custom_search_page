import 'dart:async';
import 'package:sembast/sembast.dart';
import 'package:sembast_web/sembast_web.dart';

class IndexDB {
  final String _dbName = 'shadow._db';
  final String _storeName = 'search_records';
  late final Database _db;
  late final StoreRef _store;
  final Map<String, Object?> _cacheDB = {};

  Future<void> init() async {
    _db = await databaseFactoryWeb.openDatabase(_dbName);
    _store = stringMapStoreFactory.store(_storeName);
    final List<Object?> keys = await _store.findKeys(_db);
    for (var key in keys) {
      _cacheDB[key as String] = await _store.record(key).get(_db);
    }
  }

  Future<void> put(String key, Object? value) async {
    _cacheDB[key] = value;
    await _store.record(key).put(_db, value);
  }

  Object? get(String key) {
    if (_cacheDB.containsKey(key)) {
      return _cacheDB[key];
    }
    return null;
  }

  Future<void> delete(String key) async {
    _cacheDB.remove(key);
    await _store.record(key).delete(_db);
  }

  Future<void> deleteAll() async {
    _cacheDB.clear();
    await _store.delete(_db);
  }
}