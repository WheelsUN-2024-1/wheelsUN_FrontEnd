import 'package:wheels_un/constants.dart';
import 'package:wheels_un/services/network_utils.dart';

class LocationService {


  static void placeAutocomplete(String query) async {
    final String url = 
    'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&key=$API_KEY';
    
    String? response = await NetworkUtil.fetchUrl(Uri.parse(url));
    if (response != null) {
      print(response);
    }
  }
}

