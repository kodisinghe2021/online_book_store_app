import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:online_book_store_app/enums.dart';
import 'package:online_book_store_app/controllers/orders_controller.dart';
import 'package:online_book_store_app/models/user_modal.dart';
import 'package:online_book_store_app/provider/user_auth_controller.dart';
import 'package:online_book_store_app/screens/orders/order_types/bank_deposit.dart';
import 'package:online_book_store_app/screens/orders/order_types/online_payment.dart';
import 'package:online_book_store_app/widget/custom_text_field.dart';
import 'package:provider/provider.dart';

class OrdersConfirmScreen extends StatefulWidget {
  const OrdersConfirmScreen({Key? key}) : super(key: key);
  static const pageKey = '/order-confirmation-screen';

  @override
  State<OrdersConfirmScreen> createState() => _OrdersConfirmScreenState();
}

class _OrdersConfirmScreenState extends State<OrdersConfirmScreen> {
//############################################################################//
  late UserModal? userData;
//############################################################################//
  bool _isOrderProccessing = false;
//############################################################################//
  String _userID = '';
  String _name = '';
  String _nic = '';
  String _address = '';
  String _con1 = '';
  String _con2 = '';
//############################################################################//
  @override
  void initState() {
    _checkUser();
    super.initState();
  }

//############################################################################//
  Future<void> _checkUser() async {
    Logger().w('inside check user');
    userData =
        Provider.of<UserAuthController>(context, listen: false).getUserData;
    if (userData != null) {
      Logger().i('_checkUser() true ');
      Logger()
          .i('user modal is correctly assign: userID: ${userData!.userId} ');
      Logger().i('user modal is correctly assign: userID: ${userData!.name} ');
      _userID = userData!.userId;
      _name = userData!.name;
      _nic = userData!.nic;
      _address = userData!.address;
      _con1 = userData!.contact01;
      _con2 = userData!.contact02;
      Logger()
          .i('values are assign to globle variables --> user ID : $_userID');
    }
  }

//############################################################################//

//############################################################################//
  final TextEditingController _nameField = TextEditingController();

  final TextEditingController _nicField = TextEditingController();

  final TextEditingController _deleveryAddressField = TextEditingController();

  final TextEditingController _contact_01Field = TextEditingController();

  final TextEditingController _contact_02Field = TextEditingController();

  final OrderController _order = OrderController();

//############################################################################//
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Order Confirmation'),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Stack(
            children: [
              SizedBox(
                width: screenSize.width,
                height: screenSize.height * 0.9,
                child: _userID.isNotEmpty
                    ? UserDetailsView(
                        name: _name,
                        nic: _nic,
                        address: _address,
                        con1: _con1,
                        con2: _con2)
                    : UserForm(
                        screenSize: screenSize,
                        nameField: _nameField,
                        nicField: _nicField,
                        deleveryAddressField: _deleveryAddressField,
                        contact_01Field: _contact_01Field,
                        contact_02Field: _contact_02Field,
                      ),
              ),
              //############################################################################//
              Positioned(
                bottom: 30,
                left: 40,
                right: 40,
                child: SizedBox(
                  width: screenSize.width * 0.5,
                  height: 40,
                  child: _isOrderProccessing
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          child: Text(
                            'Send Order',
                            style: GoogleFonts.acme(fontSize: 20),
                          ),
                          onPressed: () async {
                            setState(() {
                              _isOrderProccessing = true;
                            });
                            //^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^//
                            if (_userID.isEmpty) {
                              Logger().i(
                                  'inside of condition -->the user is empty');
                              await _order.addOrderData(
                                context,
                                _nameField.text,
                                _nicField.text,
                                _deleveryAddressField.text,
                                _contact_01Field.text,
                                _contact_02Field.text,
                              );
                              Logger()
                                  .i('${_nameField.text}, ${_nicField.text}');
                            } else {
                              Logger().i(
                                  'inside of condition -->the user Available');
                              await _order.addOrderData(
                                context,
                                _name,
                                _nic,
                                _address,
                                _con1,
                                _con2,
                              );
                              Logger().i('$_name, $_nic');
                            }
                            setState(() {
                              _isOrderProccessing = false;
                            });
                            showAlert(context);
                            //^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^//
                          },
                        ),
                ),
              ),
//############################################################################//
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showAlert(BuildContext context) async => showDialog(
        context: context,
        builder: (BuildContext cotext) => AlertDialog(
          title: const Text('ඇනවුම සදහා ගෙවීම් සිදු කරන මාද්‍ය තෝරන්න '),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.popAndPushNamed(context, OnlinePayment.pageKey);
                },
                child: const Text('Online Payment'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.popAndPushNamed(context, BankDiposit.pageKey);
                },
                child: const Text('Bank Diposit'),
              ),
            ],
          ),
        ),
      );
}

class UserForm extends StatelessWidget {
  const UserForm({
    Key? key,
    required this.screenSize,
    required TextEditingController nameField,
    required TextEditingController nicField,
    required TextEditingController deleveryAddressField,
    required TextEditingController contact_01Field,
    required TextEditingController contact_02Field,
  })  : _nameField = nameField,
        _nicField = nicField,
        _deleveryAddressField = deleveryAddressField,
        _contact_01Field = contact_01Field,
        _contact_02Field = contact_02Field,
        super(key: key);

  final Size screenSize;
  final TextEditingController _nameField;
  final TextEditingController _nicField;
  final TextEditingController _deleveryAddressField;
  final TextEditingController _contact_01Field;
  final TextEditingController _contact_02Field;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //############################################################################//
        CustomTextField(
          screenSize: screenSize,
          controller: _nameField,
          label: EnumVariables.name,
          prefixIcon: const Icon(Icons.person),
        ),
        const SizedBox(height: 10),
        CustomTextField(
          screenSize: screenSize,
          controller: _nicField,
          label: EnumVariables.nic,
          prefixIcon: const Icon(Icons.perm_identity_sharp),
        ),
        const SizedBox(height: 10),
        CustomTextField(
          screenSize: screenSize,
          controller: _deleveryAddressField,
          label: EnumVariables.deleveryAddress,
          prefixIcon: const Icon(Icons.location_on),
        ),
        const SizedBox(height: 10),
        CustomTextField(
          screenSize: screenSize,
          controller: _contact_01Field,
          label: '${EnumVariables.mobile} 01',
          prefixIcon: const Icon(Icons.phone),
        ),
        const SizedBox(height: 10),
        CustomTextField(
          screenSize: screenSize,
          controller: _contact_02Field,
          label: '${EnumVariables.mobile} 02',
          prefixIcon: const Icon(Icons.phone_android),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class UserDetailsView extends StatelessWidget {
  const UserDetailsView({
    Key? key,
    required this.name,
    required this.nic,
    required this.address,
    required this.con1,
    required this.con2,
  }) : super(key: key);

  final String name;
  final String nic;
  final String address;
  final String con1;
  final String con2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CList(title: 'Name', subtitle: name),
          const Divider(),
          CList(title: 'NIC', subtitle: nic),
          const Divider(),
          CList(title: 'Address', subtitle: address),
          const Divider(),
          CList(title: 'Contact 01', subtitle: con1),
          const Divider(),
          CList(title: 'Contact 02', subtitle: con2),
          const Divider(),
        ],
      ),
    );
  }
}

class CList extends StatelessWidget {
  const CList({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: GoogleFonts.acme(fontSize: 20),
      ),
      subtitle: Text(
        subtitle,
        style: GoogleFonts.acme(fontSize: 15),
      ),
    );
  }
}
