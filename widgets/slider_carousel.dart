import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/sliders_provider.dart';
import 'slider_card.dart';
import 'slider_skeleton.dart';

class SliderCarousel extends StatelessWidget {
  const SliderCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SlidersProvider>(
      builder: (context, provider, child) {
        final slides = provider.slider?.slides ?? [];
        final bool showLoading = provider.isLoading && slides.isEmpty;

        if (showLoading) {
          return SizedBox(
            height: 265,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              clipBehavior: Clip.none,
              itemCount: 3,
              itemBuilder: (context, index) => const SliderSkeleton(
                width: 260,
                isCarouselItem: true,
              ),
            ),
          );
        }

        if (slides.isEmpty) {
          // Si no está cargando y sigue vacío, mostramos un placeholder o nada
          if (provider.isLoading) return const SizedBox.shrink(); // Ya manejado arriba pero por seguridad
          
          return Container(
            height: 100,
            alignment: Alignment.center,
            child: const Text('No slides available', style: TextStyle(color: Colors.grey)),
          );
        }

        return Stack(
          children: [
            SizedBox(
              height: 265,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.none,
                physics: const BouncingScrollPhysics(),
                itemCount: slides.length,
                itemBuilder: (context, index) {
                  return SliderCard(
                    slide: slides[index],
                    width: 260,
                    isCarouselItem: true,
                  );
                },
              ),
            ),
            if (provider.isLoading)
              Positioned(
                top: 0,
                right: 0,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 15,
                    height: 15,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
