class Activity {
  final String id;
  final String title;
  final String description;
  final String time; // HH:mm format

  Activity({
    required this.id,
    required this.title,
    required this.description,
    required this.time,
  });

  // Helper method to get time as DateTime for comparison
  DateTime get timeAsDateTime {
    final timeParts = time.split(':');
    final now = DateTime.now();
    return DateTime(
      now.year,
      now.month,
      now.day,
      int.parse(timeParts[0]),
      int.parse(timeParts[1]),
    );
  }

  // Check if activity is after 18:00
  bool get isAfter6PM {
    final timeParts = time.split(':');
    final hour = int.parse(timeParts[0]);
    return hour >= 18;
  }

  Activity copyWith({
    String? id,
    String? title,
    String? description,
    String? time,
  }) {
    return Activity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      time: time ?? this.time,
    );
  }

  @override
  String toString() {
    return 'Activity(id: $id, title: $title, description: $description, time: $time)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Activity &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.time == time;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        time.hashCode;
  }
}