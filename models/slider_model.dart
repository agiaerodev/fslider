class SlideModel {
  final int id;
  final String title;
  final String description;
  final String summary;
  final String imageUrl;

  SlideModel({
    required this.id,
    required this.title,
    required this.description,
    required this.summary,
    required this.imageUrl,
  });

  factory SlideModel.fromJson(Map<String, dynamic> json) {
    final rawDescription = (json['description'] ?? '').toString();
    final cleanDescription = rawDescription
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll('&#39;', "'")
        .replaceAll('&amp;', '&')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();

    return SlideModel(
      id: int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      title: (json['title'] ?? '').toString(),
      description: cleanDescription,
      summary: (json['summary'] ?? '').toString(),
      imageUrl: (json['mainimageUrl'] ?? '').toString(),
    );
  }
}

class SliderModel {
  final int id;
  final String name;
  final List<SlideModel> slides;

  SliderModel({
    required this.id,
    required this.name,
    required this.slides,
  });

  factory SliderModel.fromJson(Map<String, dynamic> json) {
    final slidesData = json['slides'];
    List<SlideModel> parsedSlides = [];
    
    if (slidesData is List) {
      parsedSlides = slidesData
          .where((item) => item != null)
          .map((item) => SlideModel.fromJson(Map<String, dynamic>.from(item)))
          .toList();
    }

    return SliderModel(
      id: int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      name: (json['name'] ?? '').toString(),
      slides: parsedSlides,
    );
  }
}
