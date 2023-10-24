import 'package:flutter/material.dart';
import 'package:chopstore/helper/responsive_helper.dart';
import 'package:chopstore/helper/route_helper.dart';
import 'package:chopstore/localization/language_constrants.dart';
import 'package:chopstore/utill/color_resources.dart';
import 'package:chopstore/utill/dimensions.dart';
import 'package:chopstore/utill/images.dart';
import 'package:chopstore/utill/styles.dart';
import 'package:chopstore/view/base/custom_button.dart';
import 'package:chopstore/view/base/footer_view.dart';
import 'package:chopstore/view/base/web_app_bar/web_app_bar.dart';
import 'package:chopstore/view/screens/menu/menu_screen.dart';
import 'package:chopstore/view/screens/order/track_order_screen.dart';

class OrderSuccessfulScreen extends StatelessWidget {
  final String orderID;
  final int status;

  OrderSuccessfulScreen({@required this.orderID, this.status,});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: ResponsiveHelper.isDesktop(context)? PreferredSize(child: WebAppBar(), preferredSize: Size.fromHeight(120)):null,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: ResponsiveHelper.isDesktop(context) ? MediaQuery.of(context).size.height - 560 : MediaQuery.of(context).size.height),
                child: Container(
                  width: ResponsiveHelper.isDesktop(context) ? MediaQuery.of(context).size.width * 0.3 : 1170,
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Image.asset(Images.order_placed, width: 150, height: 150, color: Theme.of(context).primaryColor),
                    SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                    Text(
                      getTranslated(
                          status == 0
                              ? 'order_placed_successfully'
                              : status == 1
                                  ? 'payment_failed'
                                  : 'payment_cancelled',
                          context),
                      style: poppinsMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE, color: Theme.of(context).primaryColor),
                    ),
                    SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text('${getTranslated('order_id', context)}:  #$orderID',
                          style: poppinsRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE, color: ColorResources.getTextColor(context))),
                    ]),
                    SizedBox(height: 30),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                        child: CustomButton(
                            buttonText: getTranslated(status == 0 ? 'track_order' : 'back_home', context),
                            onPressed: () {
                              if (status == 0) {
                                Navigator.pushReplacementNamed(context, RouteHelper.getOrderTrackingRoute(int.parse(orderID)), arguments: TrackOrderScreen(orderID: orderID, isBackButton: true));
                              } else {
                                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => MenuScreen()), (route) => false);
                              }
                            }),
                      ),
                    ),
                  ]),
                ),
              ),
            ),
            ResponsiveHelper.isDesktop(context) ? FooterView() : SizedBox(),
          ],
        ),
      ),
    );
  }
}
