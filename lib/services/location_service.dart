import 'package:flutter/material.dart';
import 'package:wheels_un/constants.dart';
import 'package:wheels_un/services/network_utils.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class LocationService {


  static void placeAutocomplete(String query) async {
    await initHiveForFlutter();
    final HttpLink httpLink = HttpLink(AG_URL);

    ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: httpLink,
      // The default store is the InMemoryStore, which does NOT persist to disk
      cache: GraphQLCache(store: HiveStore()),
    ),
  );
  }
}

