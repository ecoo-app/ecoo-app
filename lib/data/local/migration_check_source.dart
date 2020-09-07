import 'dart:convert';

import 'package:e_coupon/ui/core/constants.dart';
import 'package:e_coupon/ui/screens/start/migration_check_item.dart';
import 'package:injectable/injectable.dart';
import 'package:localstorage/localstorage.dart';

abstract class IMigrationCheckSource {
  Future<void> save(List<MigrationCheckItem> migrationChecks);
  Future<List<MigrationCheckItem>> getChecks();
  Future<void> eraseAll();
}

@LazySingleton(as: IMigrationCheckSource)
class MigrationCheckSource implements IMigrationCheckSource {
  final LocalStorage _storage;

  MigrationCheckSource(this._storage);

  String _migrationChecksToJson(List<MigrationCheckItem> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

  @override
  Future<void> save(List<MigrationCheckItem> migrationChecks) async {
    await _storage.ready;
    return _storage.setItem(
        Constants.localMigrationCheck, _migrationChecksToJson(migrationChecks));
  }

  List<MigrationCheckItem> _migrationChecksFromJson(String str) =>
      List<MigrationCheckItem>.from(
          json.decode(str).map((x) => MigrationCheckItem.fromJson(x)));

  @override
  Future<List<MigrationCheckItem>> getChecks() async {
    await _storage.ready;
    var result = _storage.getItem(Constants.localMigrationCheck);
    if (result != null) {
      return _migrationChecksFromJson(result);
    } else {
      return [];
    }
  }

  @override
  Future<void> eraseAll() async {
    await _storage.ready;
    await _storage.deleteItem(Constants.localMigrationCheck);
  }
}
