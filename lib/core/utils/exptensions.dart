extension DateTimeExtension on DateTime {
  String get timeOfDay {
    final hour = this.hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  String get postTime {
    final difference = DateTime.now().difference(this);
    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hour ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} day ago';
    } else if (difference.inDays < 30) {
      return '${difference.inDays / 7} week ago';
    } else if (difference.inDays < 365) {
      return '${difference.inDays / 30} month ago';
    } else {
      return '${difference.inDays / 365} year ago';
    }
  }
}
