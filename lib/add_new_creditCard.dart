import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';



const double defaultPadding = 16.0;

class AddNewCardScreen extends StatefulWidget {
  @override
  const AddNewCardScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddNewCardScreenState();
}

class _AddNewCardScreenState extends State<AddNewCardScreen> {
  String cardNumber='';
  String expiryDate='';
  String cardHolderName='';
  String cvvCode='';
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
              obscureCardCvv: true,),
            Expanded(
              child: SingleChildScrollView(
                child:Column(
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
                          print('valid!');
                        } else {
                          print('invalid!');
                        }
                      },
                      )
                    
                  ],
                )
              )),
          ],
        ),
      ),

    );
  }
  void onCreditCardModelChange(CreditCardModel creditCardModel){
    setState(() {
     cardNumber=creditCardModel.cardNumber;
     expiryDate=creditCardModel.expiryDate;
     cardHolderName=creditCardModel.cardHolderName;
     cvvCode=creditCardModel.cvvCode;
     isCvvFocused=creditCardModel.isCvvFocused;

    });
  }
}
