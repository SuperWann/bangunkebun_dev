class KontenPengguna {
  final int? iduser;
  final String? namaLengkap;
  final String? username;
  final String? email;
  final int? idKonten;
  final String? judul;
  final String? gambarVideo;
  final String? isiDeskripsi;
  final int? idJenisKonten;
  final int? like;
  final DateTime? timestamp;
  final String? fotoProfile;

  KontenPengguna({
    this.idKonten,
    this.judul,
    this.idJenisKonten,
    this.gambarVideo,
    this.isiDeskripsi,
    this.iduser,
    this.timestamp,
    this.like,
    this.email,
    this.namaLengkap,
    this.username,
    this.fotoProfile,
  });

  factory KontenPengguna.fromJson(Map<String, dynamic> json) {
    return KontenPengguna(
      idKonten: json['id_konten'],
      judul: json['judul'],
      gambarVideo: json['gambar_video'],
      isiDeskripsi: json['isi_deskripsi'],
      idJenisKonten: json['id_jenis_konten'],
      like: json['like'],
      timestamp: DateTime.parse(json['timestamp']),
      iduser: json['id_user'],
      username: json['username'],
      email: json['email'],
      namaLengkap: json['nama_lengkap'],
      fotoProfile: json['foto_profile'],
    );
  }
}
