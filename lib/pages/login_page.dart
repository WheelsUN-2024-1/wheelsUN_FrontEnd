import 'package:flutter/material.dart';
import 'package:wheels_un/components/my_button.dart';
import 'package:wheels_un/components/my_textfield.dart';
import 'package:wheels_un/components/square_texfield.dart';
import 'package:wheels_un/graphql/graphql_client.dart';
import 'package:wheels_un/models/auth_model.dart';
import 'package:wheels_un/services/api_service.dart';
import 'package:wheels_un/globalVariables/user_data.dart';
import 'package:wheels_un/pages/home_page.dart';


class LoginPage extends StatelessWidget {
  final String role;
  LoginPage({super.key, required this.role});

  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final apiService = ApiService(getGraphQLClient());

    void signUserIn() async {
      final email = usernameController.text;
      final password = passwordController.text;

      if (email.isEmpty || password.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Please enter your username and password")),
        );
        return;
      }

      final loginModel = LoginModel(email: email, password: password);


      final response =
          await apiService.passengerLogin(loginModel);

      if (response.hasException) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.exception.toString())),
        );
      } else {
        print("Login successful");
        print(response.data);
        
        dynamic responseData = response.data; // Assuming response.data is already a decoded JSON object
        Map<String, dynamic> passengerData = responseData['passengerLogin']['passenger'];
        appIsDriver = false;
        appId = passengerData['id'];
        appIdNumber = passengerData['userIdNumber'];
        appName = passengerData['userName'];
        appAge = passengerData['userAge'];
        appEmail = passengerData['userEmail'];
        appPhone = passengerData['userPhone'];
        appAddress = passengerData['userAddress'];
        appCity = passengerData['userCity'];
        appCountry = passengerData['userCountry'];
        appPostalCode = passengerData['userPostalCode'];

        //here should go to homePage, this ProfilePage router is just for testing
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );

        
     /*    Navigator.pushReplacementNamed(
            context, '/home');  */
      }
    }

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),

              // logo
              const Icon(
                Icons.directions_car_sharp,
                size: 100,
                color: Color(0xFF68BB92),
              ),

              const SizedBox(height: 50),

              // welcome
              Text(
                'Welcome to wheelsUN!',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 25),

              // username textfield
              MyTextField(
                controller: usernameController,
                hintText: 'E-mail',
                obscureText: false,
              ),

              const SizedBox(height: 10),

              // password textfield
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),

              const SizedBox(height: 10),

              // forgot password?
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // sign in button
              MyButton(
                onTap: signUserIn,
                text: "Sign In",
              ),

              const SizedBox(height: 50),

              // or continue with
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 50),

              // google + apple sign in buttons
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // google button
                  SquareTile(imagePath: 'lib/images/google.png'),

                  SizedBox(width: 25),

                  // apple button
                  SquareTile(imagePath: 'lib/images/apple.png')
                ],
              ),

              const SizedBox(height: 50),

              // not a member? register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a member?',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'Register now',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
