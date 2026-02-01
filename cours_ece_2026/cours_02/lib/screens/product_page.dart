import 'dart:convert';

import 'package:dio/dio.dart' hide Response;
import 'package:flutter/material.dart';
import 'package:formation_flutter/l10n/app_localizations.dart';
import 'package:formation_flutter/model/product.dart' hide Response;
import 'package:formation_flutter/res/app_colors.dart';
import 'package:formation_flutter/res/app_icons.dart';
import 'package:formation_flutter/res/app_theme_extension.dart';
import 'package:provider/provider.dart';

import '../model/product.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  // hauteur de l'image, a pas trop toucher
  static const double IMAGE_HEIGHT = 300.0;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductNotifier(),
      child: const _ProductScaffold(),
    );
  }
}

// petit widget separé, juste pour range un peu le code
class _ProductScaffold extends StatelessWidget {
  const _ProductScaffold();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ProductNotifier>(
        builder: (context, notifier, child) {
          final product = notifier.product;

          // si ya rien, on montre le chargemnt
          if (product == null) {
            return const _EcranChargement();
          }

          return SizedBox(
            child: Stack(
              children: [
                PositionedDirectional(
                  top: 0.0,
                  start: 0.0,
                  end: 0.0,
                  height: ProductPage.IMAGE_HEIGHT,
                  child: Image.network(
                    notifier.product?.picture ?? '',
                    fit: BoxFit.cover,
                    cacheHeight: (ProductPage.IMAGE_HEIGHT *
                            MediaQuery.devicePixelRatioOf(context))
                        .toInt(),
                  ),
                ),
                PositionedDirectional(
                  top: ProductPage.IMAGE_HEIGHT - 16.0,
                  start: 0.0,
                  end: 0.0,
                  bottom: 0.0,
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16.0),
                      ),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: 20.0,
                      vertical: 30.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notifier.product?.name ?? '',
                          style: context.theme.title1,
                        ),
                        Text(
                          notifier.product?.brands?.join(', ') ?? '',
                          style: context.theme.title2,
                        ),
                        const Scores(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class Scores extends StatelessWidget {
  const Scores({super.key});

  @override
  Widget build(BuildContext context) {
    // on lis le produit ici une fois (evite de repeter Provider.of)
    final prod = Provider.of<ProductNotifier>(context).product;

    return Column(
      children: [
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 44,
                child: _Nutriscore(
                  nutriscore: prod?.nutriScore ?? ProductNutriScore.unknown,
                ),
              ),
              const VerticalDivider(),
              Expanded(
                flex: 56,
                child: _NovaGroup(
                  novaScore: prod?.novaScore ?? ProductNovaScore.unknown,
                ),
              ),
            ],
          ),
        ),
        const Divider(),
        _GreenScore(
          greenScore: prod?.greenScore ?? ProductGreenScore.unknown,
        ),
      ],
    );
  }
}

class _Nutriscore extends StatelessWidget {
  const _Nutriscore({required this.nutriscore});

  final ProductNutriScore nutriscore;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          AppLocalizations.of(context)!.nutriscore,
          style: context.theme.title3,
        ),
        const SizedBox(height: 5.0),
        Image.asset(_findAssetName(), height: 42.0),
      ],
    );
  }

  // trouve le bon asset a afficher
  String _findAssetName() {
    return switch (nutriscore) {
      ProductNutriScore.A => 'res/drawables/nutriscore_a.png',
      ProductNutriScore.B => 'res/drawables/nutriscore_b.png',
      ProductNutriScore.C => 'res/drawables/nutriscore_c.png',
      ProductNutriScore.D => 'res/drawables/nutriscore_d.png',
      ProductNutriScore.E => 'res/drawables/nutriscore_e.png',
      ProductNutriScore.unknown => 'TODO',
    };
  }
}

class _NovaGroup extends StatelessWidget {
  const _NovaGroup({required this.novaScore});

  final ProductNovaScore novaScore;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          AppLocalizations.of(context)!.nova_group,
          style: context.theme.title3,
        ),
        const SizedBox(height: 5.0),
        Text(
          _findLabel(),
          style: const TextStyle(color: AppColors.grey2),
        ),
      ],
    );
  }

  String _findLabel() {
    return switch (novaScore) {
      ProductNovaScore.group1 =>
        'Aliments non transformés ou transformés minimalement',
      ProductNovaScore.group2 => 'Ingrédients culinaires transformés',
      ProductNovaScore.group3 => 'Aliments transformés',
      ProductNovaScore.group4 =>
        'Produits alimentaires et boissons ultra-transformés',
      ProductNovaScore.unknown => 'Score non calculé',
    };
  }
}

class _GreenScore extends StatelessWidget {
  const _GreenScore({required this.greenScore});

