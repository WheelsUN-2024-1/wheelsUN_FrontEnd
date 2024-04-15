// transaction_model.dart

class CreditCardModel {
  int creditCardId;
  String userId;
  String number;
  String name;
  String securityCode;
  String expirationDate;
  String brand;

  CreditCardModel({
    required this.creditCardId,
    required this.userId,
    required this.number,
    required this.name,
    required this.securityCode,
    required this.expirationDate,
    required this.brand,
  });

  toJson() {}
}

class TransactionModel {
  String language;
  String command;
  bool test;
  Map<String, dynamic> merchant; // JSON type replaced with Map<String, dynamic>
  Map<String, dynamic> transaction; // JSON type replaced with Map<String, dynamic>

  TransactionModel({
    required this.language,
    required this.command,
    required this.test,
    required this.merchant,
    required this.transaction,
  });
}

class TransactionResponse {
  int id;
  String createdAt;
  String updatedAt;
  String? deletedAt;
  String referenceCode;
  String description;
  int value;
  String paymentMethods;
  String state;
  int tripId;
  int creditCardId;

  TransactionResponse({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.referenceCode,
    required this.description,
    required this.value,
    required this.paymentMethods,
    required this.state,
    required this.tripId,
    required this.creditCardId,
  });

  factory TransactionResponse.fromJson(Map<String, dynamic> json) {
    return TransactionResponse(
      id: json['ID'],
      createdAt: json['CreatedAt'],
      updatedAt: json['UpdatedAt'],
      deletedAt: json['DeletedAt'],
      referenceCode: json['referenceCode'],
      description: json['description'],
      value: json['value'],
      paymentMethods: json['paymentMethods'],
      state: json['state'],
      tripId: json['tripId'],
      creditCardId: json['creditCardId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'CreatedAt': createdAt,
      'UpdatedAt': updatedAt,
      'DeletedAt': deletedAt,
      'referenceCode': referenceCode,
      'description': description,
      'value': value,
      'paymentMethods': paymentMethods,
      'state': state,
      'tripId': tripId,
      'creditCardId': creditCardId,
    };
  }
}
