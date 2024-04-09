class UserDetails {
  final String name;
  final String userType;
  final String admissionNo;
  final String empId;
  final String email;
  final String password;

  UserDetails({
    required this.name,
    required this.userType,
    required this.admissionNo,
    required this.empId,
    required this.email,
    required this.password,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      name: json['name'],
      userType: json['userType'],
      admissionNo: json['admissionNo'],
      empId: json['empId'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'userType': userType,
      'admissionNo': admissionNo,
      'empId': empId,
      'email': email,
      'password': password,
    };
  }
}
