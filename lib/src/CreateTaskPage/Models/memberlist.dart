class FamilyMembersListResponse {
  String message;
  String code;
  List<FamilyMemberItem> results;
  int total;

  FamilyMembersListResponse(
      {this.message, this.code, this.results, this.total});

  FamilyMembersListResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    code = json['code'];
    if (json['results'] != null) {
      results =  [];
      json['results'].forEach((v) {
        results.add(new FamilyMemberItem.fromJson(v));
      });
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['code'] = this.code;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    return data;
  }
}

class FamilyMemberItem {
  String sId;
  String name;
  String email;
  String mobile;
  String password;
  String familyId;
  int iV;

  FamilyMemberItem(
      {this.sId,
        this.name,
        this.email,
        this.mobile,
        this.password,
        this.familyId,
        this.iV});

  FamilyMemberItem.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    password = json['password'];
    familyId = json['family_id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['password'] = this.password;
    data['family_id'] = this.familyId;
    data['__v'] = this.iV;
    return data;
  }
}