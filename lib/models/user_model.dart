// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  int id;
  String email;
  String username;
  String password;
  NameModel name;
  AddressModel address;
  String phone;

  UserModel({
    required this.id,
    required this.email,
    required this.username,
    required this.password,
    required this.name,
    required this.address,
    required this.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      username: json['username'],
      password: json['password'],
      name: NameModel.fromJson(json['name']),
      address: AddressModel.fromJson(json['address']),
      phone: json['phone'],
    );
  }
}

class NameModel {
  String firstname;
  String lastname;

  NameModel({
    required this.firstname,
    required this.lastname,
  });

  factory NameModel.fromJson(Map<String, dynamic> json) {
    return NameModel(
      firstname: json['firstname'],
      lastname: json['lastname'],
    );
  }
}

class AddressModel {
  String city;
  String street;
  int number;
  String zipcode;
  GeolocationModel geolocation;

  AddressModel({
    required this.city,
    required this.street,
    required this.number,
    required this.zipcode,
    required this.geolocation,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      city: json['city'],
      street: json['street'],
      number: json['number'],
      zipcode: json['zipcode'],
      geolocation: GeolocationModel.fromJson(json['geolocation']),
    );
  }
}

class GeolocationModel {
  String lat;
  String long;

  GeolocationModel({
    required this.lat,
    required this.long,
  });

  factory GeolocationModel.fromJson(Map<String, dynamic> json) {
    return GeolocationModel(
      lat: json['lat'],
      long: json['long'],
    );
  }
}

class LoginModel {
  String token;

  LoginModel({
    required this.token,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      token: json['token'],
    );
  }
}
