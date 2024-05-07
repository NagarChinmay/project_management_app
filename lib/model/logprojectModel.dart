class LogProjectModel {
  final dynamic id;
  final dynamic name;
  final dynamic inithr;
  final dynamic currenthr;
  final dynamic createTime;
  final dynamic updateTime;

  LogProjectModel(this.name, this.inithr, this.currenthr, this.id,
      this.createTime, this.updateTime);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'inithr': inithr,
      'currenthr': currenthr,
      'createTime': createTime,
      'updateTime': updateTime
    };
  }

  static LogProjectModel fromJson(Map<String, dynamic> json) {
    return LogProjectModel(json['id'], json['name'], json['inithr'],
        json['currenthr'], json['createTime'], json['updateTime']);
  }
}
