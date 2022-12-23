class User {
  /*
  tipe
  1 -> pemasukan
  2 -> pengeluaran
  */
  int? id, type, nim;
  String? name, alamat, createdAt, updatedAt;

  User(
      {this.id,
      this.type,
      this.nim,
      this.name,
      this.alamat,
      this.createdAt,
      this.updatedAt});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        type: json['type'],
        nim: json['nim'],
        name: json['name'],
        alamat: json['alamat'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at']);
  }
}