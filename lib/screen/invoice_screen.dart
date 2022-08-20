import 'dart:developer';

import 'package:auto_car/database/sqldb.dart';
import 'package:auto_car/debugger/my_debuger.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:overlay_support/overlay_support.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

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

  late AnimationController controller;
  final _zibCodeController = TextEditingController();
  final _carColorController = TextEditingController();
  final _localController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _numerCarsController = TextEditingController();

  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;
  bool _isLoading = false;
  bool isSearch = false;

  List<Map> listUserData = [];

  final ImagePicker _picker = ImagePicker();
  File? _storedImage;

  int? _value = 2;

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
      _numerCarsController.text = listUserData[0]['country'];
      _carColorController.text = listUserData[0]['city'];
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

  Future<void> takeImageFromGallery() async {
    final imageFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    if (imageFile == null) {
      return;
    }
    setState(() {
      _storedImage = File(imageFile.path);
    });
  }

  sendEmail({required String body, required String title}) async {
    String data =
        '<html><body><style>table, th, td {border: 1px solid black;border-collapse: collapse;}</style><table style="width:100%"><tr><th>${_nameController.text}</th> <th>اسم العميل</th></tr><tr><th>${_emailController.text}</th> <th>ايميل العميل</th></tr><tr><th>${_phoneController.text}</th> <th>رقم الهاتف</th><tr><th>${widget.carName}</th> <th>اسم السيارة</th></tr></tr><tr><tr><th>${widget.carPrice}</th> <th>سعر السيارة</th></tr><tr><th>${_numerCarsController.text}</th> <th>عدد السيارات</th></tr><tr><th>${_carColorController.text}</th> <th>لون السيارة</th></tr><tr><th>${_value == 1 ? "لا" : "نعم"}</th> <th>شحن السيارة</th></tr></table></body></html>';

    setState(() {
      _isLoading = true;
    });

    String username = "username@c-pinal.com";
    String password = "password";
    final smtpServer = new SmtpServer("domin.com",
        username: username, password: password, port: 465, ssl: true);

    final message = Message()
      ..from = Address(username, AppConfig.appName)
      ..recipients.add('batagroup.info@gmail.com')
      //..recipients.add('yasser8351@gmail.com')
      ..subject = AppConfig.invoice
      ..attachments.add(FileAttachment(_storedImage!))
      ..text = data
      ..html = data;

    try {
      await send(message, smtpServer);
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context)
          .push(MaterialPageRoute(builder: ((context) => CompletSend())));
    } on MailerException {
      setState(
        () {
          _isLoading = false;
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
                                        inputType: TextInputType.text,
                                      ),
                                      const SizedBox(
                                        height: 16.0,
                                      ),
                                      _buildTextfield(
                                        label: AppConfig.phone,
                                        controller: _phoneController,
                                        obscure: false,
                                        inputType: TextInputType.number,
                                      ),
                                      const SizedBox(
                                        height: 16.0,
                                      ),
                                      _buildTextfield(
                                        label: AppConfig.email,
                                        controller: _emailController,
                                        obscure: false,
                                        inputType: TextInputType.text,
                                      ),
                                      const SizedBox(
                                        height: 16.0,
                                      ),
                                      _buildTextfield(
                                        label: AppConfig.numberOfCar,
                                        controller: _numerCarsController,
                                        obscure: false,
                                        inputType: TextInputType.number,
                                      ),
                                      const SizedBox(
                                        height: 16.0,
                                      ),
                                      _buildTextfield(
                                        label: AppConfig.carColor,
                                        controller: _carColorController,
                                        obscure: false,
                                        inputType: TextInputType.text,
                                      ),
                                      const SizedBox(
                                        height: 30.0,
                                      ),
                                      _buildRadioButton(),
                                      const SizedBox(
                                        height: 30.0,
                                      ),
                                      Text(
                                        AppConfig.uploadId,
                                        style: AppStyle.textBlack20,
                                        textAlign: TextAlign.right,
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          await takeImageFromGallery();
                                        },
                                        child: _storedImage == null
                                            ? Container(
                                                width: size.width,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: Colors.black),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Image.asset(
                                                  AppConfig.placeholder2,
                                                  width: size.width * .3,
                                                  height: size.width * .4,
                                                ),
                                              )
                                            : ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                child: Image.file(
                                                  _storedImage!,
                                                  width: 100,
                                                  height: 100,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                      ),
                                      const SizedBox(
                                        height: 30.0,
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
                                                if (_storedImage == null) {
                                                  toast(AppConfig
                                                      .selectTheImageId);
                                                  return;
                                                }
                                                if (_nameController
                                                        .text.isEmpty ||
                                                    _phoneController
                                                        .text.isEmpty ||
                                                    _emailController
                                                        .text.isEmpty ||
                                                    _carColorController
                                                        .text.isEmpty ||
                                                    _numerCarsController
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
                                                    _numerCarsController.text,
                                                    _carColorController.text,
                                                    _localController.text,
                                                    _zibCodeController.text,
                                                  );

                                                  sendEmail(
                                                      title: AppConfig.appName,
                                                      body: _numerCarsController
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
    );
  }

  _buildTextfield({
    required TextEditingController controller,
    required String label,
    required bool obscure,
    required TextInputType inputType,
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
            keyboardType: inputType,
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

  _buildRadioButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(children: [
          Row(
            children: [
              Radio<int>(
                  value: 1,
                  groupValue: _value,
                  onChanged: (value) {
                    setState(() {
                      _value = value;
                    });
                  }),
              Text(
                'لا',
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            ],
          ),
          Row(
            children: [
              Radio<int>(
                  value: 2,
                  groupValue: _value,
                  onChanged: (value) {
                    setState(() {
                      _value = value;
                    });
                  }),
              Text(
                'نعم',
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            ],
          )
        ]),
        Text(
          AppConfig.chargeCar,
          style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 20,
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
