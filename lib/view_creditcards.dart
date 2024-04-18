import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:wheels_un/constants.dart';

class ViewCreditCards extends StatefulWidget {
  @override
  _ViewCreditCardsState createState() => _ViewCreditCardsState();
}

class _ViewCreditCardsState extends State<ViewCreditCards> {
  final String creditCardUrl = AG_URL + "/transaction";
  List<String> creditCards = [];
  int? _selectedIndex;
  String graphQLQuery = ' query { creditCardByUser(id: 492 ) {creditCardId number brand} }';

  @override
  void initState() {
    super.initState();
    fetchCreditCards();
  }

  Future<void> fetchCreditCards() async {
    try {
      var url = Uri.parse(creditCardUrl);
      var response = await http.post(
        url,
        headers: {"Content-type": "application/json"},
        body: json.encode({'query': graphQLQuery}),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['data'] != null && data['data']['creditCardByUser'] != null) {
          List<dynamic> cards = data['data']['creditCardByUser'];
          setState(() {
            creditCards = cards.map((card) => "${card['creditCardId']} -${card['brand']} - ${card['number']}").toList();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tarjetas de crédito'),
      ),
      body: ListView.builder(
        itemCount: creditCards.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(creditCards[index]),
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
            },
            selected: _selectedIndex == index,
            selectedTileColor: Colors.blue.withOpacity(0.5),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ViewCreditCards(),
  ));
}
