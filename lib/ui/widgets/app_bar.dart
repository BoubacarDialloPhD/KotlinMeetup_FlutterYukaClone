import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:yuka_clone/ui/resources/colors.dart';

class YukaAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget leading;
  final bool automaticallyImplyLeading;
  final String title;
  final List<Widget> actions;
  final Widget flexibleSpace;
  final PreferredSizeWidget bottom;
  final double elevation;
  final Brightness brightness;
  final IconThemeData iconTheme;
  final TextTheme textTheme;
  final bool primary;
  final bool centerTitle;
  final double titleSpacing;
  final double toolbarOpacity;
  final double bottomOpacity;
  @override
  final Size preferredSize;

  YukaAppBar(
      {Key key,
      this.leading,
      this.automaticallyImplyLeading = true,
      this.title,
      this.actions,
      this.flexibleSpace,
      this.bottom,
      this.elevation = 4.0,
      this.brightness,
      this.iconTheme,
      this.textTheme,
      this.primary = true,
      this.centerTitle,
      this.titleSpacing = NavigationToolbar.kMiddleSpacing,
      this.toolbarOpacity = 1.0,
      this.bottomOpacity = 1.0})
      : assert(title != null),
        preferredSize = Size.fromHeight(
            kToolbarHeight + (bottom?.preferredSize?.height ?? 0.0)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var appBarTheme = AppBarTheme.of(context);

    return GradientAppBar(
      backgroundColorStart: AppColors.green_start,
      backgroundColorEnd: AppColors.green_end,
      title: Text(title, style: appBarTheme.textTheme.title),
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
      actions: actions,
      flexibleSpace: flexibleSpace,
      bottom: bottom,
      elevation: elevation,
      brightness: brightness,
      iconTheme: iconTheme,
      textTheme: textTheme,
      primary: primary,
      centerTitle: centerTitle,
      titleSpacing: titleSpacing,
      toolbarOpacity: toolbarOpacity,
      bottomOpacity: bottomOpacity,
    );
  }
}
