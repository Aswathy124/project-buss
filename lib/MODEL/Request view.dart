class Hod {
  final String name;
  final String department;
  final String reason;
  final String bus;
  final String studentEmail;
  final String hodName;
  final String hodMail;
  final String tutorName;
  final String tutorMail;

  Hod({
    required this.name,
    required this.department,
    required this.reason,
    required this.bus,
    required this.studentEmail,
    required this.hodName,
    required this.hodMail,
    required this.tutorName,
    required this.tutorMail,
  });

  factory Hod.fromJson(Map<String, dynamic> json) {
    return Hod(
      name: json['name'],
      department: json['department'],
      reason: json['reason'],
      bus: json['bus'],
      studentEmail: json['studentEmail'],
      hodName: json['hodName'],
      hodMail: json['hodMail'],
      tutorName: json['tutorName'],
      tutorMail: json['tutorMail'],
    );
  }
}
