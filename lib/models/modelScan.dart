class DiseaseDetectionResult {
  final String className;
  final double confidence;
  final BoundingBox? boundingBox;
  
  DiseaseDetectionResult({
    required this.className,
    required this.confidence,
    this.boundingBox,
  });
  
  factory DiseaseDetectionResult.fromJson(Map<String, dynamic> json) {
    return DiseaseDetectionResult(
      className: json['class'] ?? '',
      confidence: (json['confidence'] ?? 0.0).toDouble(),
      boundingBox: json['x'] != null ? BoundingBox.fromJson(json) : null,
    );
  }
}

class BoundingBox {
  final double x, y, width, height;
  
  BoundingBox({
    required this.x,
    required this.y, 
    required this.width,
    required this.height,
  });
  
  factory BoundingBox.fromJson(Map<String, dynamic> json) {
    return BoundingBox(
      x: (json['x'] ?? 0.0).toDouble(),
      y: (json['y'] ?? 0.0).toDouble(),
      width: (json['width'] ?? 0.0).toDouble(),
      height: (json['height'] ?? 0.0).toDouble(),
    );
  }
}