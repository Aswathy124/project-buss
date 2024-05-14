class Dayscholar {
  final String id;
  final String name;
  final String department;
  final String admissionNo;
  final String place;
  final String busNo;

  Dayscholar({
    required this.id,
    required this.name,
    required this.department,
    required this.admissionNo,
    required this.place,
    required this.busNo,
  });

  factory Dayscholar.fromJson(Map<String, dynamic> json) {
    return Dayscholar(
      id: json['_id'],
      name: json['name'],
      department: json['department'],
      admissionNo: json['admissionNo'],
      place: json['place'],
      busNo: json['busNo'],
    );
  }
}
