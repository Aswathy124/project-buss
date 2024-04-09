class BusPassModel {
  final String name;
  final String department;
  final String admissionNo;
  final String from;
  final String to;
  final int numberOfPasses;


  BusPassModel({
    required this.name,
    required this.department,
    required this.admissionNo,
    required this.from,
    required this.to,
    required this.numberOfPasses, required DateTime date,
  });



  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'department': department,
      'admissionNo': admissionNo,
      'from': from,
      'to': to,
      'numberOfPasses': numberOfPasses,
    };
  }
}
