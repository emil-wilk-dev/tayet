// import 'package:flutter/material.dart';
// import 'package:flutter_braintree/flutter_braintree.dart';
// import 'package:get/get.dart';

// class PaymentPage extends StatelessWidget{

// static final String tokenizationKey = 'sandbox_8hxpnkht_kzdtzv2btm4p7s5j';

//   void showNonce(BraintreePaymentMethodNonce nonce) {
//     showDialog(
//       context: Get.context!,
//       builder: (_) => AlertDialog(
//         title: Text('Payment method nonce:'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             Text('Nonce: ${nonce.nonce}'),
//             SizedBox(height: 16),
//             Text('Type label: ${nonce.typeLabel}'),
//             SizedBox(height: 16),
//             Text('Description: ${nonce.description}'),
//           ],
//         ),
//       ),
//     );
//   }
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Braintree example app'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             ElevatedButton(
//               onPressed: () async {
//                 var request = BraintreeDropInRequest(
//                   tokenizationKey: tokenizationKey,
//                   collectDeviceData: true,
//                   googlePaymentRequest: BraintreeGooglePaymentRequest(
//                     totalPrice: '4.20',
//                     currencyCode: 'USD',
//                     billingAddressRequired: false,
//                   ),
//                   paypalRequest: BraintreePayPalRequest(
//                     amount: '4.20',
//                     displayName: 'Example company',
//                   ),
//                   cardEnabled: true,
//                 );
//                 final result = await BraintreeDropIn.start(request);
//                 if (result != null) {
//                   showNonce(result.paymentMethodNonce);
//                 }
//               },
//               child: Text('LAUNCH NATIVE DROP-IN'),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 final request = BraintreeCreditCardRequest(
//                   cardNumber: '4111111111111111',
//                   expirationMonth: '12',
//                   expirationYear: '2021',
//                   cvv: '123',
//                 );
//                 final result = await Braintree.tokenizeCreditCard(
//                   tokenizationKey,
//                   request,
//                 );
//                 if (result != null) {
//                   showNonce(result);
//                 }
//               },
//               child: Text('TOKENIZE CREDIT CARD'),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 final request = BraintreePayPalRequest(
//                   billingAgreementDescription:
//                       'I hereby agree that flutter_braintree is great.',
//                   displayName: 'Your Company',
//                 );
//                 final result = await Braintree.requestPaypalNonce(
//                   tokenizationKey,
//                   request,
//                 );
//                 if (result != null) {
//                   showNonce(result);
//                 }
//               },
//               child: Text('PAYPAL VAULT FLOW'),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 final request = BraintreePayPalRequest(amount: '13.37');
//                 final result = await Braintree.requestPaypalNonce(
//                   tokenizationKey,
//                   request,
//                 );
//                 if (result != null) {
//                   showNonce(result);
//                 }
//               },
//               child: Text('PAYPAL CHECKOUT FLOW'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

// }