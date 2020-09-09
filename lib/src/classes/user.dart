class User {
  int id;
  String name;
  String lastName;
  int personalIdentification;
  int loggedIn;
  String phone;
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
    this.phone,
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
      phone: json['phone'],
      email: json['email'],
      password: json['password'],
      birthday: json['birthday'],
      height: json['height'],
      weight: json['weight'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'lastName': lastName,
      'personalIdentification': personalIdentification,
      'loggedIn': loggedIn,
      'phone': phone,
      'email': email,
      'password': password,
      'birthday': birthday,
      'height': height,
      'weight': weight,
    };
  }
}
