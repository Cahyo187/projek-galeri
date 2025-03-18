class ResponseFoto<T> {
  bool? status;
  T? data;
  String? message;

  ResponseFoto({this.status, this.data, this.message});

  ResponseFoto.fromJson(Map<String, dynamic> json) {
    if (json["status"] is bool) {
      status = json["status"];
    }
    if (json["data"] is List) {
      data =
          (json["data"] as List).map((e) => DataFoto.fromJson(e)).toList() as T;
    } else if (json["data"] is Map) {
      data = DataFoto.fromJson(json["data"]) as T;
    }
    if (json["message"] is String) {
      message = json["message"];
    }
  }

  static List<ResponseFoto> fromList(List<Map<String, dynamic>> list) {
    return list.map(ResponseFoto.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    if (data is List) {
      _data["data"] = (data as List).map((e) => e.toJson()).toList();
    } else if (data is DataFoto) {
      _data["data"] = (data as DataFoto).toJson();
    }
    _data["message"] = message;
    return _data;
  }
}

class DataFoto {
  int? id;
  int? userId;
  int? albumId;
  String? lokasiFoto;
  dynamic judulFoto;
  String? deskripsiFoto;
  String? tanggalUnggah;
  bool? like;
  bool? author;
  int? likeCount;
  int? komentarCount;
  User? user;
  Album? album;

  DataFoto(
      {this.id,
      this.userId,
      this.albumId,
      this.lokasiFoto,
      this.judulFoto,
      this.deskripsiFoto,
      this.tanggalUnggah,
      this.like,
      this.author,
      this.likeCount,
      this.komentarCount,
      this.user,
      this.album});

  DataFoto.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["user_id"] is int) {
      userId = json["user_id"];
    }
    if (json["album_id"] is int) {
      albumId = json["album_id"];
    }
    if (json["lokasi_foto"] is String) {
      lokasiFoto = json["lokasi_foto"];
    }
    judulFoto = json["judul_foto"];
    if (json["deskripsi_foto"] is String) {
      deskripsiFoto = json["deskripsi_foto"];
    }
    if (json["tanggal_unggah"] is String) {
      tanggalUnggah = json["tanggal_unggah"];
    }
    if (json["like"] is bool) {
      like = json["like"];
    }
    if (json["author"] is bool) {
      author = json["author"];
    }
    if (json["like_count"] is int) {
      likeCount = json["like_count"];
    }
    if (json["komentar_count"] is int) {
      komentarCount = json["komentar_count"];
    }
    if (json["user"] is Map) {
      user = json["user"] == null ? null : User.fromJson(json["user"]);
    }
    if (json["album"] is Map) {
      album = json["album"] == null ? null : Album.fromJson(json["album"]);
    }
  }

  static List<DataFoto> fromList(List<Map<String, dynamic>> list) {
    return list.map(DataFoto.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["user_id"] = userId;
    _data["album_id"] = albumId;
    _data["lokasi_foto"] = lokasiFoto;
    _data["judul_foto"] = judulFoto;
    _data["deskripsi_foto"] = deskripsiFoto;
    _data["tanggal_unggah"] = tanggalUnggah;
    _data["like"] = like;
    _data["author"] = author;
    _data["like_count"] = likeCount;
    _data["komentar_count"] = komentarCount;
    if (user != null) {
      _data["user"] = user?.toJson();
    }
    if (album != null) {
      _data["album"] = album?.toJson();
    }
    return _data;
  }
}

class Album {
  int? id;
  int? userId;
  String? namaAlbum;
  String? deskripsiAlbum;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  Album(
      {this.id,
      this.userId,
      this.namaAlbum,
      this.deskripsiAlbum,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Album.fromJson(Map<String, dynamic> json) {
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
  }

  static List<Album> fromList(List<Map<String, dynamic>> list) {
    return list.map(Album.fromJson).toList();
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
    return _data;
  }
}

class User {
  int? id;
  String? namaLengkap;
  String? username;
  String? email;
  String? emailVerifiedAt;
  dynamic otp;
  dynamic otpExpired;
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
    otp = json["otp"];
    otpExpired = json["otp_expired"];
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
