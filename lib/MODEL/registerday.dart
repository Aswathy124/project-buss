
class DayScholar {
  final String name;
  final String department;
  final String admissionNo;
  final String place;
  final String busNo;

  DayScholar({
    required this.name,
    required this.department,
    required this.admissionNo,
    required this.place,
    required this.busNo,
  });

  // Convert DayScholar object to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'department': department,
      'admissionNo': admissionNo,
      'place': place,
      'busNo': busNo,
    };
  }
}
