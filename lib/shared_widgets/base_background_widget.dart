import 'package:flutter/material.dart';
import 'package:last_fm_challenge/utilities/colors.dart';
import 'package:last_fm_challenge/utilities/fonts.dart';

enum ScreenTheme {
  Primary,
}

class BaseBackgroundWidget extends StatelessWidget {
  final Widget child;
  final String title;
  final Widget titleWidget;
  final bool hideBackButton;
  final ScreenTheme screenTheme;
  final bool resizeToAvoidBottomInset;
  final List<Widget> appBarActions;
  final Function onBackButtonPressed;
  final GlobalKey scaffoldKey;
  final bool isScreenActionDisabled;
  final IconData backIcon;

  BaseBackgroundWidget({
    this.child,
    this.title = '',
    this.titleWidget,
    this.hideBackButton = false,
    this.screenTheme = ScreenTheme.Primary,
    this.resizeToAvoidBottomInset = true,
    this.appBarActions,
    this.onBackButtonPressed,
    this.scaffoldKey,
    this.isScreenActionDisabled = false,
    this.backIcon = Icons.arrow_back,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: this.scaffoldKey,
        backgroundColor: _screenBackgroundColor(),
        resizeToAvoidBottomInset: this.resizeToAvoidBottomInset,
        appBar: _buildAppBar(context),
        body: SafeArea(
          child: IgnorePointer(
            ignoring: this.isScreenActionDisabled,
            child: this.child,
          ),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    this.onBackButtonPressed?.call();
    return false;
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: this.hideBackButton
          ? Container()
          : IconButton(
              icon: Icon(
                this.backIcon,
                color: _appBarIconColor(),
              ),
              onPressed: this.onBackButtonPressed == null
                  ? () {
                      Navigator.pop(context);
                    }
                  : this.onBackButtonPressed,
            ),
      title: _createAppBarTitleWidget(),
      backgroundColor: _appBarBackgroundColor(),
      brightness: this.screenTheme == ScreenTheme.Primary ? Brightness.light : Brightness.dark,
      elevation: 0.0,
      actions: this.appBarActions,
    );
  }

  Widget _createAppBarTitleWidget() {
    if (this.titleWidget != null) {
      return this.titleWidget;
    }
    return Text(
      this.title,
      style: _appBarTextStyle(),
    );
  }

  Color _screenBackgroundColor() => ThemeColors.background.primary;
  Color _appBarIconColor() => ThemeColors.icon.secondary;
  Color _appBarBackgroundColor() => ThemeColors.background.primary;

  TextStyle _appBarTextStyle() {
    return TextStyle(
      color: ThemeColors.text.secondary,
      fontSize: ThemeFonts.size.navBarTitle,
      fontWeight: FontWeight.bold,
    );
  }
}
