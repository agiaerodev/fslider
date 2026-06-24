import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../routes/sliders_route_names.dart';
import 'slider_carousel.dart';

class SliderSection extends StatelessWidget {
  final String title;
  final bool isDark;
  final int sliderId;

  const SliderSection({
    super.key,
    required this.title,
    required this.sliderId,
    this.isDark = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: isDark ? const Color(0xFF1A3B5D) : Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            const SizedBox(width: 8),
            TextButton(
              onPressed: () => context.push(
                SlidersRouteNames.seeAllPath,
                extra: {'sliderId': sliderId, 'title': title},
              ),
              child: Text(
                'View All',
                style: TextStyle(
                  color: isDark ? const Color(0xFF007AFF) : Colors.white70,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        SliderCarousel(sliderId: sliderId),
      ],
    );
  }
}
