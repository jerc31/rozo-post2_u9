import '../model/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts();
}

class FakeProductRepository implements ProductRepository {
  @override
  Future<List<Product>> getProducts() async {
    // Simulamos un delay de red
    await Future.delayed(const Duration(seconds: 2));
    
    return [
      Product(id: '1', name: 'Laptop Pro 16', price: 2499.99),
      Product(id: '2', name: 'Smartphone Z', price: 999.00),
      Product(id: '3', name: 'Auriculares Noise Cancel', price: 299.50),
      Product(id: '4', name: 'Monitor 4K 27"', price: 450.00),
      Product(id: '5', name: 'Teclado Mecánico RGB', price: 120.00),
    ];
  }
}
