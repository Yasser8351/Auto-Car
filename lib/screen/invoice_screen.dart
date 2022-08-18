import 'dart:developer';

import 'package:auto_car/database/sqldb.dart';
import 'package:auto_car/debugger/my_debuger.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:overlay_support/overlay_support.dart';

import '../config/app_config.dart';

import '../config/app_style.dart';
import '../widget/button_boarder.dart';
import 'complet_send.dart';

class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({
    Key? key,
    required this.carPrice,
    required this.carName,
  }) : super(key: key);
  final carPrice;
  final carName;

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen>
    with TickerProviderStateMixin {
  SQLDatabase sqlDatabase = SQLDatabase();
  final _zibCodeController = TextEditingController();
  final _emailController = TextEditingController();
  final _cityController = TextEditingController();
  final _localController = TextEditingController();
  final _phoneController = TextEditingController();
  final _countryController = TextEditingController();
  final _nameController = TextEditingController();

  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;

  bool _isLoading = false;
  bool _isSend = false;

  bool isSearch = false;

  late AnimationController controller;

  List<Map> listUserData = [];

  @override
  void initState() {
    getDataFromSqfLite();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> getDataFromSqfLite() async {
    listUserData = await sqlDatabase.getData("SELECT * FROM 'Invoice'");

    if (listUserData.length == 0) {
    } else {
      _nameController.text = listUserData[0]['name'];
      _emailController.text = listUserData[0]['email'];
      _phoneController.text = listUserData[0]['phone'];
      _countryController.text = listUserData[0]['country'];
      _cityController.text = listUserData[0]['city'];
      _localController.text = listUserData[0]['local'];
      _zibCodeController.text = listUserData[0]['zibCode'];
    }

    setState(() {
      myLogs("listUserData", listUserData.length);
    });
  }

  void insertData(String? name, String? phone, String? email, String? country,
      String? city, String? local, String? zibCode) {
    sqlDatabase
        .insertData(
          "INSERT INTO 'Invoice' ('name','phone','email','country','city','local','zibCode') VALUES ('$name','$phone','$email' ,'$country','$city','$local','$zibCode')",
        )
        .then(
          (value) => {log(value.toString())},
        );
  }

/*
  sendEmail({required String body, required String title}) async {
    // String username = 'infomsc33@gmail.com';
    String username = 'infomsc33@gmail.com';
    String password = '123yasserMsc8';

    // try {
    //   final Email email = Email(
    //     body: 'Email body',
    //     subject: 'Email subject',
    //     recipients: ['yassermsc8@gmail.com'],
    //     //cc: ['cc@example.com'],
    //     //bcc: ['bcc@example.com'],
    //     attachmentPaths: ['/path/to/attachment.zip'],
    //     isHTML: false,
    //   );

    //   await FlutterEmailSender.send(email);
    // } catch (e) {
    //   myLog("Expation", e.toString());
    // }
  }
*/
  sendEmail({required String body, required String title}) async {
    String data =
        '<html><body><style>table, th, td {border: 1px solid black;border-collapse: collapse;}</style><table style="width:100%"><tr><th>${_nameController.text}</th> <th>اسم العميل</th></tr><tr><th>${_emailController.text}</th> <th>ايميل العميل</th></tr><tr><th>${_phoneController.text}</th> <th>رقم الهاتف</th><tr><th>${widget.carName}</th> <th>اسم السيارة</th></tr></tr><tr><tr><th>${widget.carPrice}</th> <th>سعر السيارة</th></tr></table></body></html>';

    setState(() {
      _isLoading = true;
    });

    String username = "username@c-pinal.com";
    String password = "password";

    final smtpServer = new SmtpServer("domin.com",
        username: username, password: password, port: 465, ssl: true);

    final message = Message()
      ..from = Address(username, AppConfig.appName)
      ..recipients.add('yasser8351@gmail.com')
      ..subject = AppConfig.invoice
      ..text = data
      ..html = data;

    try {
      await send(message, smtpServer);
      setState(() {
        _isLoading = false;
        _isSend = true;
      });
      Navigator.of(context)
          .push(MaterialPageRoute(builder: ((context) => CompletSend())));
    } on MailerException {
      setState(
        () {
          _isLoading = false;
          _isSend = false;
        },
      );

      toastMessage(AppConfig.notsendemail);
    }
  }

  void toastMessage(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.black,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: _pinned,
            snap: _snap,
            floating: _floating,
            expandedHeight: 100.0,
            backgroundColor: Colors.white,
            flexibleSpace: Padding(
              padding: EdgeInsets.only(top: size.width * .11),
              child: FlexibleSpaceBar(
                title: Image.asset(
                  AppConfig.autoCarLogo,
                  height: 50,
                  width: size.width * .46,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return SingleChildScrollView(
                  child: Container(
                      color: index.isOdd ? Colors.white : Colors.black12,
                      //height: 100.0,
                      child: Container(
                          width: double.infinity,
                          color: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Theme(
                              data: ThemeData(
                                primaryColor: Colors.black,
                                primaryColorDark: Colors.black,
                                focusColor: Colors.black,
                                colorScheme: const ColorScheme(
                                  primary: Colors.black,
                                  onPrimary: Colors.black,
                                  secondary: Colors.black,
                                  onSecondary: Colors.white,
                                  brightness: Brightness.light,
                                  background: Colors.black,
                                  onBackground: Colors.black,
                                  error: Colors.black,
                                  onError: Colors.black,
                                  surface: Colors.black,
                                  onSurface: Colors.black,
                                ),
                              ),
                              child: Column(children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 10),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      _buildTextfield(
                                        label: AppConfig.name,
                                        controller: _nameController,
                                        obscure: false,
                                      ),
                                      const SizedBox(
                                        height: 16.0,
                                      ),
                                      _buildTextfield(
                                        label: AppConfig.phone,
                                        controller: _phoneController,
                                        obscure: false,
                                      ),
                                      const SizedBox(
                                        height: 16.0,
                                      ),
                                      _buildTextfield(
                                        label: AppConfig.email,
                                        controller: _emailController,
                                        obscure: false,
                                      ),
                                      const SizedBox(
                                        height: 16.0,
                                      ),
                                      _buildTextfield(
                                        label: AppConfig.country,
                                        controller: _countryController,
                                        obscure: false,
                                      ),
                                      const SizedBox(
                                        height: 16.0,
                                      ),
                                      _buildTextfield(
                                        label: AppConfig.city,
                                        controller: _cityController,
                                        obscure: false,
                                      ),
                                      const SizedBox(
                                        height: 16.0,
                                      ),
                                      _buildTextfield(
                                        label: AppConfig.local,
                                        controller: _localController,
                                        obscure: false,
                                      ),
                                      const SizedBox(
                                        height: 16.0,
                                      ),
                                      _buildTextfield(
                                        label: AppConfig.zibCode,
                                        controller: _zibCodeController,
                                        obscure: false,
                                      ),
                                      const SizedBox(
                                        height: 30.0,
                                      ),
                                      Text(
                                        AppConfig.invoiceNote,
                                        style: AppStyle.textBlack18,
                                        textAlign: TextAlign.right,
                                      ),
                                      const SizedBox(
                                        height: 50.0,
                                      ),
                                      _isLoading
                                          ? Center(
                                              child:
                                                  CircularProgressIndicator())
                                          : BorderButtonCustom(
                                              title: AppConfig.sendInvoice,
                                              color: Colors.red,
                                              icon: Icons.send,
                                              onTap: () {
                                                if (_emailController
                                                        .text.isEmpty ||
                                                    _zibCodeController
                                                        .text.isEmpty ||
                                                    _countryController
                                                        .text.isEmpty) {
                                                  toast(AppConfig
                                                      .allFieldsrequired);
                                                } else {
                                                  // if (listUserData.length !=
                                                  //     0)
                                                  insertData(
                                                    _nameController.text,
                                                    _phoneController.text,
                                                    _emailController.text,
                                                    _countryController.text,
                                                    _cityController.text,
                                                    _localController.text,
                                                    _zibCodeController.text,
                                                  );

                                                  sendEmail(
                                                      title: AppConfig.appName,
                                                      body: _countryController
                                                          .text);
                                                }
                                              },
                                            ),
                                    ],
                                  ),
                                )
                              ])))),
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),

      /*  
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Theme(
            data: ThemeData(
              primaryColor: Colors.black,
              primaryColorDark: Colors.black,
              focusColor: Colors.black,
              colorScheme: const ColorScheme(
                primary: Colors.black,
                onPrimary: Colors.black,
                secondary: Colors.black,
                onSecondary: Colors.white,
                brightness: Brightness.light,
                background: Colors.black,
                onBackground: Colors.black,
                error: Colors.black,
                onError: Colors.black,
                surface: Colors.black,
                onSurface: Colors.black,
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildTextfield(
                        label: AppConfig.name,
                        controller: _emailController,
                        obscure: false,
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      _buildTextfield(
                        label: AppConfig.phone,
                        controller: _phoneController,
                        obscure: false,
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      _buildTextfield(
                        label: AppConfig.email,
                        controller: _emailController,
                        obscure: false,
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      _buildTextfield(
                        label: AppConfig.country,
                        controller: _countryController,
                        obscure: false,
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      _buildTextfield(
                        label: AppConfig.city,
                        controller: _cityController,
                        obscure: false,
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      _buildTextfield(
                        label: AppConfig.local,
                        controller: _localController,
                        obscure: false,
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      _buildTextfield(
                        label: AppConfig.zibCode,
                        controller: _zibCodeController,
                        obscure: false,
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Text(
                        AppConfig.invoiceNote,
                        style: AppStyle.textBlack18,
                        textAlign: TextAlign.right,
                      ),
                      const SizedBox(
                        height: 50.0,
                      ),
                      _isLoading
                          ? Center(child: CircularProgressIndicator())
                          : BorderButtonCustom(
                              title: AppConfig.sendInvoice,
                              // backgroundColor: Colors.transparent,
                              //foregroundColor: Colors.red,
                              //borderColor: Color.fromARGB(255, 125, 96, 96),
                              color: Colors.red,
                              icon: Icons.send,
                              onTap: () {
                                if (_emailController.text.isEmpty ||
                                    _zibCodeController.text.isEmpty ||
                                    _countryController.text.isEmpty) {
                                  toast(AppConfig.allFieldsrequired);
                                  // ScaffoldMessenger.of(context).showSnackBar(
                                  //     SnackBar(
                                  //         content: Text(
                                  //             AppLocalizations.of(context)!
                                  //                 .fieldsrequired,)));
                                } else {
                                  sendEmail(
                                      title: _emailController.text,
                                      body: _countryController.text);
                                  // Navigator.of(context).push(MaterialPageRoute(
                                  //     builder: ((context) => CompletSend())));

                                  //stop
                                  // Navigator.of(context).push(MaterialPageRoute(
                                  //     builder: ((context) => CompletSend())));
                                }
                              },
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
  */
    );
  }

  _buildTextfield({
    required TextEditingController controller,
    required String label,
    required bool obscure,
  }) {
    return Material(
      elevation: 1,
      shadowColor: Colors.white30,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: TextField(
            keyboardType: TextInputType.text,
            obscureText: obscure,
            textAlign: TextAlign.right,
            decoration: InputDecoration(
                labelText: label,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                )),
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: 17,
            ),
            controller: controller,
          ),
        ),
      ),
    );
  }
}
