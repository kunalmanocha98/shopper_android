class SignUpRequest {
  String name;
  String email;
  String mobile;
  String password;
  String familyId;

  SignUpRequest(
      {this.name,
        this.email,
        this.mobile,
        this.password,
        this.familyId});

  SignUpRequest.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    password = json['password'];
    familyId = json['family_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['password'] = this.password;
    data['family_id'] = this.familyId;
    return data;
  }
}

class SignUpResponse {
  String message;
  String code;
  int total;

  SignUpResponse({this.message, this.code, this.total});

  SignUpResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    code = json['code'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['code'] = this.code;
    data['total'] = this.total;
    return data;
  }
}

