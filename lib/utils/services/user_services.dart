import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:mooover/utils/domain/group.dart';
import 'package:mooover/utils/domain/observer.dart';
import 'package:mooover/utils/domain/user.dart';
import 'package:mooover/utils/helpers/app_config.dart';
import 'package:mooover/utils/helpers/auth_interceptor.dart';
import 'package:mooover/utils/helpers/logger.dart';
import 'package:mooover/utils/helpers/operations.dart';

/// The services for the user entity.
class UserServices extends Observable {
  static final _instance = UserServices._();

  UserServices._();

  factory UserServices() => _instance;

  final http.Client _httpClient = InterceptedClient.build(interceptors: [
    AuthInterceptor(),
  ]);

  /// Gets the user with the given [userId].
  Future<User> getUser(String userId) async {
    logger.d('Getting user with id $userId');
    try {
      final response = await (() => _httpClient.get(
          Uri.http(
              AppConfig().apiDomain, '${AppConfig().userServicesPath}/$userId'),
          headers: {'Content-Type': 'application/json'})).withRetries(3);
      if (response.statusCode == 200) {
        final user = User.fromJson(jsonDecode(response.body));
        logger.i('Successfully got user with id $userId');
        return user;
      } else {
        logger.e('Failed to get user with id $userId');
        throw Exception(
            'Failed to get user: ${jsonDecode(response.body)["detail"]}');
      }
    } on HttpException catch (e) {
      logger.e('Failed to get user with id $userId', e);
      throw Exception('Failed to get user: $e');
    }
  }

  /// Updates the [user].
  Future<void> updateUser(User user) async {
    logger.d('Updating user with id ${user.id}');
    try {
      final response = await (() => _httpClient.put(
          Uri.http(AppConfig().apiDomain,
              '${AppConfig().userServicesPath}/${user.sub}'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(user.toJson()))).withRetries(3);
      if (response.statusCode == 200) {
        logger.i('Successfully updated user with id ${user.id}');
        notifyObservers();
      } else {
        logger.e('Failed to update user with id ${user.id}');
        throw Exception(
            'Failed to update user: ${jsonDecode(response.body)["detail"]}');
      }
    } on HttpException catch (e) {
      logger.e('Failed to update user with id ${user.id}', e);
      throw Exception('Failed to update user: $e');
    }
  }

  /// Gets the group of the user with the given [userId].
  Future<Group?> getGroupOfUser(String userId) async {
    logger.d('Getting group of user with id $userId');
    try {
      final response = await (() => _httpClient.get(
          Uri.http(AppConfig().apiDomain,
              '${AppConfig().userServicesPath}/$userId/group'),
          headers: {'Content-Type': 'application/json'})).withRetries(3);
      if (response.statusCode == 200) {
        final group = Group.fromJson(jsonDecode(response.body));
        logger.i('Successfully got group of user with id $userId');
        return group;
      } else if (response.statusCode == 204) {
        logger.i('User with id $userId is not in a group');
        return null;
      } else {
        logger.e('Failed to get group of user with id $userId');
        throw Exception(
            'Failed to get group of user: ${jsonDecode(response.body)["detail"]}');
      }
    } on HttpException catch (e) {
      logger.e('Failed to get group of user with id $userId', e);
      throw Exception('Failed to get group of user: $e');
    }
  }
}
