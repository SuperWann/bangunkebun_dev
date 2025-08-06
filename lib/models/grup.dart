class Grup {
  final int? idGroup;
  final String? namaGroup;
  final String? deskripsiGrup;
  final String? fotoGrup;
  final DateTime? timestamp;

  Grup({
    this.idGroup,
    this.namaGroup,
    this.deskripsiGrup,
    this.fotoGrup,
    this.timestamp,
  });

  factory Grup.fromJson(Map<String, dynamic> json) => Grup(idGroup: json['id']);

  Map<String, dynamic> toStore() => {
    'foto_grup': fotoGrup,
    'nama_grup': deskripsiGrup,
    'deksripsi': deskripsiGrup,
  };
}
