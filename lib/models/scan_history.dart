class ScanHistory {
  final String disease;
  final double confidence;
  final String date;
  final String imagePath;

  ScanHistory({
    required this.disease,
    required this.confidence,
    required this.date,
    required this.imagePath,
  });

  factory ScanHistory.fromJson(Map<String, dynamic> json) {
    return ScanHistory(
      disease: json['disease'],
      confidence: json['confidence'],
      date: json['date'],
      imagePath: json['imagePath'],
    );
  }

  Map<String, dynamic> toJson() => {
    'disease': disease,
    'confidence': confidence,
    'date': date,
    'imagePath': imagePath,
  };
}
