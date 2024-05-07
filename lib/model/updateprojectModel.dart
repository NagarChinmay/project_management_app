class UpdateProjectModel {
  final dynamic id;
  final dynamic name;
  final dynamic inithr;
  final dynamic createTime;
  final dynamic updateTime;

  UpdateProjectModel(
      this.id, this.name, this.inithr, this.createTime, this.updateTime);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'inithr': inithr,
      'createTime': createTime,
      'updateTime': updateTime
    };
  }

  static UpdateProjectModel fromJson(Map<String, dynamic> json) {
    return UpdateProjectModel(json['id'], json['name'], json['inithr'],
        json['createTime'], json['updateTime']);
  }
}
