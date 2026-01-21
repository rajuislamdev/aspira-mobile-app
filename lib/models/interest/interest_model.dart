class InterestModel {
  final String id;
  final String name;
  final String categoryId;

  InterestModel({
    required this.id,
    required this.name,
    required this.categoryId,
  });

  factory InterestModel.fromJson(Map<String, dynamic> json) {
    return InterestModel(
      id: json['id'],
      name: json['name'],
      categoryId: json['categoryId'],
    );
  }
}
