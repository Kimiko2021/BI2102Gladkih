import 'resources.dart';
import 'ICoffee.dart';

class Machine {
  int _coffeeBeans = 0;
  int _milk = 0;
  int _water = 0;
  int _cash = 0;

  void refill({int beans = 0, int milk = 0, int water = 0}) {
    _coffeeBeans += beans;
    _milk += milk;
    _water += water;
  }

  bool isAvailable(ICoffee coffee) {
    var res = coffee.resources;
    return _coffeeBeans >= res.coffeeBeans &&
        _milk >= res.milk &&
        _water >= res.water;
  }

  String makeCoffee(ICoffee coffee) {
    if (!isAvailable(coffee)) {
      return 'Недостаточно ресурсов для ${coffee.name}.';
    }
    var res = coffee.resources;
    _coffeeBeans -= res.coffeeBeans;
    _milk -= res.milk;
    _water -= res.water;
    _cash += coffee.price;
    return 'Ваш ${coffee.name} готов!';
  }

  int withdrawCash() {
    int withdrawn = _cash;
    _cash = 0;
    return withdrawn;
  }

  String status() {
    return '''
Кофейные зёрна: $_coffeeBeans г
Молоко: $_milk мл
Вода: $_water мл
Деньги: $_cash ₽
''';
  }
}
