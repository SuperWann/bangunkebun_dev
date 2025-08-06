class ModelPercakapan {
  final int? idPercakapan;
  final String senderType;
  final String pesan;
  final DateTime? timestamp;

  ModelPercakapan({
    this.idPercakapan,
    required this.senderType,
    required this.pesan,
    this.timestamp,
  });

  // Factory constructor untuk mengkonversi Map dari database menjadi objek Percakapan
  factory ModelPercakapan.fromMap(Map<String, dynamic> map) {
    return ModelPercakapan(
      idPercakapan: map['id_percakapan'],
      senderType: map['sender_type'],
      pesan: map['pesan'],
      timestamp: DateTime.parse(
        map['timestamp'],
      ), 
    );
  }

  // Method untuk mengkonversi objek Percakapan menjadi Map untuk database
  Map<String, dynamic> toMap() {
    return {'sender_type': senderType, 'pesan': pesan};
  }
}
