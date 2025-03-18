class ResponseAlbum<T> {
  bool? status;
  T? data;
  String? message;

  ResponseAlbum({this.status, this.data, this.message});

  ResponseAlbum.fromJson(Map<String, dynamic> json) {
    if (json["status"] is bool) {
      status = json["status"];
    }
    if (json["data"] is List) {
      data = (json["data"] as List).map((e) => DataAlbum.fromJson(e)).toList()
          as T;
    } else if (json["data"] is Map) {
      data = DataAlbum.fromJson(json["data"]) as T;
    }
    if (json["message"] is String) {
      message = json["message"];
    }
  }

  static List<ResponseAlbum> fromList(List<Map<String, dynamic>> list) {
    return list.map(ResponseAlbum.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    if (data is List) {
      _data["data"] = (data as List).map((e) => e.toJson()).toList();
    } else if (data is DataAlbum) {
      _data["data"] = (data as DataAlbum).toJson();
    }
    _data["message"] = message;
    return _data;
  }
}

class DataAlbum {
  int? id;
  int? userId;
  String? namaAlbum;
  String? deskripsiAlbum;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  User? user;

  DataAlbum(
      {this.id,
      this.userId,
      this.namaAlbum,
      this.deskripsiAlbum,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.user});

  DataAlbum.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["user_id"] is int) {
      userId = json["user_id"];
    }
    if (json["nama_album"] is String) {
      namaAlbum = json["nama_album"];
    }
    if (json["deskripsi_album"] is String) {
      deskripsiAlbum = json["deskripsi_album"];
    }
    if (json["created_at"] is String) {
      createdAt = json["created_at"];
    }
    if (json["updated_at"] is String) {
      updatedAt = json["updated_at"];
    }
    deletedAt = json["deleted_at"];
    if (json["user"] is Map) {
      user = json["user"] == null ? null : User.fromJson(json["user"]);
    }
  }

  static List<DataAlbum> fromList(List<Map<String, dynamic>> list) {
    return list.map(DataAlbum.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["user_id"] = userId;
    _data["nama_album"] = namaAlbum;
    _data["deskripsi_album"] = deskripsiAlbum;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    _data["deleted_at"] = deletedAt;
    if (user != null) {
      _data["user"] = user?.toJson();
    }
    return _data;
  }
}

class User {
  int? id;
  String? namaLengkap;
  String? username;
  String? email;
  String? emailVerifiedAt;
  String? otp;
  String? otpExpired;
  dynamic alamat;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  User(
      {this.id,
      this.namaLengkap,
      this.username,
      this.email,
      this.emailVerifiedAt,
      this.otp,
      this.otpExpired,
      this.alamat,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  User.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["nama_lengkap"] is String) {
      namaLengkap = json["nama_lengkap"];
    }
    if (json["username"] is String) {
      username = json["username"];
    }
    if (json["email"] is String) {
      email = json["email"];
    }
    if (json["email_verified_at"] is String) {
      emailVerifiedAt = json["email_verified_at"];
    }
    if (json["otp"] is String) {
      otp = json["otp"];
    }
    if (json["otp_expired"] is String) {
      otpExpired = json["otp_expired"];
    }
    alamat = json["alamat"];
    if (json["created_at"] is String) {
      createdAt = json["created_at"];
    }
    if (json["updated_at"] is String) {
      updatedAt = json["updated_at"];
    }
    deletedAt = json["deleted_at"];
  }

  static List<User> fromList(List<Map<String, dynamic>> list) {
    return list.map(User.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["nama_lengkap"] = namaLengkap;
    _data["username"] = username;
    _data["email"] = email;
    _data["email_verified_at"] = emailVerifiedAt;
    _data["otp"] = otp;
    _data["otp_expired"] = otpExpired;
    _data["alamat"] = alamat;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    _data["deleted_at"] = deletedAt;
    return _data;
  }
}
