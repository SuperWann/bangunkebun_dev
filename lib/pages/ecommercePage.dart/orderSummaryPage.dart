import 'package:bangunkebun_dev/models/ecommerce.dart';
import 'package:bangunkebun_dev/pages/ecommercePage.dart/paymentPage.dart';
import 'package:flutter/material.dart';


class OrderSummaryPage extends StatefulWidget {
  final Product product;
  final int quantity;
  final int totalPrice;

  const OrderSummaryPage({
    super.key,
    required this.product,
    required this.quantity,
    required this.totalPrice,
  });

  @override
  State<OrderSummaryPage> createState() => _OrderSummaryPageState();
}

class _OrderSummaryPageState extends State<OrderSummaryPage> {
  String? _selectedPayment; // Mengubah menjadi nullable untuk tidak ada yang dipilih default
  String _selectedShipping = 'Standard (3-5 hari)';
  
  final Map<String, int> _shippingCosts = {
    'Standard (3-5 hari)': 10000,
    'Express (1-2 hari)': 15000,
  };

  final List<String> _shippingOptions = ['Standard (3-5 hari)', 'Express (1-2 hari)'];
  final List<Map<String, dynamic>> _paymentOptions = [
    {'name': 'Cash On Delivery (COD)', 'icon': Icons.local_shipping, 'color': Colors.green},
    {'name': 'Dana', 'icon': Icons.account_balance_wallet, 'color': Colors.blue, 'number': '082232896648'},
    {'name': 'Mandiri', 'icon': Icons.account_balance, 'color': Colors.orange, 'number': '8898918319732'},
  ];

  int get _currentShippingCost => _shippingCosts[_selectedShipping] ?? 0;
  int get _totalPayment => widget.totalPrice + _currentShippingCost;

  @override
  void initState() {
    super.initState();
    _selectedPayment = null; // Memastikan tidak ada yang dipilih saat halaman dimuat
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Rincian Pembelian',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Alamat Pengiriman Section
            Container(
              width: double.infinity,
              color: Colors.grey[50],
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Alamat Pengiriman',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Color(0xFF007B29),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.location_on,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Muhammad Fairuz Zaki',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'Perumahan Taman Gading, Tegal Besar, Kaliwates, Jember, Jawa Timur',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit, color: Color(0xFF007B29), size: 20),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Detail Pesanan Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Detail Pesanan',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            widget.product.imageAsset,
                            fit: BoxFit.cover,
                            width: 60,
                            height: 60,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[200],
                                child: const Icon(Icons.image, color: Colors.grey),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.product.name,
                              style: const TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Rp. ${widget.product.price.replaceAll(RegExp(r'[^\d]'), '')}',
                              style: const TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 14,
                                color: Color(0xFF007B29),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '${widget.quantity}',
                        style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Metode Pembayaran Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Metode Pembayaran',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ..._paymentOptions.map((option) {
                    bool isSelected = _selectedPayment == option['name'];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isSelected ? const Color(0xFF007B29) : Colors.grey[300]!,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: RadioListTile<String>(
                        value: option['name'],
                        groupValue: _selectedPayment,
                        onChanged: (value) {
                          setState(() {
                            _selectedPayment = value;
                          });
                        },
                        activeColor: const Color(0xFF007B29),
                        title: Row(
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: option['color'],
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Icon(
                                option['icon'],
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    option['name'],
                                    style: const TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  if (option['number'] != null)
                                    Text(
                                      option['number'],
                                      style: const TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        controlAffinity: ListTileControlAffinity.trailing,
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Pilihan Pengiriman
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Pilihan Pengiriman',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFF007B29)),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: DropdownButton<String>(
                      value: _selectedShipping,
                      icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF007B29)),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                      underline: Container(),
                      isExpanded: true,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedShipping = newValue!;
                        });
                      },
                      items: _shippingOptions.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Rincian Pembayaran Section
            Container(
              width: double.infinity,
              color: Colors.grey[50],
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Rincian Pembayaran',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Subtotal Pesanan',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Rp. ${widget.totalPrice}',
                        style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Ongkir',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Rp. $_currentShippingCost',
                        style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Divider(thickness: 1, color: Colors.grey),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total Pembayaran',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Rp. $_totalPayment',
                        style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF007B29),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Buat Pesanan Button
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF007B29),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 0,
                  ),
                  onPressed: (_selectedPayment != null)
                      ? () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Pesanan berhasil dibuat! Total: Rp. $_totalPayment',
                                style: const TextStyle(fontFamily: 'Montserrat'),
                              ),
                              backgroundColor: const Color(0xFF007B29),
                            ),
                          );
                          // Navigasi ke PaymentPage
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PaymentPage(
                                product: widget.product,
                                quantity: widget.quantity,
                                totalPrice: _totalPayment,
                                selectedShipping: _selectedShipping,
                                selectedPayment: _selectedPayment,
                              ),
                            ),
                          );
                        }
                      : null,
                  child: const Text(
                    'Buat Pesanan',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}