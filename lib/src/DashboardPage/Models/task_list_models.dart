class TaskListRequest {
  int pageSize;
  int page;
  String familyId;

  TaskListRequest({this.pageSize, this.page, this.familyId});

  TaskListRequest.fromJson(Map<String, dynamic> json) {
    pageSize = json['page_size'];
    page = json['page'];
    familyId = json['family_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page_size'] = this.pageSize;
    data['page'] = this.page;
    data['family_id'] = this.familyId;
    return data;
  }
}

class TaskListResponse {
  String message;
  String code;
  List<TaskListItem> results;
  int total;

  TaskListResponse({this.message, this.code, this.results, this.total});

  TaskListResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    code = json['code'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results.add(new TaskListItem.fromJson(v));
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

class TaskListItem {
  List<CheckList> checkList;
  String sId;
  String title;
  String subtitle;
  int addedDate;
  int percentCompleted;
  String familyId;
  String userId;
  String assignTaskId;
  String status;
  int iV;
  bool isHidden;

  TaskListItem(
      {this.checkList,
        this.sId,
        this.title,
        this.subtitle,
        this.addedDate,
        this.percentCompleted,
        this.familyId,
        this.userId,
        this.assignTaskId,
        this.status,
        this.isHidden,
        this.iV});

  TaskListItem.fromJson(Map<String, dynamic> json) {
    if (json['checkList'] != null) {
      checkList =  [];
      json['checkList'].forEach((v) {
        checkList.add(new CheckList.fromJson(v));
      });
    }
    sId = json['_id'];
    title = json['title'];
    subtitle = json['subtitle'];
    addedDate = json['addedDate'];
    percentCompleted = json['percentCompleted'];
    familyId = json['familyId'];
    userId = json['userId'];
    assignTaskId = json['assignTaskId'];
    status = json['status'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.checkList != null) {
      data['checkList'] = this.checkList.map((v) => v.toJson()).toList();
    }
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    data['addedDate'] = this.addedDate;
    data['percentCompleted'] = this.percentCompleted;
    data['familyId'] = this.familyId;
    data['userId'] = this.userId;
    data['assignTaskId'] = this.assignTaskId;
    data['status'] = this.status;
    data['__v'] = this.iV;
    return data;
  }
}

class CheckList {
  bool isCompleted;
  String sId;
  String taskId;
  String task;
  String description;
  int iV;

  CheckList(
      {this.isCompleted,
        this.sId,
        this.taskId,
        this.task,
        this.description,
        this.iV});

  CheckList.fromJson(Map<String, dynamic> json) {
    isCompleted = json['isCompleted'];
    sId = json['_id'];
    taskId = json['taskId'];
    task = json['task'];
    description = json['description'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isCompleted'] = this.isCompleted;
    data['_id'] = this.sId;
    data['taskId'] = this.taskId;
    data['task'] = this.task;
    data['description'] = this.description;
    data['__v'] = this.iV;
    return data;
  }
}