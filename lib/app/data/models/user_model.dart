class UserModels {
  String? uid;
  String? nama;
  String? phone;
  String? photoUrl;
  String? status;
  String? email;
  String? createdAt;
  String? lastSignIn;
  String? updateAt;
  Alamat? alamat;

  UserModels(
      {this.uid,
      this.nama,
      this.phone,
      this.photoUrl,
      this.status,
      this.email,
      this.createdAt,
      this.lastSignIn,
      this.updateAt,
      this.alamat});

  UserModels.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    nama = json['nama'];
    phone = json['phone'];
    photoUrl = json['photoUrl'];
    status = json['status'];
    email = json['email'];
    createdAt = json['createdAt'];
    lastSignIn = json['lastSignIn'];
    updateAt = json['updateAt'];
    alamat = json['alamat'] != null ? Alamat?.fromJson(json['alamat']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['uid'] = uid;
    data['nama'] = nama;
    data['phone'] = phone;
    data['photoUrl'] = photoUrl;
    data['status'] = status;
    data['email'] = email;
    data['createdAt'] = createdAt;
    data['lastSignIn'] = lastSignIn;
    data['updateAt'] = updateAt;
    if (alamat != null) {
      data['alamat'] = alamat?.toJson();
    }
    return data;
  }
}

class Alamat {
  String? idPorv;
  String? prov;
  String? idKota;
  String? kota;
  String? address;

  Alamat({this.idPorv, this.prov, this.idKota, this.kota, this.address});

  Alamat.fromJson(Map<String, dynamic> json) {
    idPorv = json['idPorv'];
    prov = json['prov'];
    idKota = json['idKota'];
    kota = json['kota'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['idPorv'] = idPorv;
    data['prov'] = prov;
    data['idKota'] = idKota;
    data['kota'] = kota;
    data['address'] = address;
    return data;
  }
}
