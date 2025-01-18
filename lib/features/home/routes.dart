import 'package:days/features/home/presentation/pages/home_page.dart';
import 'package:go_router/go_router.dart';


class HomeRoutes extends GoRoute {

  HomeRoutes() : super(
    path: '/',
    builder: (context, state) => const HomePage(),
    routes: <RouteBase>[],
  );

}