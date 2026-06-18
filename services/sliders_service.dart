import '../../../core/services/base_api_service.dart';
import '../models/slider_model.dart';

class SlidersService extends BaseApiService {
  static const String _route = '/slider/v1/sliders';

  Future<SliderModel?> getSlider(int id, {bool refresh = false}) async {
    try {
      final config = {
        'refresh': refresh,
        'params': {
          'include': 'slides.files',
        },
      };

      final response = await show(_route, id, config);
      
      if (response == null) return null;

      dynamic data;
      if (response is Map && response.containsKey('data')) {
        data = response['data'];
      } else {
        data = response;
      }

      if (data is List) {
        if (data.isEmpty) return null;
        // Buscamos el slider por id si es una lista
        final item = data.firstWhere(
          (element) => element['id']?.toString() == id.toString(),
          orElse: () => data.first,
        );
        data = item;
      }

      if (data is Map<String, dynamic>) {
        return SliderModel.fromJson(data);
      }
      
      return null;
    } catch (e) {
      print('❌ SlidersService Error: $e');
      rethrow;
    }
  }
}
