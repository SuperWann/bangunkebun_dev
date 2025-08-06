class Product {
  final int? id_user;
  final int? id_produk;
  final String? namaProduk;
  final String? gambarProduk;
  final double? harga;
  final int? stok;
  final String? isiDeskripsi;
  final DateTime? timestamp;
  final int? idJenisProduk;
  final int? idStatusKetahanan;

  Product({
    this.id_user,
    this.id_produk,
    this.namaProduk,
    this.gambarProduk,
    this.harga,
    this.stok,
    this.isiDeskripsi,
    this.timestamp,
    this.idJenisProduk,
    this.idStatusKetahanan,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id_user: json['id_user'],
    id_produk: json['id_produk'],
    namaProduk: json['nama_produk'],
    gambarProduk: json['gambar_produk'],
    harga: json['harga'],
    stok: json['stok'],
    isiDeskripsi: json['deskripsi'],
    timestamp: DateTime.parse(json['timestamp']),
    idJenisProduk: json['id_jenis_produk'],
    idStatusKetahanan: json['id_status_ketahanan']
  );

  Map<String, dynamic> toStore() => {
    'nama_produk': namaProduk,
    'gambar_produk': gambarProduk,
    'harga': harga,
    'stok':stok,
    'deskripsi': isiDeskripsi,
    'id_jenis_produk':idJenisProduk,
    'id_status_ketahanan' :idStatusKetahanan
  };
}
