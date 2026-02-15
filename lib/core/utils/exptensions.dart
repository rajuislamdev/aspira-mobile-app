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

  static const _morningMessages = [
    'Good morning — ready to learn? ☀️',
    'Start your day smarter 🚀',
    'New day, new ideas 💡',
  ];

  String get smartGreeting {
    final h = hour;

    if (h < 12) {
      return _morningMessages[h % _morningMessages.length];
    }

    if (h < 18) {
      return 'Keep exploring what you love ❤️';
    }

    return 'Wind down with something interesting 🌙';
  }

  String get compactGreeting {
    final h = hour;

    if (h < 12) return 'Morning ☀️';
    if (h < 18) return 'Afternoon 🌤';
    return 'Evening 🌙';
  }

  String get postTime {
    final difference = DateTime.now().difference(this);

    if (difference.inMinutes < 60) {
      final m = difference.inMinutes;
      return '$m min${m > 1 ? 's' : ''} ago';
    } else if (difference.inHours < 24) {
      final h = difference.inHours;
      return '$h hour${h > 1 ? 's' : ''} ago';
    } else if (difference.inDays < 7) {
      final d = difference.inDays;
      return '$d day${d > 1 ? 's' : ''} ago';
    } else if (difference.inDays < 30) {
      final w = difference.inDays ~/ 7;
      return '$w week${w > 1 ? 's' : ''} ago';
    } else if (difference.inDays < 365) {
      final mo = difference.inDays ~/ 30;
      return '$mo month${mo > 1 ? 's' : ''} ago';
    } else {
      final y = difference.inDays ~/ 365;
      return '$y year${y > 1 ? 's' : ''} ago';
    }
  }
}
