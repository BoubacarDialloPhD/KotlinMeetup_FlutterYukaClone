import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yuka_clone/data/model/product.dart';
import 'package:yuka_clone/ui/resources/colors.dart';
import 'package:yuka_clone/ui/screens/details/tabs/details_screen_nutrition.dart';
import 'package:yuka_clone/ui/screens/details/tabs/details_screen_summary.dart';
import 'package:yuka_clone/ui/widgets/app_bar.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  ProductDetailsScreen({@required this.product}) : assert(product != null);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: YukaAppBar(
              title: 'Détails',
              bottom: TabBar(indicatorColor: AppColors.white_light, tabs: [
                Tab(child: Text('Fiche')),
                Tab(child: Text('Nutrition'))
              ])),
          body: MultiProvider(
              providers: [
                Provider<Product>.value(value: product),
              ],
              child: TabBarView(
                children: <Widget>[
                  ProductDetailsSummary(),
                  ProductDetailsNutrition()
                ],
              ))),
    );
  }
}
