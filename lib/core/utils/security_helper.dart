import 'dart:convert';
import 'package:crypto/crypto.dart';

class SecurityHelper {
  static String hashPassword(String password) {
    final bytes = utf8.encode(password);
    return sha256.convert(bytes).toString();
  }

  static bool compareHashes(String password, String storedHash) {
    return hashPassword(password) == storedHash;
  }
}
