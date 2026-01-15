import 'package:e_commerce_app/orderconfirmation_scree.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayPage extends StatefulWidget {
  final int totalAmount;
  final List<Map<String, dynamic>> cartItem;
  final int amount;
  const RazorpayPage({
    super.key,
    required this.totalAmount,
    required this.amount,
    required this.cartItem,
  });

  @override
  State<RazorpayPage> createState() => _RazorpayPayState();
}

class _RazorpayPayState extends State<RazorpayPage> {
  late Razorpay _razorpay;
  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);

    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);

    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void openCheckout() {
    var options = {
      'key': 'rzp_test_RMVWvo07mmCbDK',
      'amount': widget.amount * 100,
      'name': 'Fashion Store',
      'description': 'Order payment',
      'prefill': {'contact': '9876543210', 'email': 'test@gmail.com'},
      'external': {
        'wallet': ['paytm'],
      },
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error:$e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyOrderConfirmationPage(
          cartItem: widget.cartItem,
          totalAmount: widget.totalAmount,
          paymentId: response.paymentId??"",
        ),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Payment Succesful:${response.paymentId}")),
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Paymenrt failed")));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Wallet:${response.walletName}")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator()
      ),
    );
  }
}
