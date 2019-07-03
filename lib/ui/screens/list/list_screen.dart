import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yuka_clone/data/model/product.dart';
import 'package:yuka_clone/ui/resources/assets.dart';
import 'package:yuka_clone/ui/resources/colors.dart';
import 'package:yuka_clone/ui/resources/icons.dart';
import 'package:yuka_clone/ui/screens/barcode_scanner/barcode_scanner_screen.dart';
import 'package:yuka_clone/ui/screens/details/details_screen.dart';
import 'package:yuka_clone/ui/screens/list/list_provider.dart';
import 'package:yuka_clone/ui/widgets/app_bar.dart';
import 'package:yuka_clone/ui/widgets/button.dart';

class ProductsListScreen extends StatefulWidget {
  ProductsListScreen();

  @override
  _ProductsListScreenState createState() => _ProductsListScreenState();
}

class _ProductsListScreenState extends State<ProductsListScreen> {
  ProductsListProviders _providers;

  @override
  void initState() {
    super.initState();
    _providers = ProductsListProviders();
    _providers.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: YukaAppBar(title: 'Mes produits'),
        body: MultiProvider(providers: [
          Provider<_ProductsListScreenState>.value(value: this),
          StreamProvider(builder: (_) => _providers.productsListStream)
        ], child: const _ProductListScreenContent()));
  }

  void openBarcodeScanner() async {
    var barcode = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BarcodeScannerScreen()),
    );

    if (barcode is String && barcode.isNotEmpty) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => AlertDialog(
                title: const Text('Chargement en cours'),
                content: Row(children: const <Widget>[
                  CircularProgressIndicator(),
                  SizedBox(width: 15.0),
                  Expanded(
                      child: Text('Merci de patienter quelques secondes...'))
                ]),
              ));

      var product = await _providers.findProduct(barcode);

      // Remove the dialog
      Navigator.pop(context);

      if (product != null) {
        openProductDetails(product);

        // Reload the list with the new product
        _providers.fetchProducts();
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: Text('Une erreur est survenue'),
                  content: Text(
                      'Impossible de trouver les détails pour le produit dont le code-barres est \"$barcode\".'),
                  actions: <Widget>[
                    FlatButton(
                        child: Text('OK'),
                        onPressed: () {
                          Navigator.of(context).maybePop();
                        })
                  ],
                ));
      }
    }
  }

  void openProductDetails(Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ProductDetailsScreen(product: product)),
    );
  }
}

class _ProductListScreenContent extends StatelessWidget {
  const _ProductListScreenContent();

  @override
  Widget build(BuildContext context) {
    var event = Provider.of<ProductsListEvent>(context);

    if (event != null) {
      if (event.state == ProductsListState.loading) {
        return const _ProductListScreenLoading();
      } else if (event.state == ProductsListState.loaded) {
        if (event.products.isEmpty) {
          return const _ProductListScreenEmpty();
        } else {
          return const _ProductListScreenListContent();
        }
      }
    }

    return _ProductListScreenError();
  }
}

class _ProductListScreenLoading extends StatelessWidget {
  const _ProductListScreenLoading();

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class _ProductListScreenError extends StatelessWidget {
  const _ProductListScreenError();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Une erreur est survenue'));
  }
}

class _ProductListScreenEmpty extends StatelessWidget {
  const _ProductListScreenEmpty();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        Image.asset(AppAssets.ic_empty_list),
        const SizedBox(height: 92.0),
        Text('Vous n\'avez encore rien scanné !',
            style:
                const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10.0),
        Text('Cliquez sur le bouton ci-dessous pour commencer'),
        const SizedBox(height: 30.0),
        AppButton(
            text: 'Scanner un produit',
            onPressed: () {
              Provider.of<_ProductsListScreenState>(context)
                  .openBarcodeScanner();
            })
      ]),
    );
  }
}

class _ProductListScreenListContent extends StatelessWidget {
  const _ProductListScreenListContent();

  @override
  Widget build(BuildContext context) {
    var products = Provider.of<ProductsListEvent>(context).products;

    return IconTheme(
      data: IconTheme.of(context)
          .copyWith(color: AppColors.gray_icon, size: 16.0),
      child: Stack(
        children: <Widget>[
          ListView.builder(
              itemCount: products.length,
              padding: const EdgeInsets.all(16.0),
              itemBuilder: (context, position) =>
                  _ProductListScreenListItem(product: products[position])),
          Positioned(
              bottom: 16.0,
              right: 16.0,
              child: AppFAB(
                icon: AppIcons.barcode_scanner,
                onPressed: () {
                  Provider.of<_ProductsListScreenState>(context)
                      .openBarcodeScanner();
                },
              ))
        ],
      ),
    );
  }
}

class _ProductListScreenListItem extends StatelessWidget {
  final Product product;

  _ProductListScreenListItem({this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            Provider.of<_ProductsListScreenState>(context)
                .openProductDetails(product);
          },
          child: Column(children: <Widget>[
            Hero(
              tag: product.barcode,
              child: Image.network(
                product.picture ?? '-',
                height: 295,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(
                  start: 12.0, end: 12.0, top: 16.0, bottom: 12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(product.name,
                      style: const TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold)),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 5.0),
                    child: Text(product.brands?.join(', ') ?? '',
                        style: const TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.w500)),
                  ),
                  const SizedBox(height: 10.0),
                  DefaultTextStyle(
                    style: DefaultTextStyle.of(context)
                        .style
                        .copyWith(fontSize: 14.0),
                    child: Row(
                      children: <Widget>[
                        Flexible(
                            child: Row(
                          children: <Widget>[
                            Icon(AppIcons.calories),
                            const SizedBox(width: 5.0),
                            Text(
                                'Nutriscore : ${product.nutriScore.toUpperCase()}')
                          ],
                        )),
                        if (product.nutritionFacts.calories != null)
                          Flexible(
                              child: Row(
                            children: <Widget>[
                              Icon(AppIcons.leaderboard),
                              const SizedBox(width: 5.0),
                              Text(
                                  'Nutriscore : ${product.nutritionFacts.calories}')
                            ],
                          )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ]),
        ));
  }
}
