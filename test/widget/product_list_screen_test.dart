import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rizo_post2_u9/bloc/product_bloc.dart';
import 'package:rizo_post2_u9/model/product.dart';
import 'package:rizo_post2_u9/screen/product_list_screen.dart';

class MockProductBloc extends MockBloc<ProductEvent, ProductState> implements ProductBloc {}

void main() {
  late MockProductBloc mockProductBloc;

  setUp(() {
    mockProductBloc = MockProductBloc();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider<ProductBloc>.value(
        value: mockProductBloc,
        child: const ProductListScreen(),
      ),
    );
  }

  group('Checkpoint 1 - ProductListScreen Tests', () {
    testWidgets('1. Debe mostrar CircularProgressIndicator en estado Loading', (tester) async {
      when(() => mockProductBloc.state).thenReturn(ProductLoading());
      await tester.pumpWidget(createWidgetUnderTest());
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('2. Debe mostrar la lista de productos en estado Success', (tester) async {
      final products = [Product(id: '1', name: 'Laptop Pro', price: 1500.0)];
      when(() => mockProductBloc.state).thenReturn(ProductSuccess(products));
      await tester.pumpWidget(createWidgetUnderTest());
      expect(find.text('Laptop Pro'), findsOneWidget);
      expect(find.text('\$1500.00'), findsOneWidget);
    });

    testWidgets('3. Debe mostrar mensaje de error y disparar LoadProducts al reintentar', (tester) async {
      when(() => mockProductBloc.state).thenReturn(ProductError('Error de conexión'));
      await tester.pumpWidget(createWidgetUnderTest());
      
      expect(find.text('Error de conexión'), findsOneWidget);
      final retryButton = find.byKey(const Key('retry_button'));
      expect(retryButton, findsOneWidget);

      await tester.tap(retryButton);
      verify(() => mockProductBloc.add(LoadProducts())).called(1);
    });
  });
}
