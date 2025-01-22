import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

String encryptUserId(String userId, {required String key}) {
  final encryptionKey = encrypt.Key.fromUtf8(key);

  // Définir un IV fixe (par exemple, une chaîne de 16 caractères)
  final iv =
      encrypt.IV.fromUtf8('1234567890123456'); // IV fixe de 16 caractères

  final encrypter = encrypt.Encrypter(encrypt.AES(encryptionKey));

  // Chiffrement
  final encrypted = encrypter.encrypt(userId, iv: iv);

  // Retourner uniquement la valeur cryptée (pas l'IV)
  return encrypted.base64;
}
