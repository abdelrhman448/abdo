import 'package:country_code_picker/country_code_picker.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:gender_selection/gender_selection.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:maosul/localization/localizationSetup/app_localization.dart';
import 'package:page_transition/page_transition.dart';
import 'package:phone_number/phone_number.dart';
import 'package:provider/provider.dart';
import 'package:sweetalert/sweetalert.dart';

import '../helper/app_styles.dart';
import '../provider/auth_provider.dart';
import '../provider/parse_result.dart';
import '../provider/store.dart';
import '../screens/login.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final nameController = new TextEditingController();
  final phoneController = new TextEditingController();
  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();
  final cPasswordController = new TextEditingController();
  final dateOfBirthController = new TextEditingController();
  String selectedGender;
  DateTime birthDate;
  bool isDateSelected;

  final regionCtrl = TextEditingController();
  final numberCtrl = TextEditingController();
  final store = Store(PhoneNumber());
  String dialCode;
  String regionCode;

  Future<ParseResult> parse() async {
    return await store.parse(phoneController.text, region: regionCode);
  }

  @override
  Widget build(BuildContext context) {
    var localization=AppLocalization.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0, right: 15, left: 15),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: GenderSelection(
                maleText: localization.translate('Male'),
                //default Male
                femaleText:  localization.translate('Female'),
                selectedGenderTextStyle: TextStyle(

                  fontSize: 20,
                ),
                unSelectedGenderTextStyle: TextStyle(

                  fontSize: 20,
                ),
                //default Female
                linearGradient: LinearGradient(
                  colors: [const Color(0xFF000744), const Color(0xFF00215C)],
                  tileMode: TileMode.clamp,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.0, 1.0],
                ),
                selectedGenderIconBackgroundColor: Color(0xFF00215C),
                // default red
                checkIconAlignment: Alignment.centerRight,
                // default bottomRight
                selectedGenderCheckIcon: Icons.check_circle_outline,
                selectedGenderIconColor: Colors.white,
                // default Icons.check
                onChanged: (Gender gender) {
                  print(gender);
                  if (gender == Gender.Male) {
                    selectedGender =  localization.translate('Male');
                    print(selectedGender);
                  } else {
                    selectedGender =  localization.translate('Female');
                    print(selectedGender);
                  }
                },
                equallyAligned: true,
                animationDuration: Duration(milliseconds: 400),
                isCircular: true,
                // default : true,
                isSelectedGenderIconCircular: true,
                opacityOfGradient: 0.2,
                padding: const EdgeInsets.all(3),
                size: 120, //default : 120
              ),
            ),

            SizedBox(height: 10),

            ///full name
            TextFormField(
              autofocus: false,
              keyboardType: TextInputType.text,
              controller: nameController,
              decoration: InputDecoration(
                labelText: localization.translate('Full name'),
                labelStyle: AppStyles.txtLabelStyle,
                hintStyle: AppStyles.txtHintStyle,
                prefixIcon: const Icon(
                  Icons.person,
                  color: Colors.grey,
                ),
                border: new OutlineInputBorder(
                  borderSide: new BorderSide(
                    color: Colors.teal,
                    width: 1.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.greenAccent,
                    width: 1.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),

            ///Date of birth
            TextFormField(
              onTap: () async {
                final datePick = await showDatePicker(
                    context: context,
                    initialDate: new DateTime.now(),
                    firstDate: new DateTime(1900),
                    lastDate: new DateTime(2100));
                if (datePick != null && datePick != birthDate) {
                  setState(() {
                    birthDate = datePick;
                    isDateSelected = true;
                    dateOfBirthController.text =
                        "${birthDate.year}-${birthDate.month}-${birthDate.day}";
                  });
                }
              },
              autofocus: false,
              keyboardType: TextInputType.datetime,
              readOnly: true,
              controller: dateOfBirthController,
              decoration: InputDecoration(
                labelText: localization.translate('Date of birth'),
                labelStyle: AppStyles.txtLabelStyle,
                hintStyle: AppStyles.txtHintStyle,
                prefixIcon: const Icon(
                  Icons.date_range_sharp,
                  color: Colors.grey,
                ),
                border: new OutlineInputBorder(
                  borderSide: new BorderSide(
                    color: Colors.teal,
                    width: 1.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.greenAccent,
                    width: 1.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),

            ///mobile number
            TextFormField(
              autofocus: false,
              keyboardType: TextInputType.phone,
              controller: phoneController,
              decoration: InputDecoration(
                labelText: localization.translate('Mobile Number'),
                labelStyle: AppStyles.txtLabelStyle,
                hintStyle: AppStyles.txtHintStyle,
                prefixIcon: const Icon(
                  Icons.phone_iphone,
                  color: Colors.grey,
                ),
                suffixIcon: CountryCodePicker(
                  onChanged: (code) {
                    setState(() {
                      dialCode = code.dialCode;
                      regionCode = code.code;
                    });
                  },
                  onInit: (code) {
                    dialCode = code.dialCode;
                    regionCode = code.code;
                  },
                  initialSelection: 'SD',
                  favorite: ['+249', 'SD'],
                  showCountryOnly: false,
                  showOnlyCountryWhenClosed: false,
                  alignLeft: false,
                  textOverflow: TextOverflow.clip,
                  flagWidth: 30,
                  showFlagDialog: true,
                  showFlag: false,
                  textStyle: TextStyle(
                    fontSize: 12.0,
                    locale: Locale('en.json'),
                  ),
                  dialogTextStyle: TextStyle(
                    fontSize: 12.0,
                    locale: Locale('en.json'),
                  ),
                  searchStyle: TextStyle(
                    fontSize: 12.0,
                    locale: Locale('en.json'),
                  ),
                ),
                border: new OutlineInputBorder(
                  borderSide: new BorderSide(
                    color: Colors.teal,
                    width: 1.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.greenAccent,
                    width: 1.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),

            ///email address
            TextFormField(
              autofocus: false,
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              decoration: InputDecoration(
                labelText: localization.translate('Email Address'),
                labelStyle: AppStyles.txtLabelStyle,
                hintStyle: AppStyles.txtHintStyle,
                prefixIcon: const Icon(
                  Icons.email,
                  color: Colors.grey,
                ),
                border: new OutlineInputBorder(
                  borderSide: new BorderSide(
                    color: Colors.teal,
                    width: 1.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.greenAccent,
                    width: 1.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),

            ///password
            TextFormField(
              autofocus: false,
              keyboardType: TextInputType.text,
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: localization.translate('Password'),
                labelStyle: AppStyles.txtLabelStyle,
                hintStyle: AppStyles.txtHintStyle,
                prefixIcon: const Icon(
                  Icons.lock,
                  color: Colors.grey,
                ),
                border: new OutlineInputBorder(
                  borderSide: new BorderSide(
                    color: Colors.teal,
                    width: 1.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.greenAccent,
                    width: 1.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),

            ///confirm password
            TextFormField(
              autofocus: false,
              keyboardType: TextInputType.text,
              controller: cPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: localization.translate('Confirm password'),
                labelStyle: AppStyles.txtLabelStyle,
                hintStyle: AppStyles.txtHintStyle,
                prefixIcon: const Icon(
                  Icons.lock,
                  color: Colors.grey,
                ),
                border: new OutlineInputBorder(
                  borderSide: new BorderSide(
                    color: Colors.teal,
                    width: 1.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.greenAccent,
                    width: 1.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 100,
                  child: FlatButton(
                    textColor: AppStyles.lineColor(1),
                    color: Colors.transparent,
                    child: Text(
                      localization.translate('Login'),
                      style: TextStyle(

                      ),
                    ),
                    onPressed: () async {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.scale,
                          duration: Duration(
                            seconds: 0,
                            milliseconds: 700,
                          ),
                          alignment: Alignment.center,
                          child: Login(),
                        ),
                      );
                    },
                  ),
                ),
                // Container(
                //   child: CustomButton(
                //     text: "تسجيل",
                //     onPressed: () async {
                //       if (nameController.text.isEmpty) {
                //         SweetAlert.show(
                //           context,
                //           subtitle: "عفواً يرجى إدخال الإسم الكامل",
                //           confirmButtonText: "موافق",
                //           style: SweetAlertStyle.error,
                //           confirmButtonColor: AppStyles.lineColor(1),
                //         );
                //       } else if (phoneController.text.isEmpty) {
                //         SweetAlert.show(
                //           context,
                //           subtitle: "عفواً يرجى إدخال رقم الهاتف",
                //           confirmButtonText: "موافق",
                //           style: SweetAlertStyle.error,
                //           confirmButtonColor: AppStyles.lineColor(1),
                //         );
                //       } else if (phoneController.text.length < 10) {
                //         SweetAlert.show(
                //           context,
                //           subtitle: "عفواً يجب ألا يقل رقم الهاتف من 10 أحرف",
                //           confirmButtonText: "موافق",
                //           style: SweetAlertStyle.error,
                //           confirmButtonColor: AppStyles.lineColor(1),
                //         );
                //       } else if (phoneController.text.length > 10) {
                //         SweetAlert.show(
                //           context,
                //           subtitle: "عفواً يجب ألا يزيد رقم الهاتف عن 10 أحرف",
                //           confirmButtonText: "موافق",
                //           style: SweetAlertStyle.error,
                //           confirmButtonColor: AppStyles.lineColor(1),
                //         );
                //       } else if (emailController.text.isEmpty) {
                //         SweetAlert.show(
                //           context,
                //           subtitle: "عفواً يرجى إدخال البريد الإلكتروني",
                //           confirmButtonText: "موافق",
                //           style: SweetAlertStyle.error,
                //           confirmButtonColor: AppStyles.lineColor(1),
                //         );
                //       } else if (!EmailValidator.validate(emailController.text)) {
                //         SweetAlert.show(
                //           context,
                //           subtitle: "عفواً يرجى إدخال بريد إلكتروني صحيح",
                //           confirmButtonText: "موافق",
                //           style: SweetAlertStyle.error,
                //           confirmButtonColor: AppStyles.lineColor(1),
                //         );
                //       } else if (passwordController.text.isEmpty) {
                //         SweetAlert.show(
                //           context,
                //           subtitle: "عفواً يرجى إدخال كلمة المرور",
                //           confirmButtonText: "موافق",
                //           style: SweetAlertStyle.error,
                //           confirmButtonColor: AppStyles.lineColor(1),
                //         );
                //       } else if (passwordController.text.length < 6) {
                //         SweetAlert.show(
                //           context,
                //           subtitle: "عفواً كلمة المرور قصيرة جداً",
                //           confirmButtonText: "موافق",
                //           style: SweetAlertStyle.error,
                //           confirmButtonColor: AppStyles.lineColor(1),
                //         );
                //       } else if (cPasswordController.text !=
                //           passwordController.text) {
                //         SweetAlert.show(
                //           context,
                //           subtitle: "عفواً كلمة المرور غير متطابقة",
                //           confirmButtonText: "موافق",
                //           style: SweetAlertStyle.error,
                //           confirmButtonColor: AppStyles.lineColor(1),
                //         );
                //       } else {
                //         parse().then((phone) {
                //           Provider.of<AuthProvider>(context, listen: false)
                //               .register(
                //             scaffoldKey: _scaffoldKey,
                //             name: nameController.text,
                //             phone: phone.e164,
                //             email: emailController.text,
                //             password: passwordController.text,
                //             cPassword: cPasswordController.text,
                //             gender: 'male',
                //             birthDate: '1993/1/1',
                //           );
                //         });
                //       }
                //     },
                //   ),
                // ),
                Container(
                  width: 100,
                  child: FlatButton(
                    textColor: AppStyles.lineColor(1),
                    color: Colors.transparent,
                    child: Text(
                      localization.translate('Sign Up'),
                      style: TextStyle(

                      ),
                    ),
                    onPressed: () async {
                      if (selectedGender?.isEmpty ?? true) {
                        SweetAlert.show(
                          context,
                          subtitle: localization.translate('Please specify the gender'),
                          confirmButtonText: localization.translate('Accept'),
                          style: SweetAlertStyle.error,
                          confirmButtonColor: AppStyles.lineColor(1),
                        );
                      } else if (nameController.text.isEmpty) {
                        SweetAlert.show(
                          context,
                          subtitle: localization.translate('please enter your full name'),
                          confirmButtonText: localization.translate('Accept'),
                          style: SweetAlertStyle.error,
                          confirmButtonColor: AppStyles.lineColor(1),
                        );
                      } else if (dateOfBirthController.text.isEmpty) {
                        SweetAlert.show(
                          context,
                          subtitle: localization.translate('please enter your date of birth'),
                          confirmButtonText: localization.translate('Accept'),
                          style: SweetAlertStyle.error,
                          confirmButtonColor: AppStyles.lineColor(1),
                        );
                      } else if (phoneController.text.isEmpty) {
                        SweetAlert.show(
                          context,
                          subtitle:localization.translate('please enter your phone number'),
                          confirmButtonText:localization.translate('Accept'),
                          style: SweetAlertStyle.error,
                          confirmButtonColor: AppStyles.lineColor(1),
                        );
                      } else if (phoneController.text.length < 10) {
                        SweetAlert.show(
                          context,
                          subtitle: localization.translate('The phone number must not be less than 10 characters'),
                          confirmButtonText:localization.translate('Accept'),
                          style: SweetAlertStyle.error,
                          confirmButtonColor: AppStyles.lineColor(1),
                        );
                      } else if (phoneController.text.length > 10) {
                        SweetAlert.show(
                          context,
                          subtitle:  localization.translate('The phone number must not be more than 10 characters'),
                          confirmButtonText: localization.translate('Accept'),
                          style: SweetAlertStyle.error,
                          confirmButtonColor: AppStyles.lineColor(1),
                        );
                      } else if (emailController.text.isEmpty) {
                        SweetAlert.show(
                          context,
                          subtitle: localization.translate('please enter your email'),
                          confirmButtonText:localization.translate('Accept'),
                          style: SweetAlertStyle.error,
                          confirmButtonColor: AppStyles.lineColor(1),
                        );
                      } else if (!EmailValidator.validate(
                          emailController.text)) {
                        SweetAlert.show(
                          context,
                          subtitle: localization.translate('please enter a valid email'),
                          confirmButtonText: localization.translate('Accept'),
                          style: SweetAlertStyle.error,
                          confirmButtonColor: AppStyles.lineColor(1),
                        );
                      } else if (passwordController.text.isEmpty) {
                        SweetAlert.show(
                          context,
                          subtitle: localization.translate('please enter your password'),
                          confirmButtonText:localization.translate('Accept'),
                          style: SweetAlertStyle.error,
                          confirmButtonColor: AppStyles.lineColor(1),
                        );
                      } else if (passwordController.text.length < 6) {
                        SweetAlert.show(
                          context,
                          subtitle: localization.translate('The password is too short'),
                          confirmButtonText: localization.translate('Accept'),
                          style: SweetAlertStyle.error,
                          confirmButtonColor: AppStyles.lineColor(1),
                        );
                      } else if (cPasswordController.text !=
                          passwordController.text) {
                        SweetAlert.show(
                          context,
                          subtitle: localization.translate('the password does not match'),
                          confirmButtonText:localization.translate('Accept'),
                          style: SweetAlertStyle.error,
                          confirmButtonColor: AppStyles.lineColor(1),
                        );
                      } else {
                        parse().then((phone) {
                          Provider.of<AuthProvider>(context, listen: false).register(
                            scaffoldKey: _scaffoldKey,
                            name: nameController.text,
                            phone: phone.e164,
                            email: emailController.text,
                            password: passwordController.text,
                            cPassword: cPasswordController.text,
                            gender: selectedGender,
                            birthDate: dateOfBirthController.text,
                          );
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
