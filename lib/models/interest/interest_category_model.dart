import 'package:aspira/models/interest/interest_model.dart';

class InterestCategoryModel {
  final String id;
  final String name;
  final List<InterestModel> interestList;

  InterestCategoryModel({
    required this.id,
    required this.name,
    required this.interestList,
  });

  factory InterestCategoryModel.fromJson(Map<String, dynamic> json) {
    return InterestCategoryModel(
      id: json['id'],
      name: json['name'],
      interestList: (json['interests'] as List)
          .map((e) => InterestModel.fromJson(e))
          .toList(),
    );
  }
}
