class User {
  final int id;
  final String name;
  final String imageUrl;
  final bool isOnline;

  User({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.isOnline,
  });
}

// YOU - current user
final User currentUser = User(
  id: 0,
  name: 'Mom',
  imageUrl: 'assets/images/mommy.jpg',
  isOnline: true,
);

// USERS
final User ironMan = User(
  id: 1,
  name: 'Nurse1',
  imageUrl: 'assets/images/nurse.png',
  isOnline: true,
);
final User captainAmerica = User(
  id: 2,
  name: 'Nurse2',
  imageUrl: 'assets/images/nurse.png',
  isOnline: true,
);
final User hulk = User(
  id: 3,
  name: 'Nurse3',
  imageUrl: 'assets/images/nurse.png',
  isOnline: false,
);
final User scarletWitch = User(
  id: 4,
  name: 'Nurse4',
  imageUrl: 'assets/images/nurse.png',
  isOnline: false,
);
final User spiderMan = User(
  id: 5,
  name: 'Nurse5',
  imageUrl: 'assets/images/nurse.png',
  isOnline: true,
);
final User blackWindow = User(
  id: 6,
  name: 'Nurse6',
  imageUrl: 'assets/images/nurse.png',
  isOnline: false,
);
final User thor = User(
  id: 7,
  name: 'Nurse7',
  imageUrl: 'assets/images/nurse.png',
  isOnline: false,
);
final User captainMarvel = User(
  id: 8,
  name: 'Nurse8',
  imageUrl: 'assets/images/nurse.png',
  isOnline: false,
);
