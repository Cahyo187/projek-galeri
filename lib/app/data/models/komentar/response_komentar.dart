class ResponseKomentar<T> {
  bool? status;
  T? data;
  String? message;

  ResponseKomentar({this.status, this.data, this.message});

  ResponseKomentar.fromJson(Map<String, dynamic> json) {
    if (json["status"] is bool) {
      status = json["status"];
    }
    if (json["data"] is List) {
      data = (json["data"] as List)
          .map((e) => DataKomentar.fromJson(e))
          .toList() as T;
    } else if (json["data"] is Map) {
      data = DataKomentar.fromJson(json["data"]) as T;
    }
    if (json["message"] is String) {
      message = json["message"];
    }
  }

  static List<ResponseKomentar> fromList(List<Map<String, dynamic>> list) {
    return list.map(ResponseKomentar.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    if (data is List) {
      _data["data"] = (data as List).map((e) => e.toJson()).toList();
    } else if (data is DataKomentar) {
      _data["data"] = (data as DataKomentar).toJson();
    }
    _data["message"] = message;
    return _data;
  }
}

class DataKomentar {
  int? id;
  int? userId;
  int? fotoId;
  bool? author;
  String? komentar;
  dynamic deletedAt;
  String? createdAt;
  String? updatedAt;
  User? user;

  DataKomentar(
      {this.id,
      this.userId,
      this.fotoId,
      this.author,
      this.komentar,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.user});

  DataKomentar.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["user_id"] is int) {
      userId = json["user_id"];
    }
    if (json["foto_id"] is int) {
      fotoId = json["foto_id"];
    }
    if (json["komentar"] is String) {
      komentar = json["komentar"];
    }
    if (json["author"] is bool) {
      author = json["author"];
    }
    deletedAt = json["deleted_at"];
    if (json["created_at"] is String) {
      createdAt = json["created_at"];
    }
    if (json["updated_at"] is String) {
      updatedAt = json["updated_at"];
    }
    if (json["user"] is Map) {
      user = json["user"] == null ? null : User.fromJson(json["user"]);
    }
  }

  static List<DataKomentar> fromList(List<Map<String, dynamic>> list) {
    return list.map(DataKomentar.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["user_id"] = userId;
    _data["foto_id"] = fotoId;
    _data["author"] = author;
    _data["komentar"] = komentar;
    _data["deleted_at"] = deletedAt;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
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
  dynamic emailVerifiedAt;
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
    emailVerifiedAt = json["email_verified_at"];
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
