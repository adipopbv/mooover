import 'package:flutter_test/flutter_test.dart';
import 'package:mooover/utils/domain/exceptions.dart';

void main() {
  group("AppException", () {
    test("is an exception and can be thrown", () async {
      expect(() { throw const AppException("message"); }, throwsA(isA<AppException>()));
    });
    test("gets the error message in string form", () async {
      expect(const AppException("message").toString(), "Error: message");
    });
  });

  group("LoginException", () {
    test("is an exception and can be thrown", () async {
      expect(() { throw LoginException(message: "message"); }, throwsA(isA<LoginException>()));
    });
    test("gets the error message in string form", () async {
      expect(LoginException().toString(), "Error: login error");
    });
  });

  group("LogoutException", () {
    test("is an exception and can be thrown", () async {
      expect(() { throw LogoutException(message: "message"); }, throwsA(isA<LogoutException>()));
    });
    test("gets the error message in string form", () async {
      expect(LogoutException().toString(), "Error: logout error");
    });
  });
}