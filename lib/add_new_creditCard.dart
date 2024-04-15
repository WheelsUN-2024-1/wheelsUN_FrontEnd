import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:math';

const double defaultPadding = 16.0;

class AddNewCardScreen extends StatefulWidget {
  @override
  const AddNewCardScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddNewCardScreenState();
}

class _AddNewCardScreenState extends State<AddNewCardScreen> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Flutter Credit Card View'),
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            CreditCardWidget(
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              showBackView: isCvvFocused,
              onCreditCardWidgetChange: (CreditCardBrand brand) {},
              obscureCardNumber: true,
              obscureCardCvv: true,
            ),
            Expanded(
                child: SingleChildScrollView(
                    child: Column(
              children: [
                CreditCardForm(
                  cardNumber: cardNumber,
                  expiryDate: expiryDate,
                  cardHolderName: cardHolderName,
                  cvvCode: cvvCode,
                  onCreditCardModelChange: onCreditCardModelChange,
                  formKey: formKey,
                  inputConfiguration: const InputConfiguration(
                    cardNumberDecoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Number',
                      hintText: 'XXXX XXXX XXXX XXXX',
                    ),
                    expiryDateDecoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Expired Date',
                      hintText: 'XX/XX',
                    ),
                    cvvCodeDecoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'CVV',
                      hintText: 'XXX',
                    ),
                    cardHolderDecoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Card Holder',
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    backgroundColor: Color(0xff1b447b),
                  ),
                  child: Container(
                    margin: EdgeInsets.all(8.0),
                    child: Text(
                      'Validate',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'halter',
                        fontSize: 14,
                        package: 'flutter_credit_card',
                      ),
                    ),
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      // Call PostCard method to send card information
                      Map<String, String> creditCard = {
                        'Number': cardNumber,
                        'Name': cardHolderName,
                        'SecurityCode': cvvCode,
                        'ExpirationDate': expiryDate,
                        'Brand': cardHolderName, // Assuming Brand is available
                      };
                      PostCard(creditCard);
                      print('Valid!');
                    } else {
                      print('Invalid!');
                    }
                  },
                )
              ],
            ))),
          ],
        ),
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  final String creditCardUrl =  "http://127.0.0.1:8100/transaction";

  void PostCard(Map<String, String> creditCard) async {
  var idc = Random().nextInt(900);

  var creditCardS = {
    'CreditCardId': idc,
    'Number': "${creditCard['Number']}",
    'UserId': 492, 
    'Name': "${creditCard['Name']}",
    'SecurityCode': "${creditCard['SecurityCode']}",
    'ExpirationDate': "${creditCard['ExpirationDate']}",
    'Brand': "${creditCard['Brand']}",
  };

  print(creditCardS['Name']);
  print(creditCardS['CreditCardId']);
  int idcons = 492;

  String graphQLQuery =
  ' mutation { createCreditCard(id: $idcons, creditcard: { CreditCardId: $idc, UserId: $idcons, Number: "${creditCardS['Number']}", Name: "${creditCardS['Name']}", SecurityCode: "${creditCardS['SecurityCode']}", ExpirationDate: "${creditCardS['ExpirationDate']}", Brand: "${creditCardS['Brand']}" }) { creditCardId userId number name securityCode expirationDate } }';

  try {
    var url = Uri.parse(creditCardUrl);
    var response = await http.post(
      url,
      headers: {"Content-type": "application/json"},
      body: json.encode({'query': graphQLQuery}),);
    final data = jsonDecode(response.body);
    print(data);
    if (response.statusCode == 200) {
      // The request was successful
      print('Successful POST request');
      print('Server response: ${response.body}');
    } else {
      // The request failed
      print('Error in POST request');
      print('Server status code: ${response.statusCode}');
      print('Server response: ${response.body}');
    }
  } catch (e) {
    // Catch any exceptions
    print('Exception occurred: $e');
    print('Failed to connect');
  }
}
}
