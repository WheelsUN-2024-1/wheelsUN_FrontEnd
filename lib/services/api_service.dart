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

  Future<QueryResult> passengerLogin(LoginModel loginModel) async {
    const String passLoginMutation = """
  mutation Login(\$email: String!, \$password: String!) {
    passengerLogin(email: \$email, password: \$password) {
      token
      message
      passenger{
        id
        userIdNumber
        userName
        userAge
        userEmail
        userPhone
        userAddress
        userCity
        userCountry
        userPostalCode
      }
    }
  }
  """;

    return await client.mutate(
      MutationOptions(
        document: gql(passLoginMutation),
        variables: {
          'email': loginModel.email,
          'password': loginModel.password, 
        },
      ),
    );
  }

  Future<QueryResult> driverLogin(LoginModel loginModel) async {
      const String drivLoginMutation = """
    mutation Login(\$email: String!, \$password: String!) {
      driverLogin(email: \$email, password: \$password) {
        token
        message
        driver{
          id
          userIdNumber
          userName
          userAge
          userEmail
          userPhone
          userAddress
          userCity
          userCountry
          userPostalCode
          userLicenseExpirationDate
        }
      }
    }
    """;

      return await client.mutate(
        MutationOptions(
          document: gql(drivLoginMutation),
          variables: {
            'email': loginModel.email,
            'password': loginModel.password,
          },
        ),
      );
    }
  
  Future<QueryResult> createTripService(String start, String end, String? vehicle, int? price) async {
    print(start);
    print(end);
    print(vehicle);
    print(price);

    const String graphQLQuery = """
    mutation Create(\$start: String!, \$end: String!, \$vehicle: String!,\$price: Int!) {
      createTrip(trip: {startingPoint: \$start, endingPoint: \$end, price: \$price, vehicleId: \$vehicle, currentState: 1}) {
        id
        route
        price
        vehicleId
        transactionIds
        currentState
        waypoints
        startingPoint
        endingPoint
      }
    }
    """;

      return await client.mutate(
        MutationOptions(
          document: gql(graphQLQuery),
          variables: {
            'start': start,
            'end': end,
            'vehicle': vehicle,
            'price': price
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

//search vehicle for userId (cedula)
Future<QueryResult> vehicleById(int userId) async {
  const String vehicleQuery = """
    query VehicleById(\$id: Int!) {
      vehicleById(id: \$id) {
        vehiclePlate
        vehicleBrand
        vehicleModel
        vehicleYear
      }
    }
  """;

  return await client.mutate(
    MutationOptions(
      document: gql(vehicleQuery),
      variables: {
        'id': userId
      },
    ),
  );
}

//Delete vehicle for plate
Future<QueryResult> deleteVehicle(String plate) async {
  const String vehicleMutation = """
    mutation deleteVehicle(\$plate: String!) {
      deleteVehicle(plate: \$plate)
    }
  """;

  return await client.mutate(
    MutationOptions(
      document: gql(vehicleMutation),
      variables: {
        'plate': plate
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
