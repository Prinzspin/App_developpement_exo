// ignore_for_file: constant_identifier_names
class Product {
  final String barcode;
  final String? name;
  final String? altName;
  final String? picture;
  final String? quantity;
  final List<String>? brands;
  final List<String>? manufacturingCountries;
  final ProductNutriScore? nutriScore;
  final ProductNutriScoreLevels? nutriScoreLevels;
  final ProductNovaScore? novaScore;
  final ProductGreenScore? greenScore;
  final List<String>? ingredients;

  // Eg: "Sucre, <span class=\"allergen\">gluten de blé</span>"
  final String? ingredientsWithAllergens;
  final List<String>? traces;
  final List<String>? allergens;
  final Map<String, String>? additives;
  final NutrientLevels? nutrientLevels;
  final NutritionFacts? nutritionFacts;
  final bool? ingredientsFromPalmOil;
  final ProductAnalysis? containsPalmOil;
  final ProductAnalysis? isVegan;
  final ProductAnalysis? isVegetarian;

  Product({
    required this.barcode,
    this.name,
    this.altName,
    this.picture,
    this.quantity,
    this.brands,
    this.manufacturingCountries,
    this.nutriScore,
    this.nutriScoreLevels,
    this.novaScore,
    this.greenScore,
    this.ingredients,
    this.ingredientsWithAllergens,
    this.traces,
    this.allergens,
    this.additives,
    this.nutrientLevels,
    this.nutritionFacts,
    this.ingredientsFromPalmOil,
    this.containsPalmOil,
    this.isVegan,
    this.isVegetarian,
  });
}

class NutritionFacts {
  final String servingSize;
  final Nutriment? calories;
  final Nutriment? fat;
  final Nutriment? saturatedFat;
  final Nutriment? carbohydrate;
  final Nutriment? sugar;
  final Nutriment? fiber;
  final Nutriment? proteins;
  final Nutriment? sodium;
  final Nutriment? salt;
  final Nutriment? energy;

  NutritionFacts({
    required this.servingSize,
    this.calories,
    this.fat,
    this.saturatedFat,
    this.carbohydrate,
    this.sugar,
    this.fiber,
    this.proteins,
    this.sodium,
    this.salt,
    this.energy,
  });
}

class Nutriment {
  final String unit;
  final dynamic perServing;
  final dynamic per100g;

  Nutriment({required this.unit, this.perServing, this.per100g});
}

class NutrientLevels {
  final String? salt;
  final String? saturatedFat;
  final String? sugars;
  final String? fat;

  NutrientLevels({this.salt, this.saturatedFat, this.sugars, this.fat});
}

class ProductNutriScoreLevels {
  final ProductNutriScoreLevel? energy;
  final ProductNutriScoreLevel? fiber;
  final ProductNutriScoreLevel? fruitsVegetablesLegumes;
  final ProductNutriScoreLevel? proteins;
  final ProductNutriScoreLevel? salt;
  final ProductNutriScoreLevel? saturatedFat;
  final ProductNutriScoreLevel? sugars;

  ProductNutriScoreLevels({
    required this.energy,
    required this.fiber,
    required this.fruitsVegetablesLegumes,
    required this.proteins,
    required this.salt,
    required this.saturatedFat,
    required this.sugars,
  });
}

class ProductNutriScoreLevel {
  final double points;
  final double maxPoints;
  final String unit;
  final double value;
  final ProductNutriScoreLevelType type;

  ProductNutriScoreLevel({
    required this.points,
    required this.maxPoints,
    required this.unit,
    required this.value,
    required this.type,
  });
}

enum ProductNutriScoreLevelType { positive, negative, unknown }

enum ProductNutriScore { A, B, C, D, E, unknown }

enum ProductNovaScore { group1, group2, group3, group4, unknown }

enum ProductGreenScore { A, APlus, B, C, D, E, F, unknown }

enum ProductAnalysis {
  yes,
  no,
  maybe;

  static ProductAnalysis fromString(String? analysis) {
    return switch (analysis) {
      'yes' => ProductAnalysis.yes,
      'no' => ProductAnalysis.no,
      'maybe' => ProductAnalysis.maybe,
      _ => ProductAnalysis.maybe,
    };
  }
}

