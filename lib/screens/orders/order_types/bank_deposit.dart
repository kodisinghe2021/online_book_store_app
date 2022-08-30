import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_book_store_app/provider/order_provider.dart';
import 'package:online_book_store_app/screens/home/product_view_screen.dart';
import 'package:provider/provider.dart';

class BankDiposit extends StatelessWidget {
  const BankDiposit({Key? key}) : super(key: key);
  static const pageKey = '/bank-diposit-screen';
  // final OrderControllerNew _order = OrderControllerNew();
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Online Order'),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: screenSize.width,
          height: screenSize.height,
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 30),
                Text(
                  'සැ.යු : කරුණාකර පහත තොරතුරුවල \nscreenshot එකක් ලබාගන්න.',
                  style:
                      GoogleFonts.acme(fontSize: 20, color: Colors.redAccent),
                ),
                const SizedBox(height: 30),
                Text(
                  'ගිණුමට මුදල් බැර කර අදාළ රිසිට් පත පහත \n දක්වා ඇති වට්සැප් අංකයට යොමු කරන්න.',
                  style: GoogleFonts.acme(fontSize: 15),
                ),
                const SizedBox(height: 45),
                Text(
                  "ගිණුම් අංකය: 0520 202 70000\nනම: S.M.S. Madhuwanthi\nබැංකුව: HNB\nශාඛාව: හොරණ",
                  style: GoogleFonts.acme(fontSize: 19),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 25),
                Text(
                  'රිසිට්පත යොමු කලයුතු Whatsapp අංකය:',
                  style: GoogleFonts.acme(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                Text(
                  '076 03 29 219',
                  style: GoogleFonts.acme(fontSize: 25),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 25),
                ElevatedButton(
                  onPressed: () async {
                    await Provider.of<OrderProvider>(context, listen: false)
                        .saveOrderDetailsInFirebase();
                    CoolAlert.show(
                        context: context,
                        type: CoolAlertType.confirm,
                        title: 'Your Oder confirmed',
                        text: 'ඔබගේ ඇනවුම යොමු කර ඇත.',
                        onConfirmBtnTap: () async {
                          Navigator.pushReplacementNamed(
                              context, ProductViewScreen.pageKey);
                        });
                    // Provider.of<OrderProvider>(context, listen: false)
                    //     .saveOrderDetailsInFirebase();
                  },
                  child: const Text('Continue'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
