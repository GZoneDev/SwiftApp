class UserData {
  final String uid;
  final String name;
  final String bio;
  final String birthday;
  final String gender;
  final String website;
  final String email;
  final String profilePictureUrl;
  final String plan;

  UserData({
    required this.uid,
    required this.name,
    required this.bio,
    required this.birthday,
    required this.gender,
    required this.website,
    required this.email,
    required this.profilePictureUrl,
    required this.plan,
  });

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      bio: map['bio'] ?? '',
      birthday: map['birthday'] ?? '',
      gender: map['gender'] ?? '',
      website: map['website'] ?? '',
      email: map['email'] ?? 'examplemail12345@gmail.com',
      profilePictureUrl: map['profilePictureUrl'] ??
          'https://static.vecteezy.com/system/resources/previews/005/544/718/non_2x/profile-icon-design-free-vector.jpg',
      plan: map['plan'] ?? 'Безкоштовно',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'bio': bio,
      'birthday': birthday,
      'gender': gender,
      'website': website,
      'email': email,
      'profilePictureUrl': profilePictureUrl,
      'plan': plan,
    };
  }
}
