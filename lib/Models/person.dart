import 'package:cloud_firestore/cloud_firestore.dart';

class Person {
  String? id; // Add this field
  String? uid;
  String? email;
  String? password;
  String? name;
  int? age;
  String? phoneNo;
  String? city;
  String? country;
  String? profileHeading;
  String? lookingForPartner;
  String? height;
  String? weight;
  String? bodyType;
  String? drink;
  String? smoke;
  String? martialStatus;
  bool? haveChildren;
  int? noOfChildren;
  String? profession;
  String? employmentStatus;
  String? income;
  String? livingSituation;
  bool? willingToRelocate;
  String? relationship;
  String? nationality;
  String? education;
  String? language;
  String? religion;
  String? imageProfile;
  String? ethnicity;
  int? publishedDateTime;
  List? likedBy;
  List? dislikedBy;
  List? liked;
  List? disliked;
  String? gender;

  Person(
      {this.id, // Add this line
      this.uid,
      this.email,
      this.password,
      this.name,
      this.age,
      this.phoneNo,
      this.city,
      this.country,
      this.profileHeading,
      this.lookingForPartner,
      this.height,
      this.weight,
      this.bodyType,
      this.drink,
      this.smoke,
      this.martialStatus,
      this.haveChildren,
      this.noOfChildren,
      this.profession,
      this.employmentStatus,
      this.income,
      this.livingSituation,
      this.willingToRelocate,
      this.relationship,
      this.nationality,
      this.education,
      this.language,
      this.religion,
      this.ethnicity,
      this.imageProfile,
      this.publishedDateTime,
      this.likedBy,
      this.dislikedBy,
      this.liked,
      this.disliked,
      this.gender});

  Map<String, dynamic> toJson() {
    return {
      'id': id, // Add this line
      'uid': uid,
      'email': email,
      'password': password,
      'name': name,
      'age': age,
      'phoneNo': phoneNo,
      'city': city,
      'country': country,
      'profileHeading': profileHeading,
      'lookingForPartner': lookingForPartner,
      'height': height,
      'weight': weight,
      'bodyType': bodyType,
      'drink': drink,
      'smoke': smoke,
      'martialStatus': martialStatus,
      'haveChildren': haveChildren,
      'noOfChildren': noOfChildren,
      'profession': profession,
      'employmentStatus': employmentStatus,
      'income': income,
      'livingSituation': livingSituation,
      'willingToRelocate': willingToRelocate,
      'relationship': relationship,
      'nationality': nationality,
      'education': education,
      'language': language,
      'religion': religion,
      'ethnicity': ethnicity,
      'imageProfile': imageProfile,
      'publishedDateTime': publishedDateTime,
      'likedBy': likedBy,
      'dislikedBy': dislikedBy,
      'gender': gender
    };
  }

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
        id: json['id'], // Add this line
        uid: json['uid'],
        email: json['email'],
        password: json['password'],
        name: json['name'],
        age: json['age'],
        phoneNo: json['phoneNo'],
        city: json['city'],
        country: json['country'],
        profileHeading: json['profileHeading'],
        lookingForPartner: json['lookingForPartner'],
        height: json['height'],
        weight: json['weight'],
        bodyType: json['bodyType'],
        drink: json['drink'],
        smoke: json['smoke'],
        martialStatus: json['martialStatus'],
        haveChildren: json['haveChildren'],
        noOfChildren: json['noOfChildren'],
        profession: json['profession'],
        employmentStatus: json['employmentStatus'],
        income: json['income'],
        livingSituation: json['livingSituation'],
        willingToRelocate: json['willingToRelocate'],
        relationship: json['relationship'],
        nationality: json['nationality'],
        education: json['education'],
        language: json['language'],
        religion: json['religion'],
        ethnicity: json['ethnicity'],
        imageProfile: json['imageProfile'],
        publishedDateTime: json['publishedDateTime'],
        likedBy: json['likedBy'] != null ? List.from(json['likedBy']) : [],
        dislikedBy:
            json['dislikedBy'] != null ? List.from(json['dislikedBy']) : [],
        gender: json['gender']);
  }

  static Person fromDataSnapshot(DocumentSnapshot snapshot) {
    var dataSnapshot = snapshot.data() as Map<String, dynamic>;
    return Person(
        id: dataSnapshot['id'], // Add this line
        uid: dataSnapshot['uid'],
        email: dataSnapshot['email'],
        password: dataSnapshot['password'],
        name: dataSnapshot['name'],
        age: dataSnapshot['age'],
        phoneNo: dataSnapshot['phoneNo'],
        city: dataSnapshot['city'],
        country: dataSnapshot['country'],
        profileHeading: dataSnapshot['profileHeading'],
        lookingForPartner: dataSnapshot['lookingForPartner'],
        height: dataSnapshot['height'],
        weight: dataSnapshot['weight'],
        bodyType: dataSnapshot['bodyType'],
        drink: dataSnapshot['drink'],
        smoke: dataSnapshot['smoke'],
        martialStatus: dataSnapshot['martialStatus'],
        haveChildren: dataSnapshot['haveChildren'],
        noOfChildren: dataSnapshot['noOfChildren'],
        profession: dataSnapshot['profession'],
        employmentStatus: dataSnapshot['employmentStatus'],
        income: dataSnapshot['income'],
        livingSituation: dataSnapshot['livingSituation'],
        willingToRelocate: dataSnapshot['willingToRelocate'],
        relationship: dataSnapshot['relationship'],
        nationality: dataSnapshot['nationality'],
        education: dataSnapshot['education'],
        language: dataSnapshot['language'],
        religion: dataSnapshot['religion'],
        ethnicity: dataSnapshot['ethnicity'],
        imageProfile: dataSnapshot['imageProfile'],
        publishedDateTime: dataSnapshot['publishedDateTime'],
        likedBy: dataSnapshot['likedBy'] != null
            ? List.from(dataSnapshot['likedBy'])
            : [],
        dislikedBy: dataSnapshot['dislikedBy'] != null
            ? List.from(dataSnapshot['dislikedBy'])
            : [],
        gender: dataSnapshot['gender']);
  }
}
