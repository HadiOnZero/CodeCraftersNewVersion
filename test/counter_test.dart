import 'package:flutter_test/flutter_test.dart';

void main() {
  test('first counter', () {
    var counter = 0;
    expect(counter, 0);
  });

  test('add counter', () {
    var counter = 0;
    counter++;
    expect(counter, 1);
  });
}
