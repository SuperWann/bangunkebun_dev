import 'package:bangunkebun_dev/providers/productProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';


class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductProvider()..fetchProducts(),
      child: const ProductView(),
    );
  }
}

class ProductView extends StatelessWidget {
  const ProductView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      systemStatusBarContrastEnforced: false,
    ));

    final provider = Provider.of<ProductProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: const Color(0xFFFAFAFA),
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text(
              'Produk',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            centerTitle: true,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 44,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF5F5F5),
                              borderRadius: BorderRadius.circular(22),
                            ),
                            child: Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: Icon(
                                    Icons.search,
                                    color: Color(0xFF9E9E9E),
                                    size: 20,
                                  ),
                                ),
                                Expanded(
                                  child: TextField(
                                    cursorColor: const Color(0xFF4CAF50),
                                    decoration: const InputDecoration(
                                      hintText: 'Cari',
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                        color: Color(0xFF9E9E9E),
                                        fontSize: 14,
                                      ),
                                    ),
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 14.sp,
                                    ),
                                    onChanged: (value) {
                                      provider.setSearchQuery(value);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            showDialog(
                              context: context,
                              barrierColor: Colors.black54,
                              builder: (context) => Dialog(
                                backgroundColor: Colors.transparent,
                                child: Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 24),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 20,
                                        offset: const Offset(0, 10),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(20),
                                        decoration: const BoxDecoration(
                                          color: Color(0xFFF8F9FA),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(16),
                                            topRight: Radius.circular(16),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 32,
                                              height: 32,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF4CAF50),
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              child: const Icon(
                                                Icons.sort,
                                                color: Colors.white,
                                                size: 18,
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            const Text(
                                              'Urutkan Berdasarkan',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFF212121),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Column(
                                          children: [
                                            _buildSortOption(
                                              context: context,
                                              icon: Icons.arrow_upward,
                                              title: 'Harga Terendah',
                                              subtitle: 'Urutkan dari harga terendah ke tertinggi',
                                              onTap: () {
                                                provider.sortProducts('price_low');
                                                Navigator.pop(context);
                                              },
                                            ),
                                            const Divider(
                                              height: 1,
                                              color: Color(0xFFE0E0E0),
                                            ),
                                            _buildSortOption(
                                              context: context,
                                              icon: Icons.arrow_downward,
                                              title: 'Harga Tertinggi',
                                              subtitle: 'Urutkan dari harga tertinggi ke terendah',
                                              onTap: () {
                                                provider.sortProducts('price_high');
                                                Navigator.pop(context);
                                              },
                                            ),
                                            const Divider(
                                              height: 1,
                                              color: Color(0xFFE0E0E0),
                                            ),
                                            _buildSortOption(
                                              context: context,
                                              icon: Icons.sort_by_alpha,
                                              title: 'Nama A-Z',
                                              subtitle: 'Urutkan nama dari A sampai Z',
                                              onTap: () {
                                                provider.sortProducts('name_az');
                                                Navigator.pop(context);
                                              },
                                            ),
                                            const Divider(
                                              height: 1,
                                              color: Color(0xFFE0E0E0),
                                            ),
                                            _buildSortOption(
                                              context: context,
                                              icon: Icons.sort_by_alpha,
                                              title: 'Nama Z-A',
                                              subtitle: 'Urutkan nama dari Z sampai A',
                                              iconTransform: Matrix4.rotationY(3.14159),
                                              onTap: () {
                                                provider.sortProducts('name_za');
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(16),
                                        child: TextButton(
                                          onPressed: () => Navigator.pop(context),
                                          style: TextButton.styleFrom(
                                            backgroundColor: const Color(0xFFF5F5F5),
                                            padding: const EdgeInsets.symmetric(vertical: 12),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: const Text(
                                            'Batal',
                                            style: TextStyle(
                                              color: Color(0xFF757575),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: const Color(0xFF4CAF50),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.tune,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: const Color(0xFFFAFAFA),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Consumer<ProductProvider>(
                          builder: (context, provider, child) {
                            if (provider.filteredProducts.isEmpty) {
                              return const Center(child: CircularProgressIndicator());
                            }
                            return GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.only(bottom: 100.h),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.78,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 16,
                              ),
                              itemCount: provider.filteredProducts.length,
                              itemBuilder: (context, index) {
                                final product = provider.filteredProducts[index];
                                return ProductCard(product: product);
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddProductPage(),
                ),
              );
            },
            backgroundColor: const Color(0xFF4CAF50),
            label: const Text(
              'Tambah Produk',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            icon: const Icon(Icons.add, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildSortOption({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Matrix4? iconTransform,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Transform(
                  alignment: Alignment.center,
                  transform: iconTransform ?? Matrix4.identity(),
                  child: Icon(
                    icon,
                    color: const Color(0xFF4CAF50),
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF212121),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF757575),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: Color(0xFF9E9E9E),
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ManageProductDetailPage(product: product),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFF8F9FA),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.network(
                        product.imageAsset,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name.length > 18 ? '${product.name.substring(0, 18)}...' : product.name,
                          style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                            height: 1.2,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Stok: ${product.stock}',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 10,
                            color: Colors.grey[600],
                            height: 1.2,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Text(
                      'Rp ${product.price}',
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4CAF50),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}