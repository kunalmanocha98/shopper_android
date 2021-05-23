class LoginRequest {
  String email;
  String password;

  LoginRequest({this.email, this.password});

  LoginRequest.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}

class LoginResponse {
  String message;
  String code;
  Results results;
  int total;

  LoginResponse({this.message, this.code, this.results, this.total});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    code = json['code'];
    results =
    json['results'] != null ? new Results.fromJson(json['results']) : null;
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['code'] = this.code;
    if (this.results != null) {
      data['results'] = this.results.toJson();
    }
    data['total'] = this.total;
    return data;
  }
}

class Results {
  User user;
  String token;

  Results({this.user, this.token});

  Results.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class User {
  String sId;
  String name;
  String email;
  String mobile;
  String password;
  String familyId;

  User(
      {this.sId,
        this.name,
        this.email,
        this.mobile,
        this.password,
        this.familyId});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    password = json['password'];
    familyId = json['family_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['password'] = this.password;
    data['family_id'] = this.familyId;
    return data;
  }
}