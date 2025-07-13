class DateFormatter {
  static String formatDate(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final assetDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

    final difference = today.difference(assetDate).inDays;

    if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return 'Yesterday';
    } else if (difference < 7) {
      return _getWeekdayName(assetDate.weekday);
    } else if (difference < 30) {
      return '${assetDate.day} ${_shortMonth(assetDate.month)}';
    } else {
      return '${_monthName(assetDate.month)} ${assetDate.year}';
    }
  }

  static String _getWeekdayName(int weekday) {
    switch (weekday) {
      case 1: return 'Monday';
      case 2: return 'Tuesday';
      case 3: return 'Wednesday';
      case 4: return 'Thursday';
      case 5: return 'Friday';
      case 6: return 'Saturday';
      case 7: return 'Sunday';
      default: return 'Unknown Day';
    }
  }

  static String _shortMonth(int month) {
    switch (month) {
      case 1: return 'Jan';
      case 2: return 'Feb';
      case 3: return 'Mar';
      case 4: return 'Apr';
      case 5: return 'May';
      case 6: return 'Jun';
      case 7: return 'Jul';
      case 8: return 'Aug';
      case 9: return 'Sep';
      case 10: return 'Oct';
      case 11: return 'Nov';
      case 12: return 'Dec';
      default: return '';
    }
  }

  static String _monthName(int month) {
    switch (month) {
      case 1: return 'January';
      case 2: return 'February';
      case 3: return 'March';
      case 4: return 'April';
      case 5: return 'May';
      case 6: return 'June';
      case 7: return 'July';
      case 8: return 'August';
      case 9: return 'September';
      case 10: return 'October';
      case 11: return 'November';
      case 12: return 'December';
      default: return 'Unknown Month';
    }
  }

  static DateTime extractDateFromHeader(String header) {
    final now = DateTime.now();

    if (header == 'Today') return now;
    if (header == 'Yesterday') return now.subtract(Duration(days: 1));
    if (_weekdays().contains(header)) {
      final diff = now.weekday - _weekdayNumber(header);
      return now.subtract(Duration(days: diff.abs()));
    }
    if (RegExp(r'^\d+ [A-Z][a-z]{2}$').hasMatch(header)) {
      final parts = header.split(' ');
      final day = int.tryParse(parts[0]) ?? 1;
      final month = _monthNumber(parts[1]);
      return DateTime(now.year, month ?? now.month, day);
    }
    final parts = header.split(' ');
    final year = int.tryParse(parts[1]);
    final month = _monthNumber(parts[0]);
    return DateTime(year ?? now.year, month ?? now.month, 1);
  }

  static List<String> _weekdays() => ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];

  static int _weekdayNumber(String name) {
    switch (name) {
      case 'Monday': return 1;
      case 'Tuesday': return 2;
      case 'Wednesday': return 3;
      case 'Thursday': return 4;
      case 'Friday': return 5;
      case 'Saturday': return 6;
      case 'Sunday': return 7;
      default: return 0;
    }
  }

  static int? _monthNumber(String name) {
    switch (name.toLowerCase()) {
      case 'jan': case 'january': return 1;
      case 'feb': case 'february': return 2;
      case 'mar': case 'march': return 3;
      case 'apr': case 'april': return 4;
      case 'may': return 5;
      case 'jun': case 'june': return 6;
      case 'jul': case 'july': return 7;
      case 'aug': case 'august': return 8;
      case 'sep': case 'september': return 9;
      case 'oct': case 'october': return 10;
      case 'nov': case 'november': return 11;
      case 'dec': case 'december': return 12;
      default: return null;
    }
  }
}