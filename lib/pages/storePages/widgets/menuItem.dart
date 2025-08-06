import 'package:bangunkebun_dev/pages/productPage/ProductPage.dart';
import 'package:bangunkebun_dev/pages/storePages/widgets/menuItemcard.dart';
import 'package:flutter/material.dart';


class MenuItemsWidget extends StatelessWidget {
  const MenuItemsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MenuItemCard(
          icon: Icons.inventory_2_outlined,
          title: 'Produk',
          iconColor: const Color(0xFF2E7D32),
          onTap: () {
            print('Navigate to ProductPage');
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProductPage()),
            );
          },
        ),
        const SizedBox(height: 12),
        MenuItemCard(
          icon: Icons.receipt_long,
          title: 'Status Pesanan',
          iconColor: const Color(0xFF2E7D32),
          onTap: () {
            print('Navigate to Status Pesanan page');
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => const OrderStatusPage()),
            // );
          },
        ),
        const SizedBox(height: 12),
        MenuItemCard(
          icon: Icons.payment,
          title: 'Metode Pembayaran',
          iconColor: const Color(0xFF2E7D32),
          onTap: () {
            print('Navigate to Metode Pembayaran page');
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => const PaymentMethodPage()),
            // );
          },
        ),
        const SizedBox(height: 12),
        MenuItemCard(
          icon: Icons.history,
          title: 'Riwayat Penjualan',
          iconColor: const Color(0xFF2E7D32),
          onTap: () {
            print('Navigate to Riwayat Penjualan page');
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => const OrderHistoryPage()),
            // );
          },
        ),
      ],
    );
  }
}