Product generateProduct() => Product(
  barcode: '1234567890',
  name: 'Nutella',
  altName: 'Product Alt Name',
  picture:
      'https://images.openfoodfacts.org/images/products/301/762/042/5035/front_fr.533.400.jpg',
  quantity: '200g',
  brands: ['Ferrero', 'Ferrero'],
  manufacturingCountries: ['France', 'Italie'],
  nutriScore: ProductNutriScore.E,
  novaScore: ProductNovaScore.group4,
  greenScore: ProductGreenScore.D,
  ingredients: [
    'Sucre',
    'sirop de glucose',
    '_lait_ écrémé',
    'crème légère (_lait_)',
    'eau',
    'beurre de cacao',
    'matière grasse de noix de coco',
    '_lait_ écrémé concentré sucré',
    'pâte de cacao',
    'farine de _blé_',
    'matière grasse de palme',
    '_lait_ écrémé en poudre',
    '_lactose_',
    'matière grasse du _lait_',
    'huile de palmiste',
    'petit-_lait_ en poudre',
    'cacao maigre',
    'beurre (_lait_)',
    'émulsifiants (lécithine de _soja_, E471, tristéarate de sorbitane)',
    '_lait_ entier en poudre',
    'stabilisants (E407, E410, E412)',
    'arômes naturels (_lait_)',
    'sel',
    'colorant naturel (caramel ordinaire)',
    'cacao en poudre',
    'poudre à lever (E503)',
    'extrait naturel de vanille',
  ],
  ingredientsWithAllergens:
      'Sucre, sirop de glucose, <span class="allergen">lait</span> écrémé, crème légère (<span class="allergen">lait</span>), eau, beurre de cacao, matière grasse de noix de coco, <span class="allergen">lait</span> écrémé concentré sucré, pâte de cacao, farine de <span class="allergen">blé</span>, matière grasse de palme, <span class="allergen">lait</span> écrémé en poudre, <span class="allergen">lactose</span>, matière grasse du <span class="allergen">lait</span>, huile de palmiste, petit-<span class="allergen">lait</span> en poudre, cacao maigre, <span class="allergen">beurre</span> (<span class="allergen">lait</span>), émulsifiants (lécithine de <span class="allergen">soja</span>, E471, tristéarate de sorbitane), <span class="allergen">lait</span> entier en poudre, stabilisants (E407, E410, E412), arômes naturels (<span class="allergen">lait</span>), sel, colorant naturel (caramel ordinaire), cacao en poudre, poudre à lever (E503), extrait naturel de vanille. (Peut contenir<span class="allergen">: cacahuète</span>, <span class="allergen">noisette</span>, <span class="allergen">amande</span>).',
  traces: ['cacahuète', 'noisette', 'amande'],
  allergens: ['lait', 'soja', 'beurre'],
  additives: {'e322i': 'Description', 'e471': 'Description'},
  nutriScoreLevels: ProductNutriScoreLevels(
    energy: ProductNutriScoreLevel(
      points: 3,
      maxPoints: 10,
      unit: 'kJ',
      value: 1180,
      type: ProductNutriScoreLevelType.negative,
    ),
    saturatedFat: ProductNutriScoreLevel(
      points: 9,
      maxPoints: 10,
      unit: 'g',
      value: 9.05,
      type: ProductNutriScoreLevelType.negative,
    ),
    sugars: ProductNutriScoreLevel(
      points: 7,
      maxPoints: 15,
      unit: 'g',
      value: 25.5,
      type: ProductNutriScoreLevelType.negative,
    ),
    proteins: ProductNutriScoreLevel(
      points: 1,
      maxPoints: 7,
      unit: 'g',
      value: 3.5,
      type: ProductNutriScoreLevelType.positive,
    ),
    fiber: ProductNutriScoreLevel(
      points: 0,
      maxPoints: 5,
      unit: 'g',
      value: 0,
      type: ProductNutriScoreLevelType.unknown,
    ),
    salt: ProductNutriScoreLevel(
      points: 1,
      maxPoints: 20,
      unit: 'g',
      value: 0,
      type: ProductNutriScoreLevelType.positive,
    ),
    fruitsVegetablesLegumes: ProductNutriScoreLevel(
      points: 0,
      maxPoints: 5,
      unit: '%',
      value: 0,
      type: ProductNutriScoreLevelType.positive,
    ),
  ),
  nutrientLevels: NutrientLevels(
    salt: 'Low',
    saturatedFat: 'Low',
    sugars: 'Low',
    fat: 'Low',
  ),
  nutritionFacts: NutritionFacts(
    servingSize: '100g',
    calories: Nutriment(unit: 'kcal', perServing: 100, per100g: 100),
    fat: Nutriment(unit: 'g', perServing: 10, per100g: 10),
    saturatedFat: Nutriment(unit: 'g', perServing: 5, per100g: 5),
    carbohydrate: Nutriment(unit: 'g', perServing: 20, per100g: 20),
    sugar: Nutriment(unit: 'g', perServing: 10, per100g: 10),
    fiber: Nutriment(unit: 'g', perServing: 5, per100g: 5),
    proteins: Nutriment(unit: 'g', perServing: 10, per100g: 10),
    sodium: Nutriment(unit: 'mg', perServing: 100, per100g: 100),
    salt: Nutriment(unit: 'g', perServing: 0.1, per100g: 0.1),
  ),
);

