class ProjectModel {
  final String id;
  final String name;

  ProjectModel({required this.id, required this.name});

  factory ProjectModel.fromMap(Map<String, dynamic> map) {
    return ProjectModel(
      id: map['id'].toString(),
      name: map['name'] as String,
    );
  }
}
