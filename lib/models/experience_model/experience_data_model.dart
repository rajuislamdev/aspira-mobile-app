class ExperienceDataModel {
  final int id;
  final String label;

  ExperienceDataModel({required this.id, required this.label});
  factory ExperienceDataModel.fromJson(Map<String, dynamic> json) {
    return ExperienceDataModel(id: json['id'], label: json['label']);
  }
}
