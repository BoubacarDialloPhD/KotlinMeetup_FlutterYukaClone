import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yuka_clone/data/model/product.dart';

class ProductDetailsSummary extends StatelessWidget {
  const ProductDetailsSummary();

  @override
  Widget build(BuildContext context) {
    var product = Provider.of<Product>(context);

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Image.network(
            product.picture,
            width: double.infinity,
            height: 290.0,
            fit: BoxFit.cover,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 22.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const _ProductDetailsSummaryTitleRow(),
                const SizedBox(height: 22.0),
                _ProductDetailsSummaryItem(
                    title: 'Code-barres', value: product.barcode),
                _ProductDetailsSummaryItem(
                    title: 'Quantité', value: product.quantity),
                _ProductDetailsSummaryItem(
                    title: 'Vendu en',
                    value: product.manufacturingCountries?.join(', ')),
                const SizedBox(height: 20.0),
                _ProductDetailsSummaryItem(
                    title: 'Ingrédients',
                    value: product.ingredients?.join(', ')),
                const SizedBox(height: 15.0),
                _ProductDetailsSummaryItem(
                    title: 'Substances allergènes',
                    value: product.allergens?.join(', '),
                    emptyValue: 'Aucune'),
                const SizedBox(height: 15.0),
                _ProductDetailsSummaryItem(
                  title: 'Additifs',
                  value: _printableAdditives(product.additives).join(', '),
                  emptyValue: 'Aucun',
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  List<String> _printableAdditives(Map<String, String> additives) {
    List<String> list = [];

    if (additives != null) {
      for (var code in additives.keys) {
        list.add('$code : ${additives[code]}');
      }
    }

    return list;
  }
}

class _ProductDetailsSummaryTitleRow extends StatelessWidget {
  const _ProductDetailsSummaryTitleRow();

  @override
  Widget build(BuildContext context) {
    var product = Provider.of<Product>(context);

    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(product.name,
                    maxLines: 1,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 18.0)),
                const SizedBox(height: 5.0),
                Text(
                  product.brands.join(', '),
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
              ]),
        ),
        Image.asset(
            'res/drawables/nutriscore_${product.nutriScore.toLowerCase()}.png',
            width: 78.0)
      ],
    );
  }
}

class _ProductDetailsSummaryItem extends StatelessWidget {
  final String title;
  final String value;
  final String emptyValue;

  _ProductDetailsSummaryItem(
      {@required this.title, @required this.value, this.emptyValue});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
            text: '$title : ',
            style: const TextStyle(fontWeight: FontWeight.w500)),
        TextSpan(text: value ?? (emptyValue ?? '-')),
      ], style: DefaultTextStyle.of(context).style.copyWith(height: 1.2)),
    );
  }
}
