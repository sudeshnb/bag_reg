class BagDetection {
  BagDetection({required this.imagePath, required this.date});

  BagDetection.fromJson(Map<String, Object?> json)
      : this(
          imagePath: json['imagePath']! as String,
          date: json['date']! as String,
        );

  final String imagePath;
  final String date;

  Map<String, Object?> toJson() {
    return {
      'title': imagePath,
      'date': date,
    };
  }
}
