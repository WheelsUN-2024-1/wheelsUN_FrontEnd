

class Trip {
    late String id;
    late String startingPoint;
    late String endingPoint;

    Trip(String id , String startingPoint, String endingPoint){
      this.id = id;
      this.startingPoint = startingPoint;
      this.endingPoint = endingPoint;
    }
}


class Prediction {
  late String description;
  late String placeId;

  Prediction(String description, String placeId){
    this.description = description;
    this.placeId = placeId;
  }
}