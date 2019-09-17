


class Utils {
  static String getWelcomeMessage() {
    final hour = DateTime.now().hour;
    String msg;
    if (hour < 12) {
      msg = 'Good Morning';
    } else if (hour < 18) {
      msg = 'Good Afternoon';
    } else {
      msg = 'Good Evening';
    }
    return msg;
  }

  static String getDateAndTime(DateTime dateTime) {
    int hour = dateTime.hour;
    int minute = dateTime.minute;
    int weekDay = dateTime.weekday;
    int day = dateTime.day;
    int month = dateTime.month;
    String dateTimeString = '';
    var mapDays = {
      DateTime.monday: 'Mon',
      DateTime.tuesday: 'Tue',
      DateTime.wednesday: 'Wed',
      DateTime.thursday: 'Thu',
      DateTime.friday: 'Fri',
      DateTime.saturday: 'Sat',
      DateTime.sunday: 'Sun'
    };
    var mapMonth = {
      DateTime.january: 'Jan',
      DateTime.february: 'Feb',
      DateTime.march: 'Mar',
      DateTime.april: 'Apr',
      DateTime.may: 'May',
      DateTime.june: 'Jun',
      DateTime.july: 'Jul',
      DateTime.august: 'Aug',
      DateTime.september: 'Sep',
      DateTime.october: 'Oct',
      DateTime.november: 'Nov',
      DateTime.december: 'Dec'
    };
    return dateTimeString =
        mapDays[weekDay] + ' $day ' + mapMonth[month] + ', $hour:$minute';
  }

  static String dayReminder(DateTime dateTime) {
    DateTime now = DateTime.now();
    if (dateTime.isBefore(now)) {
      int before = -dateTime.difference(now).inDays;
      if(before==0){
        return 'Today';
      }else if(before==1){
        return 'Yesterday';
      }else if(before<=7){
        return '$before days ago';
      }else{
        return getDateAndTime(dateTime);
      } 
    } else if (dateTime.isAfter(now)) {
      int after=dateTime.difference(now).inDays;
      // return after.toString();
      // if(after==0) return 'Tomorow';
      return getDateAndTime(dateTime);
    }
    return 'Today'; 
  }
}
