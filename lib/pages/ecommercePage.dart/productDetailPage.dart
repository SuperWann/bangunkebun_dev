import 'package:bangunkebun_dev/models/ecommerce.dart';
import 'package:bangunkebun_dev/pages/ecommercePage.dart/orderSummaryPage.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int _quantity = 1;
  int _currentImageIndex = 0;
  String _durabilityStatus = 'Tidak cepat basi';
  final List<String> _imageAssets = [];

  @override
  void initState() {
    super.initState();
    _imageAssets.add(widget.product.imageAsset);
    _imageAssets.addAll([
      'assets/images/pakchoy.png',
      'assets/images/cabai.png',
    ]);
    _setDurabilityStatus();
  }

  void _setDurabilityStatus() {
    if (widget.product.name.contains('Bibit') ||
        widget.product.name.contains('Benih')) {
      _durabilityStatus = 'Tidak cepat basi';
    } else if (widget.product.name.contains('Tomat') ||
        widget.product.name.contains('Timun')) {
      _durabilityStatus = 'Cepat basi';
    } else if (widget.product.name.contains('Pakchoy')) {
      _durabilityStatus = 'Pecah belah';
    }
  }

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    setState(() {
      if (_quantity > 1) _quantity--;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark, // Ikon status bar gelap
      systemStatusBarContrastEnforced: false,
    ));

    final int basePrice = int.parse(
      widget.product.price.replaceAll(RegExp(r'[^\d]'), ''),
    );
    final int totalPrice = basePrice * _quantity;
    final String location = widget.product.description.replaceAll(
      'Lokasi: ',
      '',
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20.0),
              child: Stack(
                children: [
                  SizedBox(
                    height: 320,
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: 400,
                        viewportFraction: 0.8,
                        enlargeCenterPage: true,
                        autoPlay: _imageAssets.length > 1,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enableInfiniteScroll: _imageAssets.length > 1,
                        autoPlayAnimationDuration: const Duration(
                          milliseconds: 800,
                        ),
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentImageIndex = index;
                          });
                        },
                      ),
                      items: _imageAssets.map((imagePath) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 5.0,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: const BorderRadius.vertical(
                                  bottom: Radius.circular(12),
                                ),
                              ),
                              child: Image.asset(
                                imagePath,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                alignment: Alignment.topCenter,
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  Positioned(
                    top: 15,
                    left: 16,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 20,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                  if (_imageAssets.length > 1)
                    Positioned(
                      bottom: 16,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _imageAssets.asMap().entries.map((entry) {
                          final isActive = _currentImageIndex == entry.key;
                          return Container(
                            width: 8.0,
                            height: 8.0,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 4.0,
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isActive
                                  ? const Color(0xFF007B29)
                                  : Colors.white.withOpacity(0.5),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name,
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Rp. ${widget.product.price.replaceAll(RegExp(r'[^\d]'), '')}',
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF007B29),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        location,
                        style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                      Text(
                        'Stok: 15',
                        style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 14,
                          color: Color(0xFF007B29),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Deskripsi',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Jenis Produk: ${widget.product.name.contains('Bibit') || widget.product.name.contains('Benih') ? 'Bibit & Benih' : 'Olahan Kebun'}\n'
                    'Ketahanan: $_durabilityStatus\n\n'
                    'BENIH TOMAT BARETO 150S (Bentuk buah bulat berlekuk)\n'
                    '• PANEN: Umur 85-90 Hari Setelah Tanam\n'
                    '• BOBOT PER BUAH: 120-140/g\n'
                    '• DAYA SIMPAN: 7 – 9 hari\n'
                    'Netto : Isi 150 benih',
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Kuantitas',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.remove,
                              color: Color(0xFF007B29),
                            ),
                            onPressed: _decrementQuantity,
                          ),
                          Text(
                            '$_quantity',
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.add,
                              color: Color(0xFF007B29),
                            ),
                            onPressed: _incrementQuantity,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Total Harga',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF878787),
                            ),
                          ),
                          Text(
                            'Rp. $totalPrice',
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF007B29),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 180,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF007B29),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OrderSummaryPage(
                                  product: widget.product,
                                  quantity: _quantity,
                                  totalPrice: totalPrice,
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            'Beli Sekarang',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}