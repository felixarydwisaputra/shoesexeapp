class ProdukData {
  ProdukData({
    this.idProduk,
    this.namaProduk,
    this.photoUrl,
    this.emailToko,
    this.warna,
    this.bahan,
    this.stok,
    this.berat,
    this.harga,
    this.deskripsi,
  });

  String? idProduk;
  String? namaProduk;
  String? photoUrl;
  String? emailToko;
  String? warna;
  String? bahan;
  int? stok;
  int? berat;
  int? harga;
  String? deskripsi;

  factory ProdukData.fromJson(Map<String, dynamic> json) => ProdukData(
        idProduk: json["id_produk"],
        namaProduk: json["nama_produk"],
        photoUrl: json["photoUrl"],
        emailToko: json["emailToko"],
        warna: json["warna"],
        bahan: json["bahan"],
        stok: json["stok"],
        berat: json["berat"],
        harga: json["harga"],
        deskripsi: json["deskripsi"],
      );

  Map<String, dynamic> toJson() => {
        "id_produk": idProduk,
        "nama_produk": namaProduk,
        "photoUrl": photoUrl,
        "emailToko": emailToko,
        "warna": warna,
        "bahan": bahan,
        "stok": stok,
        "berat": berat,
        "harga": harga,
        "deskripsi": deskripsi,
      };
}
