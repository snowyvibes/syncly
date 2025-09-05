import 'package:flutter_test/flutter_test.dart';

class Cart {
  final List<String> _items = [];

  void addItem(String item) => _items.add(item);
  void removeItem(String item) {
    if (_items.contains(item)) {
      _items.remove(item);
    } else {
      throw Exception('Item not in cart');
    }
  }

  int get itemCount => _items.length;
}

void main() {
  group('Testing Cart Class', () {
    test('Cart is empty at start', () {
      final Cart cart = Cart();
      expect(cart.itemCount, 0);
    });
    test('Add item is working', () {
      final Cart cart = Cart();
      final numOfItems = cart.itemCount;

      cart.addItem('Added Item');
      expect(cart.itemCount, numOfItems + 1);
    });

    test('Remove item is working', () {
      final Cart cart = Cart();

      cart.addItem('Added Item');

      final prevCount = cart.itemCount;

      cart.removeItem('Added Item');

      expect(cart.itemCount, prevCount - 1);
    });
    test('Remove item is throwing exception', () {
      final Cart cart = Cart();

      const String item = 'Added Item';

      expect(() => cart.removeItem(item), throwsA(isA<Exception>()));
    });
  });
}