class Response {
  final Product_API? produit;

  Response({this.produit});

  Response.fromJson(Map<String, dynamic> json) :
    produit = json['response'] != null ? Product_API.fromJson(json['response']) : null;
}

class Product_API {
  final String barcode;
  final String? name;
  final String? altName;
  final List<String>? brands;
  final String? nutriScore;
  final double? novaScore;
  final String? quantity;
  final List<String>? stores;
  final List<String>? countries;
  final List<String>? manufacturingCountries;
  final double? ecoScore;
  final String? ecoScoreGrade;
  final double? nutritionScore;
  final ProductPictures? pictures;
  final ProductIngredients? ingredients;
  final List<String>? traces;
  final Map<String, String>? additives;
  final List<String>? allergens;
  final List<String>? packaging;
  final ProductAnalyse? analysis;
  final ProductLevels? levels;
  final Nutrition_Facts? nutritionFacts;
  final Nutrient_Levels? NutrientLevels;

  Product_API({
    required this.barcode,
    this.name,
    this.altName,
    this.brands,
    this.nutriScore,
    this.novaScore,
    this.pictures,
    this.ingredients, 
    this.quantity, 
    this.stores, 
    this.countries, 
    this.manufacturingCountries, 
    this.ecoScore, 
    this.ecoScoreGrade, 
    this.nutritionScore, 
    this.traces,
    this.additives,
    this.allergens,
    this.analysis,
    this.levels,
    this.nutritionFacts,
    this.NutrientLevels,
    this.packaging

  });

  Product_API.fromJson(Map<String, dynamic> json) :
    barcode = json['barcode'],
    name = json['name'],
    altName = json['altName'],
    brands = json['brands'] != null ? List<String>.from(json['brands']) : null,
    nutriScore = json['nutriScore'],
    novaScore = double.tryParse(json['novaScore']?.toString() ?? ''),
    quantity = json['quantity'],
    stores = json['stores'] != null ? List<String>.from(json['stores']) : null,
    countries = json['countries'] != null ? List<String>.from(json['countries']) : null,
    manufacturingCountries = json['manufacturingCountries'] != null ? List<String>.from(json['manufacturingCountries']) : null,
    ecoScore = double.tryParse(json['ecoScore']?.toString() ?? ''),
    ecoScoreGrade = json['ecoScoreGrade'],
    nutritionScore = double.tryParse(json['nutritionScore']?.toString() ?? ''),
    pictures = json['pictures'] != null ? ProductPictures.fromJson(json['pictures']) : null,
    ingredients = json['ingredients'] != null ? ProductIngredients.fromJson(json['ingredients']) : null,
    traces = (json['traces'] != null && json['traces']['list'] != null) ? List<String>.from(json['traces']['list']) : null,
    additives = json['additives'] != null ? Map<String, String>.from(json['additives']) : null,
    allergens = (json['allergens'] != null && json['allergens']['list'] != null) ? List<String>.from(json['allergens']['list']) : null,
    packaging = json['packaging'] != null ? List<String>.from(json['packaging']) : null,
    analysis = json['analysis'] != null ? ProductAnalyse.fromJson(json['analysis']) : null,
    levels = json['levels'] != null ? ProductLevels.fromJson(json['levels']) : null,
    nutritionFacts = json['nutritionFacts'] != null ? Nutrition_Facts.fromJson(json['nutritionFacts']) : null,
    NutrientLevels = json['nutrientLevels'] != null ? Nutrient_Levels.fromJson(json['nutrientLevels']) : null;
    
}



