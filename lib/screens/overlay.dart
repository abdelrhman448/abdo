import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:maosul/localization/localizationSetup/app_localization.dart';
import 'package:maosul/provider/socket_provider.dart';
import 'package:provider/provider.dart';

class OverlayPage extends ModalRoute<void> {
  @override
  Duration get transitionDuration => Duration(milliseconds: 500);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return Material(
      type: MaterialType.transparency,
      child: Consumer<SocketProvider>(builder: (ctx, socket, child) {
        return SafeArea(
          child: _buildOverlayPageContent(context),
        );
      }),
    );
  }

  Widget _buildOverlayPageContent(BuildContext context) {
    return Center(
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 120),
            child: Center(
              child: Text(
                 AppLocalization.of(context).translate('Looking for a delivery person...'),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: Align(
              child: LayoutBuilder(
                builder: (context, _) {
                  return IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                    iconSize: 50.0,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  );
                },
              ),
              alignment: Alignment.bottomCenter,
            ),
          ),
          Positioned.fill(
            child: Center(
              child: SpinKitRipple(
                itemBuilder: (_, int index) {
                  return CircleAvatar(
                    backgroundColor: index.isEven ? Colors.white : Colors.white,
                  );
                },
                size: 120.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}
