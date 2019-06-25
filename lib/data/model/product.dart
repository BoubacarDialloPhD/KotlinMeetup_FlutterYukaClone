import 'package:yuka_clone/utils/list_utils.dart';
import 'package:yuka_clone/utils/object_utils.dart';

class Product {
  final String name;
  final String altName;
  final String barcode;
  final String picture;
  final String quantity;
  final List<String> brands;
  final List<String> manufacturingCountries;
  final String nutriScore;
  final String novaScore;
  final List<String> ingredients;
  final List<String> traces;
  final List<String> allergens;
  final Map<String, String> additives;
  final NutrientLevels nutrientLevels;
  final NutritionFacts nutritionFacts;
  final bool ingredientsFromPalmOil;

  Product.fromAPI(Map<String, dynamic> api)
      : name = api['name'],
        altName = api['altName'],
        barcode = api['barcode'],
        picture = api['picture'],
        quantity = api['quantity'],
        brands =
            ListUtils.toListFromObject(api['brands'], (item) => item as String),
        manufacturingCountries = ListUtils.toListFromObject(
            api['manufacturingCountries'], (item) => item as String),
        nutriScore = api['nutriScore'],
        novaScore = api['novaScore'],
        ingredients = ListUtils.toListFromObject(
            api['ingredients'], (item) => item as String),
        traces =
            ListUtils.toListFromObject(api['traces'], (item) => item as String),
        allergens = ListUtils.toListFromObject(
            api['allergens'], (item) => item as String),
        additives = Map.castFrom(api['additives']),
        nutritionFacts = NutritionFacts.fromAPI(api['nutritionFacts']),
        nutrientLevels = NutrientLevels.fromAPI(api['nutrientLevels']),
        ingredientsFromPalmOil = api['containsPalmOil'];

  static List<String> stringToList(String text) {
    if (text == null || text.isEmpty) {
      return null;
    }

    RegExp('\\(.*?\\)').allMatches(text).forEach((match) {
      var group = match.group(0);
      text = text.replaceAll(group, group.replaceAll(',', '****'));
    });

    return null;
  }

  static Map<String, String> extractAdditives(List additivesTags) {
    return null;
  }

  static bool extractPalmOil(dynamic object) {
    if (object == null || object is! num) {
      return false;
    }
    return object >= 1;
  }

  @override
  String toString() {
    return 'Product{name: $name, altName: $altName, barcode: $barcode, picture: $picture, quantity: $quantity, brands: $brands, manufacturingCountries: $manufacturingCountries, nutriScore: $nutriScore, novaScore: $novaScore, ingredients: $ingredients, traces: $traces, allergens: $allergens, additives: $additives, nutrientLevels: $nutrientLevels, nutritionFacts: $nutritionFacts, ingredientsFromPalmOil: $ingredientsFromPalmOil}';
  }
}

class NutritionFacts {
  final String servingSize;
  final Nutriment calories;
  final Nutriment fat;
  final Nutriment saturatedFat;
  final Nutriment carbohydrate;
  final Nutriment sugar;
  final Nutriment fiber;
  final Nutriment proteins;
  final Nutriment sodium;
  final Nutriment salt;
  final Nutriment energy;

  NutritionFacts(
      {this.servingSize,
      this.calories,
      this.fat,
      this.saturatedFat,
      this.carbohydrate,
      this.sugar,
      this.fiber,
      this.proteins,
      this.sodium,
      this.salt,
      this.energy});

  NutritionFacts.fromAPI(Map<String, dynamic> api)
      : servingSize = api['servingSize'],
        calories = ObjectUtils.extract(
            api['calories'], (item) => Nutriment.fromAPI(item)),
        fat =
            ObjectUtils.extract(api['fat'], (item) => Nutriment.fromAPI(item)),
        saturatedFat = ObjectUtils.extract(
            api['saturatedFat'], (item) => Nutriment.fromAPI(item)),
        carbohydrate = ObjectUtils.extract(
            api['carbohydrate'], (item) => Nutriment.fromAPI(item)),
        sugar = ObjectUtils.extract(
            api['sugar'], (item) => Nutriment.fromAPI(item)),
        fiber = ObjectUtils.extract(
            api['fiber'], (item) => Nutriment.fromAPI(item)),
        proteins = ObjectUtils.extract(
            api['proteins'], (item) => Nutriment.fromAPI(item)),
        sodium = ObjectUtils.extract(
            api['sodium'], (item) => Nutriment.fromAPI(item)),
        energy = ObjectUtils.extract(
            api['energy'], (item) => Nutriment.fromAPI(item)),
        salt =
            ObjectUtils.extract(api['salt'], (item) => Nutriment.fromAPI(item));

  @override
  String toString() {
    return 'NutritionFacts{servingSize: $servingSize, calories: $calories, fat: $fat, saturatedFat: $saturatedFat, carbohydrate: $carbohydrate, sugar: $sugar, fiber: $fiber, proteins: $proteins, sodium: $sodium, salt: $salt, energy: $energy}';
  }
}

class Nutriment {
  final String unit;
  final dynamic perServing;
  final dynamic per100g;

  Nutriment({this.unit, this.perServing, this.per100g});

  Nutriment.fromAPI(Map<String, dynamic> api)
      : per100g = api['per100g'],
        perServing = api['perServing'],
        unit = api['unit'];

  @override
  String toString() {
    return 'Nutriment{unit: $unit, perServing: $perServing, per100g: $per100g}';
  }
}

class NutrientLevels {
  final String salt;
  final String saturatedFat;
  final String sugars;
  final String fat;

  NutrientLevels.fromAPI(Map<String, dynamic> api)
      : salt = api['salt'],
        saturatedFat = api['saturated-fat'],
        sugars = api['sugars'],
        fat = api['fat'];

  @override
  String toString() {
    return 'NutrientLevels{salt: $salt, saturatedFat: $saturatedFat, sugars: $sugars, fat: $fat}';
  }
}
