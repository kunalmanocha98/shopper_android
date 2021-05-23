class FamilyListRequest {
  int pageSize;
  int page;
  String searchVal;

  FamilyListRequest({this.pageSize, this.page, this.searchVal});

  FamilyListRequest.fromJson(Map<String, dynamic> json) {
    pageSize = json['page_size'];
    page = json['page'];
    searchVal = json['search_val'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page_size'] = this.pageSize;
    data['page'] = this.page;
    data['search_val'] = this.searchVal;
    return data;
  }
}

class FamilyListResponse {
  String message;
  String code;
  List<FamilyListItem> results;
  int total;

  FamilyListResponse({this.message, this.code, this.results, this.total});

  FamilyListResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    code = json['code'];
    if (json['results'] != null) {
      results = <FamilyListItem>[];
      json['results'].forEach((v) {
        results.add(new FamilyListItem.fromJson(v));
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

class FamilyListItem {
  String sId;
  String familyUserName;
  String familyName;
  int iV;

  FamilyListItem({this.sId, this.familyUserName, this.familyName, this.iV});

  FamilyListItem.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    familyUserName = json['family_user_name'];
    familyName = json['family_name'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['family_user_name'] = this.familyUserName;
    data['family_name'] = this.familyName;
    data['__v'] = this.iV;
    return data;
  }
}

class FamilyCreateRequest {
  String familyName;
  String familyUserName;

  FamilyCreateRequest({this.familyName, this.familyUserName});

  FamilyCreateRequest.fromJson(Map<String, dynamic> json) {
    familyName = json['family_name'];
    familyUserName = json['family_user_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['family_name'] = this.familyName;
    data['family_user_name'] = this.familyUserName;
    return data;
  }
}

class FamilyCreateResponse {
  String message;
  String code;
  int total;

  FamilyCreateResponse({this.message, this.code, this.total});

  FamilyCreateResponse.fromJson(Map<String, dynamic> json) {
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