  final ProductGreenScore greenScore;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          AppLocalizations.of(context)!.greenscore,
          style: context.theme.title3,
        ),
        const SizedBox(height: 5.0),
        Row(
          children: <Widget>[
            Icon(_findIcon(), color: _findIconColor()),
            const SizedBox(width: 10.0),
            Expanded(
              child: Text(
                _findLabel(),
                style: const TextStyle(color: AppColors.grey2),
              ),
            ),
          ],
        ),
      ],
    );
  }

  IconData _findIcon() {
    return switch (greenScore) {
      ProductGreenScore.APlus => AppIcons.ecoscore_a_plus,
      ProductGreenScore.A => AppIcons.ecoscore_a,
      ProductGreenScore.B => AppIcons.ecoscore_b,
      ProductGreenScore.C => AppIcons.ecoscore_c,
      ProductGreenScore.D => AppIcons.ecoscore_d,
      ProductGreenScore.E => AppIcons.ecoscore_e,
      ProductGreenScore.F => AppIcons.ecoscore_f,
      ProductGreenScore.unknown => AppIcons.ecoscore_e,
    };
  }

  // couleur selon l'impact envrionemental
  Color _findIconColor() {
    return switch (greenScore) {
      ProductGreenScore.APlus => AppColors.greenScoreAPlus,
      ProductGreenScore.A => AppColors.greenScoreA,
      ProductGreenScore.B => AppColors.greenScoreB,
      ProductGreenScore.C => AppColors.greenScoreC,
      ProductGreenScore.D => AppColors.greenScoreD,
      ProductGreenScore.E => AppColors.greenScoreE,
      ProductGreenScore.F => AppColors.greenScoreF,
      ProductGreenScore.unknown => Colors.transparent,
    };
  }

  String _findLabel() {
    return switch (greenScore) {
      ProductGreenScore.APlus => 'Très faible impact environnemental',
      ProductGreenScore.A => 'Très faible impact environnemental',
      ProductGreenScore.B => 'Faible impact environnemental',
      ProductGreenScore.C => "Impact modéré sur l'environnement",
      ProductGreenScore.D => 'Impact environnemental élevé',
      ProductGreenScore.E => 'Impact environnemental très élevé',
      ProductGreenScore.F => 'Impact environnemental très élevé',
      ProductGreenScore.unknown => 'Score non calculé',
    };
  }
}

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class _EcranChargement extends StatelessWidget {
  const _EcranChargement();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class ProductNotifier extends ChangeNotifier {
  Product? _product = null;
  bool _isLoading = false;

  // dio en champ, comme ca on recrée pas l'instance 50 fois
  final Dio _dio = Dio();

  ProductNotifier() {
    _initDio();
    loadProduct("5000159484695");
  }

  Product? get product => _product;
  bool get isLoading => _isLoading;

  void _initDio() {
    // config de base (header)
    _dio.options.headers['User-Agents'] =
        'FormationFlutter - Android - Version 1.0';
  }

  Future<void> loadProduct(String barcode) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _dio.get(
        'https://api.formation-flutter.fr/v2/getProduct',
        queryParameters: {'barcode': barcode},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data =
            (response.data is String) ? jsonDecode(response.data) : response.data;

        final responseApi = Response.fromJson(data);

        // ya un check en plus, au cas ou
        if (responseApi != null) {
          _product = _convertToProduct(responseApi.produit!);
        }
      }
    } catch (e) {
      debugPrint("Erreur reseau $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // converti le model API en model app
  Product _convertToProduct(Product_API api) {
    return Product(
      name: api.name ?? "Nom inconnu",
      picture: api.pictures?.front,
      barcode: api.barcode,
      brands: api.brands,
      altName: api.altName,
      nutriScore: _mapNutriScore(api.nutriScore),
      novaScore: _mapNovaScore(api.novaScore?.toInt()),
      greenScore: _mapGreenScore(api.ecoScoreGrade),
    );
  }

  // mapping score => enum
  ProductNutriScore? _mapNutriScore(String? score) {
    if (score == null) return null;
    return ProductNutriScore.values.firstWhere(
      (e) => e.name.toLowerCase() == score.toLowerCase(),
      orElse: () => ProductNutriScore.unknown,
    );
  }

  ProductNovaScore? _mapNovaScore(int? score) {
    switch (score) {
      case 1:
        return ProductNovaScore.group1;
      case 2:
        return ProductNovaScore.group2;
      case 3:
        return ProductNovaScore.group3;
      case 4:
        return ProductNovaScore.group4;
      default:
        return null;
    }
  }

  ProductGreenScore? _mapGreenScore(String? score) {
    if (score == 'a+') return ProductGreenScore.APlus;
    return ProductGreenScore.values.firstWhere(
      (e) => e.name.toLowerCase() == score?.toLowerCase(),
      orElse: () => ProductGreenScore.unknown,
    );
  }
}
