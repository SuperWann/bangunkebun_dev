import 'package:bangunkebun_dev/models/ecommerce.dart';
import 'package:bangunkebun_dev/pages/ecommercePage.dart/myOrderPage.dart';
import 'package:flutter/material.dart';

class PaymentConfirmationDialog extends StatelessWidget {
  final Product product;
  final int quantity;
  final int totalPrice;
  final String selectedShipping;
  final String? selectedPayment;

  const PaymentConfirmationDialog({
    super.key,
    required this.product,
    required this.quantity,
    required this.totalPrice,
    required this.selectedShipping,
    required this.selectedPayment,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.green[100],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.shopping_cart,
                color: Colors.green[600],
                size: 28,
              ),
            ),
            const SizedBox(height: 20),
            
            // Title
            const Text(
              'Konfirmasi\nPembayaran',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 16),
            
            // Content
            const Text(
              'Pastikan anda sudah melakukan pembayaran sesuai metode yang dipilih agar pesanan dapat diproses',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 14,
                color: Colors.black87,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),
            
            // Buttons
            Row(
              children: [
                // Batal Button
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[100],
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Batal',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.green[700],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                
                // Konfirmasi Button
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF007B29),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () {
                      Navigator.pop(context); // Tutup dialog
                      // Langsung navigasi ke MyOrderPage tanpa named route
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyOrderPage(
                            product: product,
                            quantity: quantity,
                            totalPrice: totalPrice,
                            selectedShipping: selectedShipping,
                            selectedPayment: selectedPayment,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'Konfirmasi',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}