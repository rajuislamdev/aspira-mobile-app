import 'package:equatable/equatable.dart';

class ThreadCountEntity extends Equatable {
  final int? reactions;
  final int? replies;

  const ThreadCountEntity({this.reactions, this.replies});

  ThreadCountEntity copyWith({int? reactions, int? replies}) {
    return ThreadCountEntity(
      reactions: reactions ?? this.reactions,
      replies: replies ?? this.replies,
    );
  }

  @override
  List<Object?> get props => [reactions, replies];
}
