import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:wheels_un/models/auth_model.dart';
import 'package:wheels_un/models/transaction_model.dart';
import 'package:wheels_un/models/user_model.dart';
import 'package:wheels_un/models/vehicle_model.dart';

class ApiService {
  final GraphQLClient client;

  ApiService(this.client);

  // Método para registrar un nuevo usuario (Driver o Passenger).

  Future<QueryResult> register(RegisterModel registerModel) async {
    const String registerMutation = """
    mutation Register(\$userId: String!, \$password: String!) {
      register(registerM: {userId: \$userId, password: \$password}) {
        token
        message
      }
    }
    """;

    return await client.mutate(
      MutationOptions(
        document: gql(registerMutation),
        variables: {
          'userId': registerModel.userId,
          'password': registerModel.password,
        },
      ),
    );
  }

  // Método para iniciar sesión.

/*   mutation login{passengerLogin(email:"ana@gmail.com",password:"pepito123"){
  token
  message
}} */

  Future<QueryResult> login(LoginModel loginModel) async {
    const String loginMutation = """
  mutation Login(\$email: String!, \$password: String!) {
    passengerLogin(email: \$email, password: \$password) {
      token
      message
    }
  }
  """;

    return await client.mutate(
      MutationOptions(
        document: gql(loginMutation),
        variables: {
          'email': loginModel.email,
          'password': loginModel.password,
        },
      ),
    );
  }

  // Método para cerrar sesión.

  Future<QueryResult> logout(String token) async {
    const String logoutMutation = """
    mutation Logout(\$token: String!) {
      logout(token: \$token) {
        message
      }
    }
    """;

    return await client.mutate(
      MutationOptions(
        document: gql(logoutMutation),
        variables: {
          'token': token,
        },
      ),
    );
  }

  // Método para crear un nuevo conductor.

  Future<QueryResult> createNewDriver(
      DriverInput driver, String password) async {
    const String createDriverMutation = """
    mutation CreateNewDriver(\$driver: DriverInput!, \$password: String!) {
      createNewDriver(driver: \$driver, password: \$password) {
        token
        message
      }
    }
    """;

    return await client.mutate(
      MutationOptions(
        document: gql(createDriverMutation),
        variables: {
          'driver': driver.toJson(),
          'password': password,
        },
      ),
    );
  }

Future<QueryResult> createNewPassenger(
      PassengerInput passenger, String password) async {
    const String createPassengerMutation = """
    mutation CreateNewPassenger(\$passenger: PassengerInput!, \$password: String!) {
      createNewPassenger(passenger: \$passenger, password: \$password) {
        token
        message
      }
    }
    """;

    return await client.mutate(
      MutationOptions(
        document: gql(createPassengerMutation),
        variables: {
          'passenger': passenger.toJson(),
          'password': password,
        },
      ),
    );
  }

  // Método para crear un nuevo vehiculo.

  Future<QueryResult> createNewVehicle(
      VehicleInput vehicle) async {
    const String createVehicleMutation = """
    mutation CreateVehicle(\$vehicle: VehicleInput!) {
      createVehicle(vehicle: \$vehicle) {
        vehiclePlate
      }
    }
    """;

    return await client.mutate(
      MutationOptions(
        document: gql(createVehicleMutation),
        variables: {
          'vehicle': vehicle.toJson(),
        },
      ),
    );
  }

  // Método para crear una nueva tarjeta de crédito.
  Future<QueryResult> createCreditCard(CreditCardModel creditCardModel) async {
    const String createCreditCardMutation = """
    mutation CreateCreditCard(\$id: String!, \$creditcard: CreditCardModel!) {
      createCreditCard(id: \$id, creditcard: \$creditcard) {
        ID
        number
      }
    }
    """;

    return await client.mutate(
      MutationOptions(
        document: gql(createCreditCardMutation),
        variables: {
          'id': creditCardModel.userId,
          'creditcard': creditCardModel.toJson(),
        },
      ),
    );
  }
}
