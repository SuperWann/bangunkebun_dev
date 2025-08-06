import 'package:bangunkebun_dev/providers/ecommerceProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'productCard.dart';

class ProductsSection extends StatelessWidget {
  const ProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: const Color(0xFFFAFAFA),
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.black87,
                    fontSize: 16,
                    height: 1.3,
                  ),
                  children: [
                    TextSpan(
                      text: 'Semua Kebutuhan ',
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                    TextSpan(
                      text: 'Kebun Anda!',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF4CAF50),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Pupuk, Tanaman, Alat, dan Bibit',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 20),
              
              SizedBox(
                width: double.infinity,
                child: Consumer<EcommerceProvider>(
                  builder: (context, provider, child) {
                    return GridView.builder(
                      shrinkWrap: true, // Membuat GridView mengambil ruang yang dibutuhkan
                      physics: const NeverScrollableScrollPhysics(), // Menonaktifkan scroll internal
                      padding: EdgeInsets.only(
                        bottom: 100.h, // Padding tambahan untuk mencegah tertutup navbar, disesuaikan lebih besar
                      ),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}