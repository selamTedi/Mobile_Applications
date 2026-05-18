import '../models/coffee_model.dart';
import '../providers/coffee_api_provider.dart';

class CoffeeRepository {
  final CoffeeApiProvider apiProvider;
  final List<CoffeeModel> _cachedMenu = [];

  CoffeeRepository({required this.apiProvider});

  Future<List<CoffeeModel>> getCoffeeMenu() async {
    if (_cachedMenu.isEmpty) {
      final remoteData = await apiProvider.fetchCoffeesFromApi();
      _cachedMenu.addAll(remoteData);
    }
    return List.unmodifiable(_cachedMenu);
  }

  Future<void> addCoffeeItem(CoffeeModel item) async {
    _cachedMenu.add(item);
  }

  Future<void> updateCoffeeItem(CoffeeModel updatedItem) async {
    final index =
        _cachedMenu.indexWhere((element) => element.id == updatedItem.id);
    if (index != -1) {
      _cachedMenu[index] = updatedItem;
    }
  }

  Future<void> deleteCoffeeItem(String id) async {
    _cachedMenu.removeWhere((element) => element.id == id);
  }
}
