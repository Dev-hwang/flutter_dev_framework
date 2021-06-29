/*
class EncryptionUtils {
  EncryptionUtils._internal();
  static final instance = EncryptionUtils._internal();

  /// AES 비밀키를 요청한다.
  Future<SecretKey> _getAESSecretKey([AESMode mode = AESMode.cbc]) async {
    String secretKeyName;
    switch (mode) {
      case AESMode.cbc:
        secretKeyName = 'aesCbcSecretKey';
        break;
      case AESMode.ctr:
        secretKeyName = 'aesCtrSecretKey';
        break;
      default:
        secretKeyName = 'aesGcmSecretKey';
    }

    SecretKey secretKey;
    List<int> secretKeyBytes;
    List<String> secretKeyString;

    final prefs = await SharedPreferences.getInstance();
    secretKeyString = prefs.getStringList(secretKeyName);
    if (secretKeyString == null) {
      switch (mode) {
        case AESMode.cbc:
          secretKey = await aesCbc.newSecretKey();
          break;
        case AESMode.ctr:
          secretKey = await aesCtr.newSecretKey();
          break;
        default:
          secretKey = await aesGcm.newSecretKey();
      }

      secretKeyBytes = await secretKey.extract();
      secretKeyString = secretKeyBytes.map((e) => e.toString()).toList();

      if (await prefs.setStringList(secretKeyName, secretKeyString))
        return secretKey;
      else
        throw Exception('Failed to save $secretKeyName');
    }

    secretKeyBytes = secretKeyString.map((e) => int.parse(e)).toList();
    return SecretKey(secretKeyBytes);
  }

  /// Nonce 객체를 요청한다.
  Future<Nonce> _getNonceObject([int length = 16]) async {
    Nonce nonce;
    List<int> nonceBytes;
    List<String> nonceString;

    final prefs = await SharedPreferences.getInstance();
    nonceString = prefs.getStringList('nonce');
    if (nonceString == null) {
      nonce = Nonce.randomBytes(length);
      nonceBytes = nonce.bytes;
      nonceString = nonceBytes.map((e) => e.toString()).toList();

      if (await prefs.setStringList('nonce', nonceString))
        return nonce;
      else
        throw Exception('Failed to save nonce');
    }

    nonceBytes = nonceString.map((e) => int.parse(e)).toList();
    return Nonce(nonceBytes);
  }

  /// AES 알고리즘을 사용하여 평문 [codeUnits]를 암호화한다.
  Future<Uint8List> encryptWithAES(List<int> codeUnits, {AESMode mode = AESMode.cbc}) async {
    final secretKey = await _getAESSecretKey(mode);
    final nonce = await _getNonceObject(16);

    final plainText = Uint8List.fromList(codeUnits);

    switch (mode) {
      case AESMode.cbc:
        return await aesCbc.encrypt(plainText, secretKey: secretKey, nonce: nonce);
      case AESMode.ctr:
        return await aesCtr.encrypt(plainText, secretKey: secretKey, nonce: nonce);
      default:
        return await aesGcm.encrypt(plainText, secretKey: secretKey, nonce: nonce);
    }
  }

  /// AES 알고리즘을 사용하여 암호화된 [codeUnits]를 복호화한다.
  Future<Uint8List> decryptWithAES(List<int> codeUnits, {AESMode mode = AESMode.cbc}) async {
    final secretKey = await _getAESSecretKey(mode);
    final nonce = await _getNonceObject(16);

    final encryptedText = Uint8List.fromList(codeUnits);

    switch (mode) {
      case AESMode.cbc:
        return await aesCbc.decrypt(encryptedText, secretKey: secretKey, nonce: nonce);
      case AESMode.ctr:
        return await aesCtr.decrypt(encryptedText, secretKey: secretKey, nonce: nonce);
      default:
        return await aesGcm.decrypt(encryptedText, secretKey: secretKey, nonce: nonce);
    }
  }
}

/// AES 알고리즘 모드
enum AESMode {
  cbc,
  ctr,
  gcm
}
*/