class ProductPictures{
  final String? product;
  final String? front;
  final String? ingredients;
  final String? nutrition;

  ProductPictures({
    this.product,
    this.front,
    this.ingredients,
    this.nutrition,
  });

  ProductPictures.fromJson(Map<String, dynamic> json) :
    product = json['product'],
    front = json['front'],
    ingredients = json['ingredients'],
    nutrition = json['nutrition'];
}

class ProductIngredients {
  final List<String>? list;
  final bool? containsPalmOil;
  final String? whitAllegergens;
  final List<ProductDetails>? details;

  ProductIngredients({
    this.list,
    this.containsPalmOil,
    this.whitAllegergens,
    this.details,
  });

  ProductIngredients.fromJson(Map<String, dynamic> json) :
    list = json['list'] != null ? List<String>.from(json['list']) : null,
    containsPalmOil = json['containsPalmOil'],
    whitAllegergens = json['withAllergens'],
    details = json['details'] != null ? (json['details'] as List).map((i) => ProductDetails.fromJson(i)).toList() : null;

}

class ProductDetails{
  final bool? vegan;
  final bool? vegetarian;
  final bool? containsPalmOil;
  final double? percent;
  final String? value;

  ProductDetails({
    this.vegan,
    this.vegetarian,
    this.containsPalmOil,
    this.percent,
    this.value,
  });

  ProductDetails.fromJson(Map<String, dynamic> json) :
    vegan = json['vegan'],
    vegetarian = json['vegetarian'],
    containsPalmOil = json['containsPalmOil'],
    percent = double.tryParse(json['percent']?.toString() ?? ''),
    value = json['value'];
}

class Nutrient_Levels{
  final NutrientLevelsItems? fat;
  final NutrientLevelsItems? salt;
  final NutrientLevelsItems? saturatedFat;
  final NutrientLevelsItems? sugars;

  Nutrient_Levels({
    this.fat,
    this.salt,
    this.saturatedFat,
    this.sugars,
  });

  Nutrient_Levels.fromJson(Map<String, dynamic> json) :
    fat = json['fat'] != null ? NutrientLevelsItems.fromJson(json['fat']) : null,
    salt = json['salt'] != null ? NutrientLevelsItems.fromJson(json['salt']) : null,
    saturatedFat = json['saturatedFat'] != null ? NutrientLevelsItems.fromJson(json['saturatedFat']) : null,
    sugars = json['sugars'] != null ? NutrientLevelsItems.fromJson(json['sugars']) : null;
}

class NutrientLevelsItems{
  final String? level;
  final double? per100g;

  NutrientLevelsItems({
    this.level,
    this.per100g,
  });

  NutrientLevelsItems.fromJson(Map<String, dynamic> json) :
    level = json['level'],
    per100g = double.tryParse(json['per100g']?.toString() ?? '');
}

class Nutrition_Facts{
  final String? servingSize;
  final int? calories;
  final NutritionFactsItems? fat;
  final NutritionFactsItems? saturatedFat;
  final NutritionFactsItems? carbohydrate;
  final NutritionFactsItems? sugar;
  final NutritionFactsItems? fiber;
  final NutritionFactsItems? proteins;
  final NutritionFactsItems? sodium;
  final NutritionFactsItems? salt;
  final NutritionFactsItems? energy;

