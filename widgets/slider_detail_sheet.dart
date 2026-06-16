import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/slider_model.dart';

class SliderDetailSheet extends StatefulWidget {
  final SlideModel slide;

  const SliderDetailSheet({super.key, required this.slide});

  @override
  State<SliderDetailSheet> createState() => _SliderDetailSheetState();
}

class _SliderDetailSheetState extends State<SliderDetailSheet> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulamos un pequeño retraso para mostrar el esqueleto como se pidió
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.9, // Máximo 90% de la pantalla
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle de la modal (Fijo arriba)
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 12, bottom: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            
            // Contenido con Scroll
            Flexible(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    if (_isLoading) _buildSkeleton() else _buildContent(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkeleton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagen Skeleton (Proporción aproximada)
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ).animate(onPlay: (c) => c.repeat()).shimmer(duration: 1200.ms),
          const SizedBox(height: 24),
          // Título Skeleton
          Container(
            height: 28,
            width: 200,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(6),
            ),
          ).animate(onPlay: (c) => c.repeat()).shimmer(duration: 1200.ms),
          const SizedBox(height: 16),
          // Descripción Skeleton
          ...List.generate(4, (index) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Container(
              height: 14,
              width: index == 3 ? 150 : double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          )).animate(interval: 100.ms, onPlay: (c) => c.repeat()).shimmer(duration: 1200.ms),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Imagen con altura controlada para dejar espacio al texto
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              widget.slide.imageUrl,
              width: double.infinity,
              height: 280, // Altura fija para equilibrio visual
              fit: BoxFit.cover, // Llena el espacio de forma estética
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  height: 280,
                  color: Colors.grey[100],
                  child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                );
              },
            ),
          ),
        ).animate().fadeIn(duration: 400.ms).scale(begin: const Offset(0.98, 0.98)),
        
        const SizedBox(height: 20),
        
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Título
              Text(
                widget.slide.title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF162F48),
                  letterSpacing: -0.5,
                  height: 1.1,
                ),
              ).animate().fadeIn(delay: 150.ms).slideY(begin: 0.1, end: 0),
              
              const SizedBox(height: 10),
              
              // Descripción
              Text(
                widget.slide.description,
                style: const TextStyle(
                  fontSize: 15,
                  color: Color(0xFF677B92),
                  height: 1.4,
                  fontWeight: FontWeight.w500,
                ),
              ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.05, end: 0),
            ],
          ),
        ),
      ],
    );
  }
}
