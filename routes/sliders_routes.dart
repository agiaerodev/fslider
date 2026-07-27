import 'package:go_router/go_router.dart';
import '../pages/see_all_view.dart';
import 'sliders_route_names.dart';

final slidersRoutes = [
  GoRoute(
    path: SlidersRouteNames.seeAllPath,
    builder: (context, state) {
      final extra = state.extra as Map<String, dynamic>?;
      final systemName = extra?['systemName'] as String? ?? '';
      final title = extra?['title'] as String? ?? '';
      return SeeAllView(systemName: systemName, title: title);
    },
  ),
];
