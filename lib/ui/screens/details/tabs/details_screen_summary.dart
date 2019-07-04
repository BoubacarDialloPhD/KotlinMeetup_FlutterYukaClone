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
          Hero(
            tag: product.barcode,
            child: Image.network(
              product.picture ?? '',
              width: double.infinity,
              height: 290.0,
              fit: BoxFit.cover,
            ),
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
                    title: 'Quantité', value: product.quantity ?? '-'),
                _ProductDetailsSummaryItem(
                    title: 'Vendu en',
                    value: product.manufacturingCountries?.join(', ')),
                const SizedBox(height: 25.0),
                _ProductDetailsSummaryItem(
                    title: 'Ingrédients',
                    value: product.ingredients?.join(', ')),
                const SizedBox(height: 20.0),
                _ProductDetailsSummaryItem(
                    title: 'Substances allergènes',
                    value: product.allergens?.join(', '),
                    emptyValue: 'Aucune'),
                const SizedBox(height: 20.0),
                _ProductDetailsSummaryItem(
                  title: 'Additifs',
                  value:
                      _printableAdditives(product.additives)?.join(', ') ?? '-',
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
    if (additives == null) {
      return null;
    }

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
                  product.brands?.join(', ') ?? '-',
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
              ]),
        ),
        if (product.nutriScore != null)
          Image.asset(
              'res/drawables/nutriscore_${product.nutriScore.toLowerCase()}.png',
              width: 78.0)
      ],
    );
  }
}

class _ProductDetailsSummaryItem extends StatelessWidget {
  final String title;
  final List<StylableText> text;

  _ProductDetailsSummaryItem(
      {@required this.title, @required String value, String emptyValue})
      : text = _generateText(value, emptyValue);

  static List<StylableText> _generateText(String value, String emptyValue) {
    if (value == null || value.isEmpty) {
      return [StylableText(false, emptyValue)];
    }

    var list = value.split('_');
    if (list.length == 1) {
      return [StylableText(false, value)];
    } else {
      var listValue = List<StylableText>();
      for (var i = 0; i != list.length; i++) {
        listValue.add(StylableText(i % 2 == 1, list[i]));
      }
      return listValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    var defaultFontWeight = DefaultTextStyle.of(context).style.fontWeight;

    return RichText(
      textAlign: TextAlign.justify,
      text: TextSpan(children: [
        TextSpan(
            text: '$title : ',
            style: const TextStyle(fontWeight: FontWeight.bold)),
        ...text.map((item) {
          return TextSpan(
              text: item.text,
              style: TextStyle(
                  fontWeight: item.bold ? FontWeight.bold : defaultFontWeight));
        }).toList(growable: false),
      ], style: DefaultTextStyle.of(context).style.copyWith(height: 1.4)),
    );
  }
}

class StylableText {
  final bool bold;
  final String text;

  StylableText(this.bold, this.text);
}
