import 'package:flutter/material.dart';
import 'package:maosul/localization/localizationSetup/app_localization.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:typicons_flutter/typicons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../helper/app_styles.dart';
import '../provider/carts_provider.dart';
import '../screens/cart.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    var localization=AppLocalization.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
         localization.translate('Contact Us'),
          style: AppStyles.txtAppBarStyle,
        ),
        actions: <Widget>[
          Stack(
            children: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.scale,
                      duration: Duration(
                        seconds: 0,
                        milliseconds: 700,
                      ),
                      alignment: Alignment.center,
                      child: Cart(),
                    ),
                  );
                },
                icon: Icon(
                  Icons.shopping_cart,
                  color: AppStyles.mainColor(1),
                ),
              ),
              Positioned(
                right: 0,
                top: 5,
                child: Consumer<CartsProvider>(
                  builder: (ctx, cart, child) {
                    return Container(
                      padding: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 12,
                        minHeight: 12,
                      ),
                      child: Text(
                        '${cart.productsList.length}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: 3,
                padding: const EdgeInsets.only(top: 0, left: 12.0, right: 12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0.0),
                    bottomRight: Radius.circular(0.0),
                  ),
                  color: AppStyles.lineColor(1),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: ContactUsPage(
              logo: AssetImage('assets/images/drawer.png'),
              image: null,
              email: 'maosul@gmail.com',
              companyName: localization.translate('Maosul App'),
              tagLine: localization.translate('We reach you wherever you are, contact us now'),
              emailText: "البريد الإلكتروني",
              phoneNumberText: "رقم الهاتف",
              websiteText: "الموقع الإلكتروني",
              phoneNumber: '249913000262',
              facebookHandle: 'asimsharf',
              twitterHandle: "asimsharf",
              instagram: "asimsharf",
              githubUserName: "asimsharf",
              website: 'https://maosul.com',
              linkedinURL: "https://www.linkedin.com/in/asim-sharf",
              companyColor: AppStyles.mainColor(1),
              taglineColor: AppStyles.mainColor(1),
              textColor: AppStyles.mainColor(1),
              companyFontSize: 15,
              cardColor: null,
            ),
          ),
        ],
      ),
      bottomNavigationBar: ContactUsBottomAppBar(
        companyName: 'شركة سوداغورث',
        textColor: Colors.white,
        backgroundColor: AppStyles.btnColor(1),
        email: 'info@sudagoras.com',
      ),
    );
  }
}

class ContactUsPage extends StatelessWidget {
  final ImageProvider logo;
  final Image image;
  final String phoneNumber;
  final String phoneNumberText;
  final String website;
  final String websiteText;
  final String email;
  final String emailText;
  final String twitterHandle;
  final String facebookHandle;
  final String linkedinURL;
  final String githubUserName;
  final String companyName;
  final double companyFontSize;
  final String tagLine;
  final String instagram;
  final Color textColor;
  final Color cardColor;
  final Color companyColor;
  final Color taglineColor;
  ContactUsPage({
    @required this.companyName,
    @required this.textColor,
    @required this.cardColor,
    @required this.companyColor,
    @required this.taglineColor,
    @required this.email,
    this.emailText,
    this.logo,
    this.image,
    this.phoneNumber,
    this.phoneNumberText,
    this.website,
    this.websiteText,
    this.twitterHandle,
    this.facebookHandle,
    this.linkedinURL,
    this.githubUserName,
    this.tagLine,
    this.instagram,
    this.companyFontSize,
  });

