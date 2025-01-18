



import 'package:days/features/home/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {

  AppRouter._();

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/',
    routes: <RouteBase>[
      HomeRoutes(),
    ],
  );

}