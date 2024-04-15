// vehicle_model.dart

class VehicleModel {
  int vehicleOwnerId;
  String vehiclePlate;
  String vehicleBrand;
  String vehicleModel;
  String vehicleCylinder;
  int vehicleYear;
  int vehicleSeatingCapacity;

  VehicleModel({
    required this.vehicleOwnerId,
    required this.vehiclePlate,
    required this.vehicleBrand,
    required this.vehicleModel,
    required this.vehicleCylinder,
    required this.vehicleYear,
    required this.vehicleSeatingCapacity,
  });
}

// vehicle_input.dart

class VehicleInput {
  final int vehicleOwnerId;
  final String vehiclePlate;
  final String vehicleBrand;
  final String vehicleModel;
  final String vehicleCylinder;
  final int vehicleYear;
  final int vehicleSeatingCapacity;

  VehicleInput({
    required this.vehicleOwnerId,
    required this.vehiclePlate,
    required this.vehicleBrand,
    required this.vehicleModel,
    required this.vehicleCylinder,
    required this.vehicleYear,
    required this.vehicleSeatingCapacity,
  });

  Map<String, dynamic> toJson() {
    return {
      'vehicleOwnerId': vehicleOwnerId,
      'vehiclePlate': vehiclePlate,
      'vehicleBrand': vehicleBrand,
      'vehicleModel': vehicleModel,
      'vehicleCylinder': vehicleCylinder,
      'vehicleYear': vehicleYear,
      'vehicleSeatingCapacity': vehicleSeatingCapacity,
    };
  }
}


// vehicle_patch.dart

class VehiclePatch {
  final int? vehicleOwnerId;
  final String? vehiclePlate;
  final String? vehicleBrand;
  final String? vehicleModel;
  final String? vehicleCylinder;
  final int? vehicleYear;
  final int? vehicleSeatingCapacity;

  VehiclePatch({
    this.vehicleOwnerId,
    this.vehiclePlate,
    this.vehicleBrand,
    this.vehicleModel,
    this.vehicleCylinder,
    this.vehicleYear,
    this.vehicleSeatingCapacity,
  });

  Map<String, dynamic> toJson() {
    return {
      if (vehicleOwnerId != null) 'vehicleOwnerId': vehicleOwnerId,
      if (vehiclePlate != null) 'vehiclePlate': vehiclePlate,
      if (vehicleBrand != null) 'vehicleBrand': vehicleBrand,
      if (vehicleModel != null) 'vehicleModel': vehicleModel,
      if (vehicleCylinder != null) 'vehicleCylinder': vehicleCylinder,
      if (vehicleYear != null) 'vehicleYear': vehicleYear,
      if (vehicleSeatingCapacity != null) 'vehicleSeatingCapacity': vehicleSeatingCapacity,
    };
  }
}

