import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/sliders_provider.dart';
import '../widgets/slider_card.dart';
import '../widgets/slider_skeleton.dart';

class SeeAllView extends StatefulWidget {
  final int sliderId;
  final String title;

  const SeeAllView({
    super.key,
    this.sliderId = 0,
    this.title = '',
  });

  @override
  State<SeeAllView> createState() => _SeeAllViewState();
}

class _SeeAllViewState extends State<SeeAllView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final provider = context.read<SlidersProvider>();
        // Solo cargamos si no hay datos o es un slider diferente
        if (provider.slider == null || provider.slider!.id != widget.sliderId) {
          provider.loadSlider(widget.sliderId);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Color(0xFF162F48),
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF162F48)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Consumer<SlidersProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.slider == null) {
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: 5,
              itemBuilder: (context, index) => const SliderSkeleton(),
            );
          }

          final slides = provider.slider?.slides ?? [];

          if (slides.isEmpty && !provider.isLoading) {
            return const Center(child: Text('No slides found'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            itemCount: slides.length,
            itemBuilder: (context, index) {
              return SliderCard(slide: slides[index]);
            },
          );
        },
      ),
    );
  }
}
