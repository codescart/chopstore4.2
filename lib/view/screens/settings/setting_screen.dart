import 'package:flutter/material.dart';
import 'package:chopstore/helper/responsive_helper.dart';
import 'package:chopstore/localization/language_constrants.dart';
import 'package:chopstore/provider/splash_provider.dart';
import 'package:chopstore/provider/theme_provider.dart';
import 'package:chopstore/utill/dimensions.dart';
import 'package:chopstore/utill/styles.dart';
import 'package:chopstore/view/base/app_bar_base.dart';
import 'package:chopstore/view/base/custom_dialog.dart';
import 'package:chopstore/view/base/main_app_bar.dart';
import 'package:chopstore/view/screens/settings/widget/currency_dialog.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<SplashProvider>(context, listen: false).setFromSetting(true);

    return Scaffold(
      appBar: ResponsiveHelper.isMobilePhone()? null: ResponsiveHelper.isDesktop(context)? MainAppBar(): AppBarBase(),
      body: Center(
        child: Container(
          width: 1170,
          child: ListView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            children: [
              SwitchListTile(
                value: Provider.of<ThemeProvider>(context).darkTheme,
                onChanged: (bool isActive) =>Provider.of<ThemeProvider>(context, listen: false).toggleTheme(),
                title: Text(getTranslated('dark_theme', context), style: poppinsRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
              ),

              TitleButton(
                icon: Icons.language,
                title: getTranslated('choose_language', context),
                onTap: () => showAnimatedDialog(context, CurrencyDialog()),
              ),
            ],
          ),
        ),
      ),
    );
  }

}

class TitleButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function onTap;
  TitleButton({@required this.icon, @required this.title, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).primaryColor),
      title: Text(title, style: poppinsRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
      onTap: onTap,
    );
  }
}

