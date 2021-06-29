/// HTTP 미디어 타입
enum HttpMediaType {
  APPLICATION_JAVASCRIPT,
  APPLICATION_JSON,
  APPLICATION_XML,
  APPLICATION_ZIP,
  APPLICATION_PDF,
  APPLICATION_SQL,
  APPLICATION_GRAPHQL,
  APPLICATION_MS_WORD,
  APPLICATION_MS_EXCEL,
  APPLICATION_MS_POWERPOINT,
  AUDIO_MPEG,
  AUDIO_X_MS_WMA,
  MULTIPART_FORM_DATA,
  TEXT_CSS,
  TEXT_HTML,
  TEXT_CSV,
  TEXT_PLAIN,
  IMAGE_PNG,
  IMAGE_JPEG,
  IMAGE_GIF
}

/// [httpMediaType]을 문자열로 변환하여 반환한다.
String getStringByHttpMediaType(HttpMediaType httpMediaType) {
  switch (httpMediaType) {
    case HttpMediaType.APPLICATION_JAVASCRIPT:
      return 'application/javascript';
    case HttpMediaType.APPLICATION_JSON:
      return 'application/json';
    case HttpMediaType.APPLICATION_XML:
      return 'application/xml';
    case HttpMediaType.APPLICATION_ZIP:
      return 'application/zip';
    case HttpMediaType.APPLICATION_PDF:
      return 'application/pdf';
    case HttpMediaType.APPLICATION_SQL:
      return 'application/sql';
    case HttpMediaType.APPLICATION_GRAPHQL:
      return 'application/graphql';
    case HttpMediaType.APPLICATION_MS_WORD:
      return 'application/msword';
    case HttpMediaType.APPLICATION_MS_EXCEL:
      return 'application/vnd.ms-excel';
    case HttpMediaType.APPLICATION_MS_POWERPOINT:
      return 'application/vnd.ms-powerpoint';
    case HttpMediaType.AUDIO_MPEG:
      return 'audio/mpeg';
    case HttpMediaType.AUDIO_X_MS_WMA:
      return 'audio/x-ms-wma';
    case HttpMediaType.MULTIPART_FORM_DATA:
      return 'multipart/form-data';
    case HttpMediaType.TEXT_CSS:
      return 'text/css';
    case HttpMediaType.TEXT_HTML:
      return 'text/html';
    case HttpMediaType.TEXT_CSV:
      return 'text/csv';
    case HttpMediaType.TEXT_PLAIN:
      return 'text/plain';
    case HttpMediaType.IMAGE_PNG:
      return 'image/png';
    case HttpMediaType.IMAGE_JPEG:
      return 'image/jpeg';
    case HttpMediaType.IMAGE_GIF:
      return 'image/gif';
  }
}
