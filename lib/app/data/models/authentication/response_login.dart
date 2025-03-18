/// status : true
/// message : "Login berhasil"
/// data : {"id":1,"email":"arjunadeland1@gmail.com","username":"delandaja","nama_lengkap":"Muhammad Deland Arjuna Putra","alamat":null,"token":"3|hEttBFcTtsvWPooMbF3rbUjmyH4WwfKkiT1n3L6Tc3f8e780"}

class ResponseLogin {
  ResponseLogin({
      this.status, 
      this.message, 
      this.data,});

  ResponseLogin.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? status;
  String? message;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// id : 1
/// email : "arjunadeland1@gmail.com"
/// username : "delandaja"
/// nama_lengkap : "Muhammad Deland Arjuna Putra"
/// alamat : null
/// token : "3|hEttBFcTtsvWPooMbF3rbUjmyH4WwfKkiT1n3L6Tc3f8e780"

class Data {
  Data({
      this.id, 
      this.email, 
      this.username, 
      this.namaLengkap, 
      this.alamat, 
      this.token,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    email = json['email'];
    username = json['username'];
    namaLengkap = json['nama_lengkap'];
    alamat = json['alamat'];
    token = json['token'];
  }
  int? id;
  String? email;
  String? username;
  String? namaLengkap;
  dynamic alamat;
  String? token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['email'] = email;
    map['username'] = username;
    map['nama_lengkap'] = namaLengkap;
    map['alamat'] = alamat;
    map['token'] = token;
    return map;
  }

}