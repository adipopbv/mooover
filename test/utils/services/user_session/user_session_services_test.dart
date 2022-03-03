import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mooover/utils/services/user_session/user_session_services.dart';

void main() {
  group("User session services", () {
    test("refresh token is being saved", () {
      WidgetsFlutterBinding.ensureInitialized();
      UserSessionServices().setRefreshToken("value");
      expect(UserSessionServices().refreshToken, "value");
    });
  });
}