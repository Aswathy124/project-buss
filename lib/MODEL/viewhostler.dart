class PassDetails {
  final String name;
  final String department;
  final String admissionNo;
  final String from;
  final String to;
  final int numberOfPasses;
  final DateTime date;

  PassDetails({
    required this.name,
    required this.department,
    required this.admissionNo,
    required this.from,
    required this.to,
    required this.numberOfPasses,
    required this.date,
  });

  factory PassDetails.fromJson(Map<String, dynamic> json) {
    return PassDetails(
      name: json['name'],
      department: json['department'],
      admissionNo: json['admissionNo'],
      from: json['from'],
      to: json['to'],
      numberOfPasses: json['numberOfPasses'],
      date: DateTime.parse(json['date']),
    );
  }
}
