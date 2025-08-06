class Pengguna {
  final int? iduser;
  final String? namaLengkap;
  final String? username;
  final String? noTelepon;
  final String? email;
  final String? password;
  final int? idKecamatan;

  Pengguna({
    this.iduser,
    this.username,
    this.password,
    this.email,
    this.noTelepon,
    this.namaLengkap,
    this.idKecamatan,
  });

  factory Pengguna.fromJson(Map<String, dynamic> json) {
    return Pengguna(
      iduser: json['id_user'],
      username: json['username'],
      password: json['password'],
      email: json['email'],
      noTelepon: json['no_telepon'],
      namaLengkap: json['nama_lengkap'],
      idKecamatan: json['id_kecamatan'],
    );
  }

  Map<String, dynamic> toStore() => {
    'id_user': iduser,
    'username': username,
    'password': password,
    'email': email,
    'no_telepon': noTelepon,
    'nama_lengkap': namaLengkap,
    'id_kecamatan': idKecamatan,
  };
}
