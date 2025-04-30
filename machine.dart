import 'ICoffee.dart';
import 'AsyncProcess.dart';

class Machine {
  int _coffeeBeans = 500;
  int _milk = 1000;
  int _water = 2000;
  int _cash = 0;

  int get coffeeBeans => _coffeeBeans;
  int get milk => _milk;
  int get water => _water;
  int get cash => _cash;

  set coffeeBeans(int value) => _coffeeBeans = value;
  set milk(int value) => _milk = value;
  set water(int value) => _water = value;
  set cash(int value) => _cash = value;

  bool isAvailable(ICoffee coffee) {
    final res = coffee.resources;
    return _coffeeBeans >= res.coffeeBeans &&
        _milk >= res.milk &&
        _water >= res.water;
  }

  void resetCash() {
    _cash = 0;
  }

  Future<String> makeCoffee(ICoffee coffee) async {
    if (!isAvailable(coffee)) {
      return 'Недостаточно ресурсов для ${coffee.name}.';
    }

    final res = coffee.resources;
    _coffeeBeans -= res.coffeeBeans;
    _milk -= res.milk;
    _water -= res.water;
    _cash += coffee.price;

    print('--- Начало приготовления: ${coffee.name} ---');
    await AsyncProcess.prepareCoffee(needsMilk: res.milk > 0);
    print('--- Завершено приготовление: ${coffee.name} ---');

    return '${coffee.name} подан!';
  }
}
