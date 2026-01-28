class ExperienceDataModel {
  final String id;
  final String name;
  final String shortDescription;

  ExperienceDataModel({required this.id, required this.name, required this.shortDescription});
  factory ExperienceDataModel.fromJson(Map<String, dynamic> json) {
    return ExperienceDataModel(
      id: json['id'],
      name: json['name'],
      shortDescription: json['shortDescription'],
    );
  }
}
