import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:receptico/core/UI/theme.dart';
import 'package:receptico/core/authorization/authorization.dart';

import '../widget/widget.dart';

@RoutePage()
class TempLogoutPage extends StatelessWidget {
  const TempLogoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    final router = AutoRouter.of(context);
    return ScaffoldWithGradientWidget(
      body: Stack(
        fit: StackFit.expand,
        children: [
          const Positioned(
            top: -91,
            right: -94,
            child: CircleWidget(width: 238, height: 238),
          ),
          const Positioned(
            bottom: -58,
            left: -71,
            child: CircleWidget(width: 170, height: 170),
          ),
          Container(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                      bottom: orientation == Orientation.portrait ? 60.0 : 0,
                    ),
                    child: SvgPicture.asset(
                      context.assetPath.logo,
                      width: 282,
                      height: 282,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 34.0),
                    child: SizedBox(
                      width: 235,
                      child: Text(
                        FirebaseAuth.instance.currentUser?.email ??
                            'User logout',
                        textAlign: TextAlign.center,
                        style: context.font.displayLarge,
                      ),
                    ),
                  ),
                  TextButtonWidget(
                    width: 278,
                    height: 50,
                    text: 'Logout',
                    onPressed: () async {
                      await GetIt.I<IAuthorization>().signOut();
                      router.back();
                    },
                  ),
                ],
              ),
            ),
          ),
          FailCatchWidget(),
        ],
      ),
    );
  }
}
