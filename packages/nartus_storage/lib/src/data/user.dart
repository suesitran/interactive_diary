class User {
  final String uid;
  final String firstName;
  final String lastName;
  final String? photoUrl;

  const User(
      {required this.uid,
      required this.firstName,
      required this.lastName,
      this.photoUrl});
}
