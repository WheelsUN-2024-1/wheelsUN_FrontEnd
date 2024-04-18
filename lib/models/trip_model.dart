// trip_model.dart

class TripModel {
  String id;
  Map<String, dynamic> route; // JSON type replaced with Map<String, dynamic>
  int price;
  int vehicleId;
  List<String> transactionIds;
  int currentState;
  List<String> waypoints;

  TripModel({
    required this.id,
    required this.route,
    required this.price,
    required this.vehicleId,
    required this.transactionIds,
    required this.currentState,
    required this.waypoints,
  });
}

// trip_input.dart

class TripInput {
  final String startingPoint;
  final String endingPoint;
  final int price;
  final int vehicleId;
  final int currentState;

  TripInput({
    required this.startingPoint,
    required this.endingPoint,
    required this.price,
    required this.vehicleId,
    required this.currentState,
  });

  Map<String, dynamic> toJson() {
    return {
      'startingPoint': startingPoint,
      'endingPoint': endingPoint,
      'price': price,
      'vehicleId': vehicleId,
      'currentState': currentState,
    };
  }
}


// trip_passenger.dart

class TripPassenger {
  final int transactionId;
  final String waypoint;

  TripPassenger({
    required this.transactionId,
    required this.waypoint,
  });

  Map<String, dynamic> toJson() {
    return {
      'transactionId': transactionId,
      'waypoint': waypoint,
    };
  }
}


// trip_patch.dart

class TripPatch {
  final int? price;
  final int? vehicleId;
  final int? currentState;

  TripPatch({
    this.price,
    this.vehicleId,
    this.currentState,
  });

  Map<String, dynamic> toJson() {
    return {
      if (price != null) 'price': price,
      if (vehicleId != null) 'vehicleId': vehicleId,
      if (currentState != null) 'currentState': currentState,
    };
  }
}

