/// 문자 인코딩 방식
enum Charset {
  EUC_KR,
  UTF_8
}

/// [charset]을 문자열로 변환하여 반환한다.
String getStringByCharset(Charset charset) {
  switch (charset) {
    case Charset.EUC_KR:
      return 'euc-kr';
    default:
      return 'utf-8';
  }
}
