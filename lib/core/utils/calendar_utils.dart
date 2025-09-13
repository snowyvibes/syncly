DateTime normalizeDate(DateTime date) {
  return DateTime.utc(date.year, date.month, date.day);
}

bool isSameDay(DateTime? a, DateTime? b) {
  if (a == null || b == null) return false;
  return a.year == b.year && a.month == b.month && a.day == b.day;
}

int getWeekdayNumber(StartingDayOfWeek startingDayOfWeek) {
  switch (startingDayOfWeek) {
    case StartingDayOfWeek.monday:
      return DateTime.monday;
    case StartingDayOfWeek.tuesday:
      return DateTime.tuesday;
    case StartingDayOfWeek.wednesday:
      return DateTime.wednesday;
    case StartingDayOfWeek.thursday:
      return DateTime.thursday;
    case StartingDayOfWeek.friday:
      return DateTime.friday;
    case StartingDayOfWeek.saturday:
      return DateTime.saturday;
    case StartingDayOfWeek.sunday:
      return DateTime.sunday;
  }
}

enum StartingDayOfWeek {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday,
}



enum AvailableGestures { all, horizontalSwipe, verticalSwipe, none }

enum SwipeDirection { up, down }
