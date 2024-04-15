import 'package:graphql_flutter/graphql_flutter.dart';

class ApiService {
final GraphQLClient client;

  ApiService(this.client);

  Future<RegisterResponse> register(RegisterModel registerModel) async {
    const String mutation = """
      mutation Register(\$userId: String!, \$password: String!) {
        register(userId: \$userId, password: \$password) {
          token
          message
        }
      }
    """;

    final MutationOptions options = MutationOptions(
      document: gql(mutation),
      variables: registerModel.toJson(),
    );

    final QueryResult result = await client.mutate(options);
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    return RegisterResponse.fromJson(result.data!['register']);
  }

  Future<LoginResponse> login(LoginModel loginModel) async {
    const String mutation = """
      mutation Login(\$userId: String!, \$password: String!) {
        login(userId: \$userId, password: \$password) {
          token
          message
        }
      }
    """;

    final MutationOptions options = MutationOptions(
      document: gql(mutation),
      variables: loginModel.toJson(),
    );

    final QueryResult result = await client.mutate(options);
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    return LoginResponse.fromJson(result.data!['login']);
  }

}
