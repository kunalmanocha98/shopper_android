class CheckListUpdateRequest {
  String checklistId;
  bool isCompleted;
  String taskId;

  CheckListUpdateRequest({this.checklistId, this.isCompleted, this.taskId});

  CheckListUpdateRequest.fromJson(Map<String, dynamic> json) {
    checklistId = json['checklist_id'];
    isCompleted = json['isCompleted'];
    taskId = json['task_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['checklist_id'] = this.checklistId;
    data['isCompleted'] = this.isCompleted;
    data['task_id'] = this.taskId;
    return data;
  }
}


class CheckListUpdateResponse {
  String message;
  String code;
  Results results;

  CheckListUpdateResponse({this.message, this.code, this.results});

  CheckListUpdateResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    code = json['code'];
    results =
    json['results'] != null ? new Results.fromJson(json['results']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['code'] = this.code;
    if (this.results != null) {
      data['results'] = this.results.toJson();
    }
    return data;
  }
}

class Results {
  bool isCompleted;

  Results({this.isCompleted});

  Results.fromJson(Map<String, dynamic> json) {
    isCompleted = json['isCompleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isCompleted'] = this.isCompleted;
    return data;
  }
}