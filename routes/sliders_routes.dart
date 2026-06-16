import 'package:go_router/go_router.dart';
import '../pages/see_all_view.dart';
import 'sliders_route_names.dart';

final slidersRoutes = [
  GoRoute(
    path: SlidersRouteNames.seeAll,
    builder: (context, state) => const SeeAllView(),
  ),
];
