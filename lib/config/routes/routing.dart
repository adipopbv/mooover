import 'package:auto_route/auto_route.dart';
import 'package:mockito/mockito.dart';
import 'package:mooover/pages/greetings/greetings_page.dart';
import 'package:mooover/pages/group/group_page.dart';
import 'package:mooover/pages/home/home_page.dart';
import 'package:mooover/pages/login/login_page.dart';
import 'package:mooover/pages/profile/profile_page.dart';
import 'package:mooover/pages/settings/settings_page.dart';

@AdaptiveAutoRouter(routes: <AutoRoute>[
  AutoRoute(page: GreetingsPage, path: "/greetings", initial: true),
  AutoRoute(page: HomePage, path: "/home"),
  AutoRoute(page: LoginPage, path: "/login"),
  CustomRoute(
      page: ProfilePage,
      path: "/profile",
      transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
      durationInMilliseconds: 200,
      reverseDurationInMilliseconds: 200),
  CustomRoute(
      page: GroupPage,
      path: "/group",
      transitionsBuilder: TransitionsBuilders.slideRightWithFade,
      durationInMilliseconds: 200,
      reverseDurationInMilliseconds: 200),
  CustomRoute(
      page: SettingsPage,
      path: "/settings",
      transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
      durationInMilliseconds: 200,
      reverseDurationInMilliseconds: 200),
])
class $AppRouter {}

class AppRouteObserver extends Mock implements AutoRouteObserver {}