  showAlert(BuildContext context) {
    var localization=AppLocalization.of(context);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 8.0,
          contentPadding: EdgeInsets.all(5.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          content: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () => launch('${AppLocalization.of(context).translate('Tel')}:' + phoneNumber),
                  child: Container(
                    height: 50.0,
                    alignment: Alignment.center,
                    child: Text(
                      AppLocalization.of(context).translate('Make a Voice Call'),
                    ),
                  ),
                ),
                Divider(),
                InkWell(
                  onTap: () => launch('${localization.translate('Sms')}:' + phoneNumber),
                  child: Container(
                    alignment: Alignment.center,
                    height: 50.0,
                    child: Text(
                      localization.translate('Send Sms'),
                    ),
                  ),
                ),
                Divider(),
                InkWell(
                  onTap: () => launch('https://wa.me/' + phoneNumber),
                  child: Container(
                    alignment: Alignment.center,
                    height: 50.0,
                    child: Text(
                      localization.translate('WhatsApp Chat'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Visibility(
              visible: logo != null,
              child: CircleAvatar(
                radius: 50.0,
                backgroundImage: logo,
              ),
            ),
            Visibility(
              visible: image != null,
              child: image ?? SizedBox.shrink(),
            ),
            Text(
              companyName,
              style: TextStyle(
                fontSize: companyFontSize ?? 20.0,
                color: companyColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Visibility(
              visible: tagLine != null,
              child: Text(
                tagLine ?? "",
                style: TextStyle(
                  color: taglineColor,
                  fontSize: 15.0,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Divider(
              color: Colors.teal[200],
              thickness: 1,
              indent: 50.0,
              endIndent: 50.0,
            ),
            SizedBox(
              height: 10.0,
            ),
            Visibility(
              visible: website != null,
              child: Card(
                clipBehavior: Clip.antiAlias,
                margin: EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 5.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                color: cardColor,
                child: ListTile(
                  leading: Icon(Typicons.link),
                  title: Text(
                    websiteText ?? AppLocalization.of(context).translate('Website'),
                    style: TextStyle(
                      color: textColor,
                    ),
                  ),
                  onTap: () => launch(website),
                ),
              ),
            ),
            Visibility(
              visible: phoneNumber != null,
              child: Card(
                clipBehavior: Clip.antiAlias,
                margin: EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 5.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                color: cardColor,
                child: ListTile(
                  leading: Icon(Typicons.phone),
                  title: Text(
                    phoneNumberText ?? AppLocalization.of(context).translate('Mobile Number'),
                    style: TextStyle(
                      color: textColor,
                    ),
                  ),
                  onTap: () => showAlert(context),
                ),
              ),
            ),
            Card(
              clipBehavior: Clip.antiAlias,
              margin: EdgeInsets.symmetric(
                vertical: 5.0,
                horizontal: 5.0,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              color: cardColor,
              child: ListTile(
                leading: Icon(Typicons.mail),
                title: Text(
                  emailText ??  AppLocalization.of(context).translate('Email Address'),
                  style: TextStyle(
                    color: textColor,
                  ),
                ),
                onTap: () => launch('mailto:' + email),
              ),
            ),
            Visibility(
              visible: twitterHandle != null,
              child: Card(
                clipBehavior: Clip.antiAlias,
                margin: EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 5.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                color: cardColor,
                child: ListTile(
                  leading: Icon(Typicons.social_twitter),
                  title: Text(
                    AppLocalization.of(context).translate('Twitter Page'),
                    style: TextStyle(
                      color: textColor,
                    ),
                  ),
                  onTap: () => launch('https://twitter.com/' + twitterHandle),
                ),
              ),
            ),
            Visibility(
              visible: facebookHandle != null,
              child: Card(
                clipBehavior: Clip.antiAlias,
                margin: EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 5.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                color: cardColor,
                child: ListTile(
                  leading: Icon(Typicons.social_facebook),
                  title: Text(
                    AppLocalization.of(context).translate('Facebook Page'),
                    style: TextStyle(
                      color: textColor,
                    ),
                  ),
                  onTap: () =>
                      launch('https://www.facebook.com/' + facebookHandle),
                ),
              ),
            ),
            Visibility(
              visible: instagram != null,
              child: Card(
                clipBehavior: Clip.antiAlias,
                margin: EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 5.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                color: cardColor,
                child: ListTile(
                  leading: Icon(Typicons.social_instagram),
                  title: Text(
                    AppLocalization.of(context).translate('Instagram Page'),
                    style: TextStyle(
                      color: textColor,
                    ),
                  ),
                  onTap: () => launch('https://instagram.com/' + instagram),
                ),
              ),
            ),
            Visibility(
              visible: githubUserName != null,
              child: Card(
                clipBehavior: Clip.antiAlias,
                margin: EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 5.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                color: cardColor,
                child: ListTile(
                  leading: Icon(Typicons.social_github),
                  title: Text(
                    AppLocalization.of(context).translate('Github Link'),
                    style: TextStyle(
                      color: textColor,
                    ),
                  ),
                  onTap: () => launch('https://github.com/' + githubUserName),
                ),
              ),
            ),
            Visibility(
              visible: linkedinURL != null,
              child: Card(
                clipBehavior: Clip.antiAlias,
                margin: EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 5.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                color: cardColor,
                child: ListTile(
                  leading: Icon(Typicons.social_linkedin),
                  title: Text(
                    AppLocalization.of(context).translate('Linked In Page'),
                    style: TextStyle(
                      color: textColor,
                    ),
                  ),
                  onTap: () => launch(linkedinURL),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContactUsBottomAppBar extends StatelessWidget {
  final Color textColor;
  final Color backgroundColor;
  final String email;
  final String companyName;
  final double fontSize;
  ContactUsBottomAppBar(
      {@required this.textColor,
      @required this.backgroundColor,
      @required this.email,
      @required this.companyName,
      this.fontSize = 15.0});
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: backgroundColor,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Text(
        '${AppLocalization.of(context).translate('Message The Developer')} $companyName 💙',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: textColor,
          fontSize: fontSize,
        ),
      ),
      onPressed: () => launch('mailto:$email'),
    );
  }
}
