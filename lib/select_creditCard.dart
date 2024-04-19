import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wheels_un/constants.dart';
import 'package:http/http.dart' as http;

class CreditCard {
  final String name;
  final String number;
  final String id;

  CreditCard({required this.name, required this.number, required this.id});
}

class SelectCreditCard extends StatefulWidget {
  final String selectedPrediction;
  final String tripId;

  SelectCreditCard({required this.selectedPrediction, required this.tripId});

  @override
  _SelectCreditCardState createState() => _SelectCreditCardState();
}

class _SelectCreditCardState extends State<SelectCreditCard> {
  final String creditCardUrl = AG_URL + "/transaction";
  final String joinUrl = AG_URL + "/trip";
  List<CreditCard> creditCards = [];
  int? _selectedIndex;
  int userId = 492;
  String tripId = "660bf2818a65cc44a2871b54";
  String passengerEmail = "ana@gmail.com";
  String stopPoint = "Centro Comercial Gran Estación";

  @override
  void initState() {
    super.initState();
    stopPoint = widget.selectedPrediction;
    tripId = widget.tripId;
    fetchCreditCards(userId);
  }

  Future<void> fetchCreditCards(userId) async {
    String graphQLQueryFetch = 'query { creditCardByUser(id: $userId ) {creditCardId number brand} }';
    try {
      var url = Uri.parse(creditCardUrl);
      var response = await http.post(
        url,
        headers: {"Content-type": "application/json"},
        body: json.encode({'query': graphQLQueryFetch}),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['data'] != null && data['data']['creditCardByUser'] != null) {
          List<dynamic> cards = data['data']['creditCardByUser'];
          setState(() {
            creditCards = cards.map((card) =>
                CreditCard(
                  name: card['brand'],
                  number: card['number'].toString(),
                  id: card['creditCardId'].toString(),
                )
            ).toList();
          });
        } else {
          print('No credit card data available.');
        }
      } else {
        print('Error in POST request');
        print('Server status code: ${response.statusCode}');
        print('Server response: ${response.body}');
      }
    } catch (e) {
      print('Exception occurred: $e');
      print('Failed to connect');
    }
  }

  Future<void> join_trip(tripId, passengerEmail, creditCardId, stopPoint) async {
    String graphQLQuery = 'mutation { joinTrip( tripId: "$tripId", creditCardId: $creditCardId,	passengerEmail:"$passengerEmail", stopPoint:"$stopPoint") {waypoints}}';
    try {
      var url = Uri.parse(joinUrl);
      var response = await http.post(
        url,
        headers: {"Content-type": "application/json"},
        body: json.encode({'query': graphQLQuery}),
      );
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
      print('Exception occurred: $e');
      print('Failed to connect');
    }
  }

  String? getNameOfSelectedCreditCard() {
    if (_selectedIndex != null) {
      return creditCards[_selectedIndex!].id;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecciona una tarjeta de crédito'),
      ),
      body: ListView.builder(
        itemCount: creditCards.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            title: Text('${creditCards[index].name} - ${creditCards[index].number}'),
            value: _selectedIndex == index,
            onChanged: (value) {
              setState(() {
                _selectedIndex = value! ? index : null;
              });
            },
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: ElevatedButton(
            onPressed: () {
              String? id = getNameOfSelectedCreditCard();
              if (id != null) {
                join_trip(tripId, passengerEmail, id, stopPoint);
              } else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Error'),
                      content: Text('Por favor, selecciona una tarjeta de crédito.'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              }
            },
            child: Text('Seleccionar tarjeta para realizar la transacción'),
          ),
        ),
      ),
    );
  }
}
