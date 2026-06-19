import 'package:go_router/go_router.dart';
import '../pages/see_all_view.dart';
import 'sliders_route_names.dart';

final slidersRoutes = [
  GoRoute(
    path: SlidersRouteNames.seeAllPath,
    builder: (context, state) {
      final extra = state.extra as Map<String, dynamic>?;
      final sliderId = extra?['sliderId'] as int? ?? 0;
      final title = extra?['title'] as String? ?? '';
      return SeeAllView(sliderId: sliderId, title: title);
    },
  ),
];
