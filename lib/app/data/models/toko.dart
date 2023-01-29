class TokoModels {
  TokoModels({
    this.uid,
    this.nama,
    this.email,
    this.photoUrl,
    this.logoUrl,
    this.createdAt,
    this.updatedAt,
    this.produk,
  });

  String? uid;
  String? nama;
  String? email;
  String? photoUrl;
  String? logoUrl;
  String? createdAt;
  String? updatedAt;
  List<Produk>? produk;

  factory TokoModels.fromJson(Map<String, dynamic> json) => TokoModels(
        uid: json["uid"],
        nama: json["nama"],
        email: json["email"],
        photoUrl: json["photoUrl"],
        logoUrl: json["logoUrl"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "nama": nama,
        "email": email,
        "photoUrl": photoUrl,
        "logoUrl": logoUrl,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}

class Produk {
  Produk({
    this.idProduk,
    this.createdAt,
  });

  String? idProduk;
  String? createdAt;

  factory Produk.fromJson(Map<String, dynamic> json) => Produk(
        idProduk: json["id_produk"],
        createdAt: json["createdAt"],
      );

  Map<String, dynamic> toJson() => {
        "id_produk": idProduk,
        "createdAt": createdAt,
      };
}
