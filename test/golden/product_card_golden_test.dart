import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rizo_post2_u9/model/product.dart';
import 'package:rizo_post2_u9/widgets/product_card.dart';

void main() {
  final product = Product(
    id: '101',
    name: 'Teclado Mecánico Pro',
    price: 150.0,
  );

  testWidgets('Golden Test - ProductCard Light Theme', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(brightness: Brightness.light),
        home: Scaffold(
          body: Center(
            child: ProductCard(product: product),
          ),
        ),
      ),
    );

    await expectLater(
      find.byType(ProductCard),
      matchesGoldenFile('../goldens/product_card_light.png'),
    );
  });

  testWidgets('Golden Test - ProductCard Dark Theme', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(brightness: Brightness.dark),
        home: Scaffold(
          body: Center(
            child: ProductCard(product: product),
          ),
        ),
      ),
    );

    await expectLater(
      find.byType(ProductCard),
      matchesGoldenFile('../goldens/product_card_dark.png'),
    );
  });
}
