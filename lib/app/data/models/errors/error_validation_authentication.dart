/// status : false
/// message : "Email belum diverifikasi."
/// errors : {"email":["Email belum diverifikasi."]}

class ErrorValidationAuthentication {
  ErrorValidationAuthentication({
      this.status, 
      this.message, 
      this.errors,});

  ErrorValidationAuthentication.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    errors = json['errors'] != null ? Errors.fromJson(json['errors']) : null;
  }
  bool? status;
  String? message;
  Errors? errors;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (errors != null) {
      map['errors'] = errors?.toJson();
    }
    return map;
  }

}

/// email : ["Email belum diverifikasi."]

class Errors {
  Errors({
      this.email,});

  Errors.fromJson(dynamic json) {
    email = json['email'] != null ? json['email'].cast<String>() : [];
  }
  List<String>? email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    return map;
  }

}