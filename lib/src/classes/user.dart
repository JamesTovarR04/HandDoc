class User {
  int id;
  String name;
  String lastName;
  int personalIdentification;
  int loggedIn;
  String email;
  String password;
  String birthday;
  double height;
  double weight;

  User({
    this.id,
    this.name,
    this.lastName,
    this.personalIdentification,
    this.loggedIn,
    this.email,
    this.password,
    this.birthday,
    this.height,
    this.weight,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      lastName: json['lastName'],
      personalIdentification: json['personalIdentification'],
      loggedIn: json['loggedIn'],
      email: json['email'],
      password: json['password'],
      birthday: json['birthday'],
      height: json['height'],
      weight: json['weight'],
    );
  }
}
