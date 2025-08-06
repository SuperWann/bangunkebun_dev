class Konten {
  final int? idKonten;
  final String? judul;
  final String? gambarVideo;
  final String? isiDeskripsi;
  final int? idJenisKonten;
  final int? like;
  final int? idPengguna;
  final DateTime? timestamp;

  Konten({
    this.idKonten,
    this.judul,
    this.gambarVideo,
    this.isiDeskripsi,
    this.idJenisKonten,
    this.like,
    this.idPengguna,
    this.timestamp,
  });

  factory Konten.fromJson(Map<String, dynamic> json) => Konten(
    idKonten: json['id_content'],
    judul: json['judul'],
    gambarVideo: json['gambar_video'],
    isiDeskripsi: json['isi_deskripsi'],
    idJenisKonten: json['id_jenis_konten'],
    like: json['like'],
    idPengguna: json['id_user'],
    timestamp: DateTime.parse(json['timestamp']),
  );

  Map<String, dynamic> toStore() => {
    'judul': judul,
    'gambar_video': gambarVideo,
    'isi_deskripsi': isiDeskripsi,
    'id_jenis_konten': idJenisKonten,
    'id_user': idPengguna,
  };
}
