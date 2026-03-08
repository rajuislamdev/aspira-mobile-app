import 'package:equatable/equatable.dart';

class CountEntity extends Equatable {
  final int? reactions;
  final int? replies;

  const CountEntity({this.reactions, this.replies});

  CountEntity copyWith({int? reactions, int? replies}) {
    return CountEntity(
      reactions: reactions ?? this.reactions,
      replies: replies ?? this.replies,
    );
  }

  @override
  List<Object?> get props => [reactions, replies];
}
