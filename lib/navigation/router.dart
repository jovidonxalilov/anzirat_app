import 'package:anzirat/navigation/routes.dart';
import 'package:anzirat/page/anzirat_detail.dart';
import 'package:anzirat/page/sotti_detail.dart';
import 'package:go_router/go_router.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

final router = GoRouter(
  initialLocation: Routes.yandex,
  routes: [
    GoRoute(
      path: Routes.home,
      builder: (context, state) => FlutterMap(),
    ),
    GoRoute(
      path: Routes.map,
      builder: (context, state) => SottiDetail(),
    ),
    GoRoute(
      path: Routes.yandex,
      builder: (context, state) => YandexMap(),
    ),
  ],
);
