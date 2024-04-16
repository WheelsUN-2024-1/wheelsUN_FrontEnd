import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SelectCreditCard extends StatefulWidget {
  @override
  _SelectCreditCardState createState() => _SelectCreditCardState();
}

class _SelectCreditCardState extends State<SelectCreditCard> {
  final String creditCardUrl = "http://127.0.0.1:8100/transaction";
  List<String> creditCards = []; // Lista para almacenar las tarjetas de crédito
  int? _selectedIndex; // Cambiado para permitir deselección
  String graphQLQuery =
  ' query { creditCardByUser(id: 492 ) {number brand} }';
  @override
  void initState() {
    super.initState();
    fetchCreditCards(); // Llama a la función para obtener las tarjetas de crédito
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
          creditCards = cards.map((card) => "${card['brand']} - ${card['number']}").toList();
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
        title: Text('Select Credit Card'),
      ),
      body: ListView.builder(
        itemCount: creditCards.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            title: Text(creditCards[index]),
            value: _selectedIndex == index,
            onChanged: (value) {
              setState(() {
                _selectedIndex = value! ? index : null; // Actualiza el índice seleccionado
              });
            },
          );
        },
      ),
    );
  }
}
