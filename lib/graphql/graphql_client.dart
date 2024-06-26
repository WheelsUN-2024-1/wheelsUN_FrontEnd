import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:wheels_un/constants.dart';

GraphQLClient getGraphQLClient() {
  final HttpLink httpLink = HttpLink(
    AG_URL + '/user', 
  );

  return GraphQLClient(
    link: httpLink,
    cache: GraphQLCache(store: InMemoryStore()),
  );
}

GraphQLClient getGraphQLClientTrip() {
  final HttpLink httpLink = HttpLink(
    AG_URL + '/trip', 
  );

  return GraphQLClient(
    link: httpLink,
    cache: GraphQLCache(store: InMemoryStore()),
  );
}