  Nutrition_Facts({
    this.servingSize,
    this.calories,
    this.fat,
    this.saturatedFat,
    this.carbohydrate,
    this.sugar,
    this.fiber,
    this.proteins,
    this.sodium,
    this.salt,
    this.energy
  });

  Nutrition_Facts.fromJson(Map<String, dynamic> json) :
    servingSize = json['servingSize'],
    calories = json['calories'],
    fat = json['fat'] != null ? NutritionFactsItems.fromJson(json['fat']) : null,
    saturatedFat = json['saturatedFat'] != null ? NutritionFactsItems.fromJson(json['saturatedFat']) : null,
    carbohydrate = json['carbohydrate'] != null ? NutritionFactsItems.fromJson(json['carbohydrate']) : null,
    sugar = json['sugar'] != null ? NutritionFactsItems.fromJson(json['sugar']) : null,
    fiber = json['fiber'] != null ? NutritionFactsItems.fromJson(json['fiber']) : null,
    proteins = json['proteins'] != null ? NutritionFactsItems.fromJson(json['proteins']) : null,
    sodium = json['sodium'] != null ? NutritionFactsItems.fromJson(json['sodium']) : null,
    salt = json['salt'] != null ? NutritionFactsItems.fromJson(json['salt']) : null,
    energy = json['energy'] != null ? NutritionFactsItems.fromJson(json['energy']) : null;
}

class NutritionFactsItems{
  final String? unit;
  final double? perServing;
  final double? per100g;

  NutritionFactsItems({
    this.unit,
    this.perServing,
    this.per100g,
  });

  NutritionFactsItems.fromJson(Map<String, dynamic> json) :
    unit = json['unit'],
    perServing = double.tryParse(json['perServing']?.toString() ?? ''),
    per100g = double.tryParse(json['per100g']?.toString() ?? '');
}

class ProductLevels{
  final ProductLevel? energy;
  final ProductLevel? fiber;
  final ProductLevel? fruitsVegetablesLegumes;
  final ProductLevel? proteins;
  final ProductLevel? salt;
  final ProductLevel? saturatedFat;
  final ProductLevel? sugars;

  ProductLevels({
    this.energy,
    this.fiber,
    this.fruitsVegetablesLegumes,
    this.proteins,
    this.salt,
    this.saturatedFat,
    this.sugars,
  });

  ProductLevels.fromJson(Map<String, dynamic> json) :
    energy = json['energy'] != null ? ProductLevel.fromJson(json['energy']) : null,
    fiber = json['fiber'] != null ? ProductLevel.fromJson(json['fiber']) : null,
    fruitsVegetablesLegumes = json['fruitsVegetablesLegumes'] != null ? ProductLevel.fromJson(json['fruitsVegetablesLegumes']) : null,
    proteins = json['proteins'] != null ? ProductLevel.fromJson(json['proteins']) : null,
    salt = json['salt'] != null ? ProductLevel.fromJson(json['salt']) : null,
    saturatedFat = json['saturatedFat'] != null ? ProductLevel.fromJson(json['saturatedFat']) : null,
    sugars = json['sugars'] != null ? ProductLevel.fromJson(json['sugars']) : null;

}

class ProductLevel{
  final double? points;
  final double? maxPoints;
  final String? unit;
  final double? value;
  final String? type;

  ProductLevel({
    this.points,
    this.maxPoints,
    this.unit,
    this.value,
    this.type,
  });

  ProductLevel.fromJson(Map<String, dynamic> json) :
    points = double.tryParse(json['points']?.toString() ?? ''),
    maxPoints = double.tryParse(json['maxPoints']?.toString() ?? ''),
    unit = json['unit'],
    value = double.tryParse(json['value']?.toString() ?? ''),
    type = json['type'];
}

class ProductAnalyse{
  final String? palmOil;
  final String? vegan;
  final String? vegetarian;

  ProductAnalyse({
    this.palmOil,
    this.vegan,
    this.vegetarian
  });

  ProductAnalyse.fromJson(Map<String, dynamic> json) :
    palmOil = json['palmOil'],
    vegan = json['vegan'],
    vegetarian = json['vegetarian'];
}