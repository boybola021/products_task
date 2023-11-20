
class UserModel{
  int id;
  String email;
  String username;
  String password;
  Name name;
  Address address;
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

  factory UserModel.fromJson(Map<String,Object?> json){
    return UserModel(
        id: json["id"] as int,
        email: json["email"] as String,
        username: json["username"] as String,
        password: json["password"] as String,
        name: Name.fromJson(json["name"] as Map<String,Object?>),
        address: Address.fromJson(json["address"] as Map<String,Object?>),
        phone: json["phone"] as String,
    );
  }


}


class Name{
  String firstname;
  String lastname;
  Name({required this.firstname,required this.lastname});
  factory Name.fromJson(Map<String,Object?> json){
    return Name(firstname: json["firstname"] as String, lastname: json["lastname"] as String);
  }
}


class Address{
  String city;
  String street;
  int number;
  String zipcode;
  GeoLocation geolocation;
  Address({
    required this.city,
    required this.street,
    required this.number,
    required this.zipcode,
    required this.geolocation,
});
  factory Address.fromJson(Map<String,Object?>json){
    return Address(
        city: json["city"] as String,
        street: json["street"] as String,
        number: json["number"] as int,
        zipcode: json["zipcode"] as String,
        geolocation: GeoLocation.fromJson(json["geolocation"] as Map<String,Object?>),
    );
  }
}

class GeoLocation{
 final String lat;
 final String long;
 GeoLocation({
   required this.lat,
   required this.long,
});

 factory GeoLocation.fromJson(Map<String,Object?>json){
   return GeoLocation(lat: json["lat"] as String, long: json["long"] as String);
 }
}