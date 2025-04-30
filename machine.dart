class Machine {
  // Закрытые поля ресурсов
  int _coffeeBeans = 0;
  int _milk = 0;
  int _water = 0;
  int _cash = 0;

  // Геттеры
  int get coffeeBeans => _coffeeBeans;
  int get milk => _milk;
  int get water => _water;
  int get cash => _cash;

  // Сеттеры
  set coffeeBeans(int value) => _coffeeBeans = value;
  set milk(int value) => _milk = value;
  set water(int value) => _water = value;
  set cash(int value) => _cash = value;

  // Проверка доступности ресурсов для эспрессо
  bool isAvailable({int beans = 50, int milk = 0, int water = 100}) {
    return _coffeeBeans >= beans && _milk >= milk && _water >= water;
  }

  // Приватный метод уменьшения ресурсов
  void _subtractResources({int beans = 50, int milk = 0, int water = 100}) {
    _coffeeBeans -= beans;
    _milk -= milk;
    _water -= water;
  }

  // Приготовление кофе
  String makeCoffee(String type) {
    switch (type.toLowerCase()) {
      case 'эспрессо':
        if (isAvailable(beans: 50, water: 100)) {
          _subtractResources(beans: 50, water: 100);
          _cash += 100;
          return 'Ваш эспрессо готов!';
        }
        return 'Недостаточно ресурсов для эспрессо.';
      case 'латте':
        if (isAvailable(beans: 50, milk: 100, water: 100)) {
          _subtractResources(beans: 50, milk: 100, water: 100);
          _cash += 150;
          return 'Ваш латте готов!';
        }
        return 'Недостаточно ресурсов для латте.';
      case 'капучино':
        if (isAvailable(beans: 50, milk: 50, water: 100)) {
          _subtractResources(beans: 50, milk: 50, water: 100);
          _cash += 130;
          return 'Ваш капучино готов!';
        }
        return 'Недостаточно ресурсов для капучино.';
      default:
        return 'Неизвестный вид кофе.';
    }
  }

  // Пополнение ресурсов
  void refill({int beans = 0, int milk = 0, int water = 0}) {
    _coffeeBeans += beans;
    _milk += milk;
    _water += water;
  }

  // Инкассация
  int withdrawCash() {
    int withdrawn = _cash;
    _cash = 0;
    return withdrawn;
  }

  // Текущее состояние
  String status() {
    return '''
Кофейные зёрна: $_coffeeBeans г
Молоко: $_milk мл
Вода: $_water мл
Деньги: $_cash ₽
''';
  }
}
