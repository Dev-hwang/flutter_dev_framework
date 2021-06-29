import 'package:intl/intl.dart';

/// 날짜 시간 유틸리티
class DateTimeUtils {
  DateTimeUtils._internal();
  static final instance = DateTimeUtils._internal();

  /// 현재 날짜를 문자열 타입으로 반환한다.
  String getNowDateString() {
    return getStringByDateTime(DateTime.now(), pattern: 'yyyy-MM-dd');
  }

  /// 현재 시간을 문자열 타입으로 반환한다.
  String getNowTimeString() {
    return getStringByDateTime(DateTime.now(), pattern: 'HH:mm:ss');
  }

  /// 현재 날짜 시간을 문자열 타입으로 반환한다.
  String getNowDateTimeString() {
    return getStringByDateTime(DateTime.now(), pattern: 'yyyy-MM-dd HH:mm:ss');
  }

  /// [dateTime]에 [days]를 추가하여 반환한다.
  DateTime getDateTimeWithSomeDay(DateTime dateTime, int days) {
    return dateTime.add(Duration(days: days));
  }

  /// [dateTime]에 [seconds]를 추가하여 반환한다.
  DateTime getDateTimeWithSomeSec(DateTime dateTime, int seconds) {
    return dateTime.add(Duration(seconds: seconds));
  }

  /// [dtString]를 [pattern] 형태의 DateTime 객체로 변환하여 반환한다.
  DateTime getDateTimeByString(String dtString, {String pattern = 'yyyy-MM-dd HH:mm:ss'}) {
    return DateFormat(pattern).parse(dtString);
  }

  /// [dateTime]을 [pattern] 형태의 문자열로 변환하여 반환한다.
  String getStringByDateTime(DateTime dateTime, {String pattern = 'yyyy-MM-dd HH:mm:ss'}) {
    return DateFormat(pattern).format(dateTime);
  }

  /// [index]에 해당하는 요일을 반환한다.
  String getWeekDayByInt(int index) {
    switch (index) {
      case 1: return '월요일';
      case 2: return '화요일';
      case 3: return '수요일';
      case 4: return '목요일';
      case 5: return '금요일';
      case 6: return '토요일';
      default: return '일요일';
    }
  }

  /// [dtString]의 요일을 반환한다.
  String getWeekDayByString(String dtString) {
    final dateTime = getDateTimeByString(dtString, pattern: 'yyyy-MM-dd');
    return getWeekDayByInt(dateTime.weekday);
  }

  /// [dateTime]의 요일을 반환한다.
  String getWeekDayByDateTime(DateTime dateTime) {
    return getWeekDayByInt(dateTime.weekday);
  }

  /// [dateTime]이 오늘인가?
  bool isToady(DateTime dateTime) {
    final today = DateTime.now();
    final cDate = DateTime(today.year, today.month, today.day);
    return cDate.difference(dateTime).inDays == 0;
  }

  /// [dateTime]이 이번 주인가?
  bool isWeek(DateTime dateTime) {
    final today = DateTime.now();
    final cDate = DateTime(today.year, today.month, today.day);
    final sDate = cDate.subtract(Duration(days: cDate.weekday - 1));
    final eDate = sDate.add(Duration(days: 6));

    final diffSDate = (sDate.difference(dateTime).inDays).abs();
    final diffEDate = (eDate.difference(dateTime).inDays).abs();

    return (diffSDate + diffEDate) < 7;
  }

  /// [dateTime]이 이번 달인가?
  bool isMonth(DateTime dateTime) {
    return DateTime.now().month == dateTime.month;
  }

  /// [minValue]를 시분 텍스트로 변환하여 반환한다.
  String getHourMinTextByMinValue(int minValue) {
    final hour = minValue ~/ 60;
    final min = minValue % 60;

    if (hour < 1)
      return '$min분';
    else
      return '$hour시간 $min분';
  }

  /// [secValue]를 분초 텍스트로 변환하여 반환한다.
  String getMinSecTextBySecValue(int secValue) {
    final min = secValue % 3600 ~/ 60;
    final sec = secValue % 3600 % 60;

    if (min < 1)
      return '$sec초';
    else
      return '$min분 $sec초';
  }
}
