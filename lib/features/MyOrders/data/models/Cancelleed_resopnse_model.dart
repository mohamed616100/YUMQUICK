class CanceldResopnse {
  String? message;
  bool? status;

  CanceldResopnse({this.message, this.status});

  CanceldResopnse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}
