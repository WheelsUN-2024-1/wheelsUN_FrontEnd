// user_model.dart

class PassengerModel {
  String id;
  int userIdNumber;
  String userName;
  int userAge;
  String userEmail;
  String userPhone;
  String userAddress;
  String userCity;
  String userCountry;
  String userPostalCode;

  PassengerModel({
    required this.id,
    required this.userIdNumber,
    required this.userName,
    required this.userAge,
    required this.userEmail,
    required this.userPhone,
    required this.userAddress,
    required this.userCity,
    required this.userCountry,
    required this.userPostalCode,
  });
}

class DriverModel extends PassengerModel {
  String userLicenseExpirationDate;

  DriverModel({
    required String id,
    required int userIdNumber,
    required String userName,
    required int userAge,
    required String userEmail,
    required String userPhone,
    required String userAddress,
    required String userCity,
    required String userCountry,
    required String userPostalCode,
    required this.userLicenseExpirationDate,
  }) : super(
    id: id,
    userIdNumber: userIdNumber,
    userName: userName,
    userAge: userAge,
    userEmail: userEmail,
    userPhone: userPhone,
    userAddress: userAddress,
    userCity: userCity,
    userCountry: userCountry,
    userPostalCode: userPostalCode,
  );
}



// passenger_input.dart

class PassengerInput {
  int userIdNumber;
  String userName;
  int userAge;
  String userEmail;
  String userPhone;
  String userAddress;
  String userCity;
  String userCountry;
  String userPostalCode;

  PassengerInput({
    required this.userIdNumber,
    required this.userName,
    required this.userAge,
    required this.userEmail,
    required this.userPhone,
    required this.userAddress,
    required this.userCity,
    required this.userCountry,
    required this.userPostalCode,
  });

  Map<String, dynamic> toJson() {
    return {
      'userIdNumber': userIdNumber,
      'userName': userName,
      'userAge': userAge,
      'userEmail': userEmail,
      'userPhone': userPhone,
      'userAddress': userAddress,
      'userCity': userCity,
      'userCountry': userCountry,
      'userPostalCode': userPostalCode,
    };
  }
}


// driver_input.dart



class DriverInput extends PassengerInput {
  String userLicenseExpirationDate;

  DriverInput({
    required int userIdNumber,
    required String userName,
    required int userAge,
    required String userEmail,
    required String userPhone,
    required String userAddress,
    required String userCity,
    required String userCountry,
    required String userPostalCode,
    required this.userLicenseExpirationDate,
  }) : super(
          userIdNumber: userIdNumber,
          userName: userName,
          userAge: userAge,
          userEmail: userEmail,
          userPhone: userPhone,
          userAddress: userAddress,
          userCity: userCity,
          userCountry: userCountry,
          userPostalCode: userPostalCode,
        );

  @override
  Map<String, dynamic> toJson() {
    final map = super.toJson();
    map['userLicenseExpirationDate'] = userLicenseExpirationDate;
    return map;
  }
}


// passenger_patch.dart

class PassengerPatch {
  String? userName;
  int? userAge;
  String? userEmail;
  String? userPhone;
  String? userAddress;
  String? userCity;
  String? userCountry;
  String? userPostalCode;

  PassengerPatch({
    this.userName,
    this.userAge,
    this.userEmail,
    this.userPhone,
    this.userAddress,
    this.userCity,
    this.userCountry,
    this.userPostalCode,
  });

  Map<String, dynamic> toJson() {
    return {
      if (userName != null) 'userName': userName,
      if (userAge != null) 'userAge': userAge,
      if (userEmail != null) 'userEmail': userEmail,
      if (userPhone != null) 'userPhone': userPhone,
      if (userAddress != null) 'userAddress': userAddress,
      if (userCity != null) 'userCity': userCity,
      if (userCountry != null) 'userCountry': userCountry,
      if (userPostalCode != null) 'userPostalCode': userPostalCode,
    };
  }
}


// driver_patch.dart

class DriverPatch extends PassengerPatch {
  String? userLicenseExpirationDate;

  DriverPatch({
    String? userName,
    int? userAge,
    String? userEmail,
    String? userPhone,
    String? userAddress,
    String? userCity,
    String? userCountry,
    String? userPostalCode,
    this.userLicenseExpirationDate,
  }) : super(
          userName: userName,
          userAge: userAge,
          userEmail: userEmail,
          userPhone: userPhone,
          userAddress: userAddress,
          userCity: userCity,
          userCountry: userCountry,
          userPostalCode: userPostalCode,
        );

  @override
  Map<String, dynamic> toJson() {
    final map = super.toJson();
    if (userLicenseExpirationDate != null) {
      map['userLicenseExpirationDate'] = userLicenseExpirationDate;
    }
    return map;
  }
}

