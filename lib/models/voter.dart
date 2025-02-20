class Voter {
  final String id;
  final String name;
  final String photoUrl;
  final int age;
  final String gender;
  final String pollingNumber;
  final String address;
  final bool hasVoted;

  Voter({
    required this.id,
    required this.name,
    required this.photoUrl,
    required this.age,
    required this.gender,
    required this.pollingNumber,
    required this.address,
    required this.hasVoted,
  });
}