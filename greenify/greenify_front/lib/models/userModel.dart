import 'dart:io';

import 'package:flutter/material.dart';
import 'package:greenify_front/models/userTypeEnum.dart';

class User with ChangeNotifier {
  UserTypeEnum? userType;
  String? name = "";
  String? foreName = "";
  String? email = "";
  String? phoneNumber = "";
  String? password = "";
  bool? greenified = false;
  DateTime? birthDate;
  FileImage? profilePicture;

  User({
    this.userType,
    this.name,
    this.foreName,
    this.email,
    this.phoneNumber,
    this.password,
    this.greenified,
    this.birthDate,
    this.profilePicture,
  });

  Map<String, dynamic> toJson() {
    return {
      'userType': userType?.value,
      'name': name,
      'foreName': foreName,
      'email': email,
      'phoneNumber': phoneNumber,
      'password': password,
      'greenified': greenified,
      'birthDate': birthDate?.toIso8601String(),
      'profilePicture': profilePicture?.file.path,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userType:
          json['userType'] != null
              ? UserTypeEnumExtension.fromValue(json['userType'])
              : null,
      name: json['name'],
      foreName: json['foreName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      password: json['password'],
      greenified: json['greenified'],
      birthDate:
          json['birthDate'] != null ? DateTime.parse(json['birthDate']) : null,
      profilePicture:
          json['profilePicture'] != null
              ? FileImage(File(json['profilePicture']))
              : null,
    );
  }

  void setUserType(UserTypeEnum userType) {
    this.userType = userType;
    notifyListeners();
  }

  void setName(String name) {
    this.name = name;
    notifyListeners();
  }

  void setForeName(String foreName) {
    this.foreName = foreName;
    notifyListeners();
  }

  void setEmail(String email) {
    this.email = email;
    notifyListeners();
  }

  void setPhoneNumber(String phoneNumber) {
    this.phoneNumber = phoneNumber;
    notifyListeners();
  }

  void setPassword(String password) {
    this.password = password;
    notifyListeners();
  }

  void setGreenified(bool greenified) {
    this.greenified = greenified;
    notifyListeners();
  }

  void setBirthDate(DateTime birthDate) {
    this.birthDate = birthDate;
    notifyListeners();
  }

  void setProfilePicture(FileImage profilePicture) {
    this.profilePicture = profilePicture;
    notifyListeners();
  }

  void reset() {
    userType = null;
    name = "";
    foreName = "";
    email = "";
    phoneNumber = "";
    password = "";
    greenified = false;
    birthDate = null;
    profilePicture = null;
    notifyListeners();
  }
}
