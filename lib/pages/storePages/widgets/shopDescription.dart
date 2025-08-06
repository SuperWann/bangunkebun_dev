import 'package:flutter/material.dart';

class ShopDescriptionWidget extends StatelessWidget {
  const ShopDescriptionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: const TextSpan(
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 16,
              color: Colors.black87,
            ),
            children: [
              TextSpan(
                text: 'Jual dan Kelola Segala ',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              TextSpan(
                text: 'Kebutuhan Kebunmu!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E7D32),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Mulai dari bibit, hasil panen, olahan, alat, pupuk, hingga paket kebun semua bisa kamu kelola di sini.',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 14,
            color: Colors.grey[600],
            height: 1.4,
          ),
        ),
      ],
    );
  }
}