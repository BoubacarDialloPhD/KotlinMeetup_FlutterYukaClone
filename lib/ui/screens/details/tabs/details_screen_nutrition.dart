import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yuka_clone/data/model/product.dart';
import 'package:yuka_clone/ui/resources/colors.dart';
import 'package:yuka_clone/ui/widgets/circle.dart';
import 'package:yuka_clone/utils/num_utils.dart';

class ProductDetailsNutrition extends StatelessWidget {
  const ProductDetailsNutrition();

  @override
  Widget build(BuildContext context) {
    var nutritionItems = _extractNutritionItems(Provider.of<Product>(context));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 23.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Repères nutritionnels pour 100g',
              style:
                  const TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500)),
          const SizedBox(height: 16.0),
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: nutritionItems.length,
              itemBuilder: (context, position) =>
                  _ProductDetailsNutritionItem(item: nutritionItems[position]))
        ],
      ),
    );
  }

  List<ProductNutritionItem> _extractNutritionItems(Product product) {
    var nutrientLevels = product.nutrientLevels;
    var nutritionFacts = product.nutritionFacts;

    List<ProductNutritionItem> list = [];

    if (nutrientLevels.fat != null && nutritionFacts.fat != null) {
      list.add((ProductNutritionItem(
          label: "Matières grasses / lipides",
          product: nutritionFacts.fat,
          nutrientLevel: nutrientLevels.fat)));
    }

    if (nutrientLevels.saturatedFat != null &&
        nutritionFacts.saturatedFat != null) {
      list.add((ProductNutritionItem(
          label: "Acides gras saturés",
          product: nutritionFacts.saturatedFat,
          nutrientLevel: nutrientLevels.saturatedFat)));
    }

    if (nutrientLevels.sugars != null && nutritionFacts.sugar != null) {
      list.add((ProductNutritionItem(
          label: "Sucres",
          product: nutritionFacts.sugar,
          nutrientLevel: nutrientLevels.sugars)));
    }

    if (nutrientLevels.salt != null && nutritionFacts.salt != null) {
      list.add((ProductNutritionItem(
          label: "Sel",
          product: nutritionFacts.salt,
          nutrientLevel: nutrientLevels.salt)));
    }

    return list;
  }
}

class ProductNutritionItem {
  final double quantity;
  final String unit;
  final String label;
  final ProductNutrientLevel nutrientLevel;

  ProductNutritionItem(
      {@required Nutriment product,
      @required this.label,
      @required String nutrientLevel})
      : quantity = NumUtils.parseDouble(product.per100g, 0),
        unit = product.unit,
        nutrientLevel = _extractLevel(nutrientLevel);

  static ProductNutrientLevel _extractLevel(String nutrientLevel) {
    if (nutrientLevel == 'low') {
      return ProductNutrientLevel.low;
    } else if (nutrientLevel == 'moderate') {
      return ProductNutrientLevel.moderate;
    } else {
      return ProductNutrientLevel.high;
    }
  }
}

enum ProductNutrientLevel { low, moderate, high }

class _ProductDetailsNutritionItem extends StatelessWidget {
  final ProductNutritionItem item;

  _ProductDetailsNutritionItem({@required this.item}) : assert(item != null);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: 16.0),
      child: Row(
        children: <Widget>[
          CircleWidget(color: _findColor()),
          const SizedBox(width: 14.0),
          Expanded(
              child: Text(
                  '${item.quantity} ${item.unit} de ${item.label}\n${_extractQuantity()}',
                  textAlign: TextAlign.justify,
                  style: const TextStyle(height: 1.2)))
        ],
      ),
    );
  }

  Color _findColor() {
    switch (item.nutrientLevel) {
      case ProductNutrientLevel.low:
        return AppColors.nutrition_score_low;
      case ProductNutrientLevel.moderate:
        return AppColors.nutrition_score_moderate;
      default:
        return AppColors.nutrition_score_high;
    }
  }

  String _extractQuantity() {
    switch (item.nutrientLevel) {
      case ProductNutrientLevel.low:
        return 'en faible quantité';
      case ProductNutrientLevel.low:
        return 'en quantité modérée';
      default:
        return 'en quantité élevée';
    }
  }
}
