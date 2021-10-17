class CreateTaskRequest {
  String title;
  String subtitle;
  String familyId;
  String userId;
  String assignTaskId;
  List<CheckList> checkList;

  CreateTaskRequest(
      {this.title,
        this.subtitle,
        this.familyId,
        this.userId,
        this.assignTaskId,
        this.checkList});

  CreateTaskRequest.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subtitle = json['subtitle'];
    familyId = json['family_id'];
    userId = json['user_id'];
    assignTaskId = json['assign_task_id'];
    if (json['checkList'] != null) {
      checkList = [];
      json['checkList'].forEach((v) {
        checkList.add(new CheckList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    data['family_id'] = this.familyId;
    data['user_id'] = this.userId;
    data['assign_task_id'] = this.assignTaskId;
    if (this.checkList != null) {
      data['checkList'] = this.checkList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CheckList {
  String task;
  String description;

  CheckList({this.task, this.description});

  CheckList.fromJson(Map<String, dynamic> json) {
    task = json['task'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['task'] = this.task;
    data['description'] = this.description;
    return data;
  }
}


class CreateTaskResponse {
  String message;
  String code;

  CreateTaskResponse({this.message, this.code});

  CreateTaskResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['code'] = this.code;
    return data;
  }
}