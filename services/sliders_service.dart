import '../../../core/services/base_api_service.dart';
import '../models/slider_model.dart';

class SlidersService extends BaseApiService {
  static const String _route = '/slider/v1/sliders';

  Future<SliderModel?> getSlider(String systemName, {bool refresh = false}) async {
    print('🚀 SlidersService: Loading slider $systemName (refresh: $refresh)');
    try {
      final config = {
        'refresh': refresh,
        'params': {
          'include': 'slides.files',
          'filter': {'field': 'system_name'}
        },
      };

      final response = await show(_route, systemName, config);
      
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
          (element) => element['systemName']?.toString() == systemName,
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
