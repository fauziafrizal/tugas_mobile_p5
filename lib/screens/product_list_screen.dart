import 'package:flutter/material.dart';
import '../data/product_data.dart';
import 'detail_screen.dart';

class ProductListScreen extends StatelessWidget {
  final String categoryName;

  const ProductListScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    final filteredProducts =
        products.where((item) => item.category == categoryName).toList();

    return Scaffold(
      // ✅ Background putih seluruh halaman
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: Text(
          'Kategori: $categoryName',
          style: const TextStyle(color: Colors.black), // ✅ teks hitam
        ),
        centerTitle: true,
        backgroundColor: Colors.white, // ✅ AppBar putih
        elevation: 0.5, // ✅ sedikit shadow biar rapi
        iconTheme: const IconThemeData(color: Colors.black), // ✅ icon back hitam
      ),

      body: ListView.builder(
        itemCount: filteredProducts.length,
        itemBuilder: (context, index) {
          final product = filteredProducts[index];

          return ListTile(
            tileColor: Colors.white, // ✅ item tetap putih
            leading: Image.asset(
              product.image,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(
              product.name,
              style: const TextStyle(color: Colors.black), // ✅ teks hitam
            ),
            subtitle: Text(
              'Rp ${product.price}',
              style: const TextStyle(color: Colors.black54), // ✅ abu elegan
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(product: product),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
