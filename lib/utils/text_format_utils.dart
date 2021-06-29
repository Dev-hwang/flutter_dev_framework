/// 텍스트 포맷 유틸리티
class TextFormatUtils {
  TextFormatUtils._internal();
  static final instance = TextFormatUtils._internal();

  /// [text]에서 공백을 제거한다.
  String removeWhiteSpace(String text) {
    return text.replaceAll(RegExp(r"[\s]"), '');
  }

  /// [text]에서 특수문자를 제거한다.
  String removeSpecialChar(String text) {
    String result = text;
    result = result.replaceAll(RegExp(r"[^ㄱ-ㅎ|ㅏ-ㅣ|가-힣\u318D\u119E\u11A2\u2022\u2025a\u00B7\uFE55\w\s]"), '');
    result = result.replaceAll(RegExp(r"[_|]"), '');
    return result;
  }

  /// [phoneNo]에 대시('-')를 삽입한다.
  String getPhoneNoWithDash(String phoneNo) {
    phoneNo = removeWhiteSpace(phoneNo);
    phoneNo = removeSpecialChar(phoneNo);

    String firstNo, middleNo, lastNo;
    if (phoneNo.length == 10) {
      firstNo  = phoneNo.substring(0, 3);
      middleNo = phoneNo.substring(3, 6);
      lastNo   = phoneNo.substring(6, 10);
    } else if (phoneNo.length == 11) {
      firstNo  = phoneNo.substring(0, 3);
      middleNo = phoneNo.substring(3, 7);
      lastNo   = phoneNo.substring(7, 11);
    } else {
      return phoneNo;
    }

    return '$firstNo-$middleNo-$lastNo';
  }

  /// [truckNo]에 공백(' ')을 삽입한다.
  String getTruckNoWithSpace(String truckNo) {
    truckNo = removeWhiteSpace(truckNo);
    truckNo = removeSpecialChar(truckNo);

    String region, type, number;
    if (truckNo.length > 8) {
      region = truckNo.substring(0, 2);
      type   = truckNo.substring(2, truckNo.length - 4);
      number = truckNo.substring(truckNo.length - 4);
    } else {
      return truckNo;
    }

    return '$region $type $number';
  }

  /// [phoneNo]가 휴대전화 번호 형태를 가지는지 검증한다.
  bool validatePhoneNo(String phoneNo) {
    RegExp regExp = RegExp(r'^01(?:0|1|[6-9])(?:\d{3}|\d{4})\d{4}$');
    return regExp.hasMatch(phoneNo);
  }

  /// [identity]가 적절한 형태를 가지는지 검증한다. (최소 5자의 영문, 숫자 조합)
  bool validateIdentity(String identity) {
    RegExp regExp = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{5,}$');
    return regExp.hasMatch(identity);
  }

  /// [password]가 적절한 형태를 가지는지 검증한다. (최소 8자의 영문, 숫자, 특수문자 조합)
  bool validatePassword(String password) {
    RegExp regExp = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,}$');
    return regExp.hasMatch(password);
  }

  /// [truckNo]가 화물트럭 번호 형태를 가지는지 검증한다.
  bool validateTruckNo(String truckNo) {
    RegExp regExp = RegExp(r'^[가-힣]{2}[0-9]{2}[가-힣]{1}[0-9]{4}');
    return regExp.hasMatch(truckNo);
  }

  /// [conNo]가 컨테이너 번호 형태를 가지는지 검증한다.
  bool validateConNo(String conNo) {
    RegExp regExp = RegExp(r'^[A-Za-z]{4}[0-9]{7}');
    return regExp.hasMatch(conNo);
  }
}
