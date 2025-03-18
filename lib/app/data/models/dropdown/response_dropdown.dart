class ResponseDropdown {
  bool? success;
  String? message;
  List<DataDropdown>? data;
  dynamic errors;

  ResponseDropdown({this.success, this.message, this.data, this.errors});
  List<Map<String, String>> convertDropdown() {
    return data!
        .map((item) => {
              'id': item.id.toString(),
              'name': item.nama.toString(),
            })
        .toList();
  }

  ResponseDropdown.fromJson(Map<String, dynamic> json) {
    if (json["success"] is bool) {
      success = json["success"];
    }
    if (json["message"] is String) {
      message = json["message"];
    }
    if (json["data"] is List) {
      data = json["data"] == null
          ? null
          : (json["data"] as List)
              .map((e) => DataDropdown.fromJson(e))
              .toList();
    }
    errors = json["errors"];
  }

  static List<ResponseDropdown> fromList(List<Map<String, dynamic>> list) {
    return list.map(ResponseDropdown.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["success"] = success;
    _data["message"] = message;
    if (data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    _data["errors"] = errors;
    return _data;
  }

  ResponseDropdown copyWith({
    bool? success,
    String? message,
    List<DataDropdown>? data,
    dynamic errors,
  }) =>
      ResponseDropdown(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
        errors: errors ?? this.errors,
      );
}

class DataDropdown {
  int? id;
  String? nama;

  DataDropdown({this.id, this.nama});

  DataDropdown.fromJson(Map<String, dynamic> json) {
    if (json["id"] is num) {
      id = (json["id"] as num).toInt();
    }
    if (json["nama"] is String) {
      nama = json["nama"];
    }
  }

  static List<DataDropdown> fromList(List<Map<String, dynamic>> list) {
    return list.map(DataDropdown.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["nama"] = nama;
    return _data;
  }

  DataDropdown copyWith({
    int? id,
    String? nama,
  }) =>
      DataDropdown(
        id: id ?? this.id,
        nama: nama ?? this.nama,
      );
}
