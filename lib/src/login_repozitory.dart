import 'dart:math';

import 'package:products/domain/model/product_model.dart';
import 'local_data_source.dart';
import 'package:products/service/all_package.dart';

abstract class UserRepository {
  Future<bool> storeHistory(List<CartItem> history);

  Future<bool> deleteProduct();

  List<HistorySRC> readHistory();

  Future<bool> clareCache();
}

class UserRepositoryImplements implements UserRepository {
  final LocalDataSource dataSource;

  const UserRepositoryImplements({required this.dataSource});

  @override
  Future<bool> clareCache() {
    return dataSource.remove(StorageKey.history);
  }

  @override
  List<HistorySRC> readHistory() {
    try {
      String data = dataSource.read(StorageKey.history) ?? "[]";
      final json = jsonDecode(data) as List;
      final list = json.map((e) => HistorySRC.fromJson(e as Map<String, Object?>)).toList();
      return list;
    } catch (e) {
      debugPrint("Error readHistory => $e");
      return [];
    }
  }

  @override
  Future<bool> storeHistory(List<CartItem> history) async {
    try {
      final list = readHistory();
      HistorySRC historySRC = HistorySRC(history: history, id: Random().nextInt(100));
      list.add(historySRC);
      final json = list.map((e) => e.toJson()).toList();
      final data = jsonEncode(json);
      return await dataSource.store(StorageKey.history, data);
    } catch (e) {
      debugPrint("storeHistory Error: => $e");
      return false;
    }
  }

  @override
  Future<bool> deleteProduct() async {
    final list = readHistory();
    list.clear();
    final json = list.map((e) => e.toJson()).toList();
    final data = jsonEncode(json);
    return dataSource.store(StorageKey.history, data);
  }
}
