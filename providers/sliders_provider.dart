import 'package:flutter/material.dart';
import '../models/slider_model.dart';
import '../services/sliders_service.dart';

class SlidersProvider extends ChangeNotifier {
  final SlidersService _services = SlidersService();

  SliderModel? _slider;
  SliderModel? get slider => _slider;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> loadSlider(int id, {bool refresh = false}) async {
    if (_isLoading) return;
    
    _isLoading = true;
    notifyListeners();

    try {
      debugPrint('🚀 SlidersProvider: Loading slider $id (refresh: $refresh)');
      final result = await _services.getSlider(id, refresh: refresh);
      if (result != null) {
        _slider = result;
      }
      debugPrint('✅ SlidersProvider: Loaded ${(_slider?.slides ?? []).length} slides');
    } catch (e) {
      debugPrint('❌ SlidersProvider Error loading slider: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
