import 'package:flutter/material.dart';
import '../data/product_data.dart';
import 'detail_screen.dart';

class ProductListScreen extends StatefulWidget {
  final String categoryName;

  const ProductListScreen({super.key, required this.categoryName});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  bool isGridView = true; // default tampilan GridView

  @override
  Widget build(BuildContext context) {
    final filteredProducts =
        products.where((item) => item.category == widget.categoryName).toList();

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: Text(
          'Kategori: ${widget.categoryName}',
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.8,
        iconTheme: const IconThemeData(color: Colors.black),

        // ============================
        //   TOMBOL SWITCH VIEW (ICON)
        // ============================
        actions: [
          IconButton(
            icon: Icon(
              isGridView ? Icons.view_list : Icons.grid_view,
              color: Colors.black,
            ),
            onPressed: () {
              setState(() {
                isGridView = !isGridView;
              });
            },
          )
        ],
      ),

      // MENAMPILKAN LIST ATAU GRID
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: isGridView
            ? _buildGridView(filteredProducts)
            : _buildListView(filteredProducts),
      ),
    );
  }

  // =====================
  //   GRID VIEW (2 KOLOM)
  // =====================
  Widget _buildGridView(List filteredProducts) {
    return GridView.builder(
      itemCount: filteredProducts.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.72,
      ),
      itemBuilder: (context, index) {
        final product = filteredProducts[index];
        return _productGridItem(product);
      },
    );
  }

  // =====================
  //     LIST VIEW
  // =====================
  Widget _buildListView(List filteredProducts) {
    return ListView.builder(
      itemCount: filteredProducts.length,
      itemBuilder: (context, index) {
        final product = filteredProducts[index];
        return _productListItem(product);
      },
    );
  }

  // ==============================
  //   DESAIN ITEM GRID VIEW
  // ==============================
  Widget _productGridItem(product) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => DetailScreen(product: product)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.07),
              blurRadius: 6,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // gambar
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
              child: Image.asset(
                product.image,
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),

            // nama + harga
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Rp ${product.price}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: Colors.blueAccent,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==============================
  //       DESAIN LIST VIEW
  // ==============================
  Widget _productListItem(product) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => DetailScreen(product: product)),
        );
      },
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          product.image,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(
        product.name,
        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      ),
      subtitle: Text(
        "Rp ${product.price}",
        style: const TextStyle(color: Colors.blueAccent),
      ),
    );
  }
}
