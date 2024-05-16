class Individual {
  int? id;
  String fullName;
  String email;
  String phoneNumber;
  String gender;
  String? role;
  String? profilePicUrl;

  Individual({
    this.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.gender,
    required this.role,
    required this.profilePicUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'gender': gender,
      'role': role,
      'profilePicUrl': profilePicUrl,
    };
  }

  factory Individual.fromMap(Map<String, dynamic> map) {
    return Individual(
      id: map['id'],
      fullName: map['fullName'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      gender: map['gender'],
      role: map['role'],
      profilePicUrl: map['profilePicUrl'],
    );
  }
}
