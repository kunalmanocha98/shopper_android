class ChangeStatusRequest {
  String taskId;
  String status;

  ChangeStatusRequest({this.taskId, this.status});

  ChangeStatusRequest.fromJson(Map<String, dynamic> json) {
    taskId = json['task_id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['task_id'] = this.taskId;
    data['status'] = this.status;
    return data;
  }
}

class ChangeStatusResponse {
  String message;
  String code;

  ChangeStatusResponse({this.message, this.code});

  ChangeStatusResponse.fromJson(Map<String, dynamic> json) {
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