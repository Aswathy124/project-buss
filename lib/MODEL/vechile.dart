class VehicleRequest {
  final String name;
  final String empid;
  final String reason;
  final String type;
  final int capacity;
  final String hodName;
  final String hodEmail;
  final String adminName;
  final String adminEmail;

  VehicleRequest({
    required this.name,
    required this.empid,
    required this.reason,
    required this.type,
    required this.capacity,
    required this.hodName,
    required this.hodEmail,
    required this.adminName,
    required this.adminEmail,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'empid': empid,
      'reason': reason,
      'type': type,
      'capacity': capacity,
      'hodName': hodName,
      'hodEmail': hodEmail,
      'adminName': adminName,
      'adminEmail': adminEmail,
    };
  }
}
