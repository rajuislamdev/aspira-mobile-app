import 'package:flutter/cupertino.dart';

class GoalOption {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool recommended;

  const GoalOption({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.recommended = false,
  });
}
