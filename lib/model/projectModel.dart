class ProjectModel {
  final dynamic id;
  final dynamic name;
  final dynamic inithr;
  final dynamic currenthr;
  final dynamic createTime;

  ProjectModel(this.name, this.inithr, this.currenthr, this.id, this.createTime);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'inithr': inithr,
      'currenthr': currenthr,
      'createTime': createTime
    };
  }

  static ProjectModel fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      json['id'],
      json['name'],
      json['inithr'],
      json['currenthr'],
      json['createTime']
    );
  }
}
