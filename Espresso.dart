import 'ICoffee.dart';
import 'resources.dart';

class Espresso implements ICoffee {
  @override
  Resources get resources => Resources(coffeeBeans: 50, milk: 0, water: 100);

  @override
  int get price => 100;

  @override
  String get name => 'Эспрессо';
}
