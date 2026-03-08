import 'package:equatable/equatable.dart';

class InterestEntity extends Equatable {
  final String? id;
  final String? name;
  final String? categoryId;

  const InterestEntity({this.id, this.name, this.categoryId});

  @override
  List<Object?> get props => [id, name, categoryId];
}
