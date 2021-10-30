import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maosul/localization/localizationSetup/app_localization.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../CircularLoadingWidget.dart';
import '../../helper/app_styles.dart';
import '../../provider/markets_provider.dart';
import '../../provider/offers_provider.dart';
import '../../screens/FadeAnimation.dart';
import '../../screens/shops.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    var localization=AppLocalization.of(context);
    return Stack(
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
          padding: const EdgeInsets.only(top: 3.0),
          child: Consumer<OffersProvider>(
            builder: (ctx, offer, child) {
              return offer.isLoading
                  ? SizedBox(
                      height: 3,
                      child: LinearProgressIndicator(
                        backgroundColor: AppStyles.lineColor(1),
                      ),
                    )
                  : Visibility(
                      visible: offer.getOffers.length > 0,
                      child: FadeAnimation(
                        0.6,
                        CarouselSlider.builder(
                          options: CarouselOptions(
                            height: 180.0,
                            aspectRatio: 16 / 9,
                            viewportFraction: 0.8,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 3),
                            autoPlayAnimationDuration:
                            Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            scrollDirection: Axis.horizontal,
                          ),
                          itemCount: offer.getOffers.length,
                          itemBuilder: (BuildContext context, int i, int pageViewIndex) =>
                              FadeAnimation(
                                  i == 0 ? 0.1 : i > 6 ? i / 5 : i / 3, Stack(
                                children: [
                                  Card(
                                    elevation: 3.0,
                                    child: FadeAnimation(
                                      i == 0
                                          ? 0.1
                                          : i > 6
                                          ? i / 5
                                          : i / 3,
                                      Container(
                                        height: 200,
                                        width: double.infinity,
                                        margin:
                                        EdgeInsets.symmetric(horizontal: 0.0),
                                        decoration: BoxDecoration(
                                          color: AppStyles.mainColor(1),
                                        ),
                                        child:
                                        offer.getOffers[i].imageUrl.isNotEmpty
                                            ? Image.network(
                                          "${offer.getOffers[i].imageUrl[0]}",
                                          fit: BoxFit.fill,
                                        )
                                            : Image.asset(
                                          'assets/images/vegetables.png',
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 5.0,
                                    left: 5.0,
                                    right: 5.0,
                                    child: Container(
                                      height: 30.0,
                                      width: double.infinity,
                                      color: Colors.black38,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 15.0,
                                          right: 15.0,
                                        ),
                                        child: FadeAnimation(
                                          i == 0
                                              ? 0.1
                                              : i > 6
                                              ? i / 5
                                              : i / 3,
                                          Text(
                                            "${offer.getOffers[i].title}",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                              ),
                        ),
                      ),
                    );
            },
          ),
        ),



        Padding(
          padding: const EdgeInsets.only(
            top: 190.0,
            left: 0.0,
            right: 0.0,
            bottom: 10.0,
          ),
          child: Consumer<MarketsProvider>(
            builder: (ctx, markets, child) {
              return markets.isLoading
                  ? CircularLoadingWidget(height: 500)
                  : markets.getMarkets.length > 0
                      ? GridView.builder(
                          scrollDirection: Axis.vertical,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 4.0,
                            mainAxisSpacing: 4.0,
                          ),
                          itemCount: markets.getMarkets.length,
                          itemBuilder: (ctx, i) {
                            return FadeAnimation(
                                i == 0
                                    ? 0.1
                                    : i > 6
                                        ? i / 5
                                        : i / 3,
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.scale,
                                        duration: Duration(
                                          seconds: 0,
                                          milliseconds: 700,
                                        ),
                                        alignment: Alignment.center,
                                        child: Shops(
                                          marketID: markets.getMarkets[i].id,
                                          marketName:
                                              markets.getMarkets[i].name,
                                          marketImage:
                                              markets.getMarkets[i].imageUrl[0],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Card(
                                    elevation: 3.0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(15),
                                      ),
                                    ),
                                    child: Container(
                                      decoration: new BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        color: Colors.black54,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 1.0,
                                          // style: BorderStyle.solid,
                                        ),
                                        image: new DecorationImage(
                                          image: NetworkImage(
                                            '${markets.getMarkets[i].imageUrl[0]}',
                                          ),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          color: Colors.black45,
                                        ),
                                        child: Center(
                                          child: Text(
                                            markets.getMarkets[i].name,
                                            style: AppStyles.txtNameStyle,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ));
                          },
                        )
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(localization.translate('No Markets')),
                              Text(
                                "..................",
                                style: TextStyle(
                                  color: Colors.cyan,
                                ),
                              ),
                            ],
                          ),
                        );
            },
          ),
        ),
      ],
    );
  }
}
