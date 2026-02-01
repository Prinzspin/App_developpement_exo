import 'dart:convert'; // pour decoder le json quand l'api renvoi une String

import 'package:dio/dio.dart' hide Response; // dio pour faire les requetes http (on cache Response car ya le notre)
import 'package:flutter/material.dart'; // widgets flutter de base
import 'package:formation_flutter/l10n/app_localizations.dart'; // traductions (labels)
import 'package:formation_flutter/model/product.dart' hide Response; // model produit (pareil on cache Response)
import 'package:formation_flutter/res/app_colors.dart'; // couleurs de l'app
import 'package:formation_flutter/res/app_icons.dart'; // icons custom (ecoscore)
import 'package:formation_flutter/res/app_theme_extension.dart'; // extension theme pour avoir title1/title2/title3
import 'package:provider/provider.dart'; // provider pour gerer le state facilement

import '../model/product.dart'; // contient Response / Product_API (le model API)

/// Page qui affiche un produit avec son image et ses scores
/// on reste en Stateless car le state est geré par ProductNotifier (ChangeNotifier)
class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  // hauteur fixe de l'image du produit en haut
  // c'est une const pour eviter de repeter le chiffre partout
  static const double IMAGE_HEIGHT = 300.0;

  @override
  Widget build(BuildContext context) {
    // ChangeNotifierProvider: crée le notifier et le met dispo dans l'arbre widget
    // du coup on peux faire Provider.of ou Consumer plus bas
    return ChangeNotifierProvider(
      create: (_) => ProductNotifier(),
      child: const _ProductScaffold(),
    );
  }
}

/// Scaffold separé juste pour pas avoir un build trop long
/// ca change rien au comportement, c'est juste plus rangé
class _ProductScaffold extends StatelessWidget {
  const _ProductScaffold();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Consumer: on écoute le notifier, et a chaque notifyListeners on rebuild ici
      body: Consumer<ProductNotifier>(
        builder: (context, notifier, child) {
          // on recup le produit courant
          final product = notifier.product;

          // si produit est null => soit ca charge encore, soit ca a échoué
          // ici on montre juste un spinner
          if (product == null) {
            return const _EcranChargement();
          }

          // Stack pour mettre image en haut + contenu en bas par dessus
          return SizedBox(
            child: Stack(
              children: [
                // la partie image en haut (positionné)
                PositionedDirectional(
                  top: 0.0,
                  start: 0.0,
                  end: 0.0,
                  height: ProductPage.IMAGE_HEIGHT,
                  child: Image.network(
                    // URL de l'image (si null on met string vide)
                    notifier.product?.picture ?? '',
                    fit: BoxFit.cover,

                    // cacheHeight pour eviter de charger une image enorme inutile
                    // ca prends en compte le devicePixelRatio pour que ce soit net
                    cacheHeight: (ProductPage.IMAGE_HEIGHT *
                            MediaQuery.devicePixelRatioOf(context))
                        .toInt(),
                  ),
                ),

                // la carte blanche en dessous (qui remonte un peu sur l'image)
                PositionedDirectional(
                  top: ProductPage.IMAGE_HEIGHT - 16.0,
                  start: 0.0,
                  end: 0.0,
                  bottom: 0.0,
                  child: Container(
                    decoration: const BoxDecoration(
                      // on arrondi seulement le haut pour faire un effet "sheet"
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16.0),
                      ),
                      color: Colors.white,
                    ),
                    // padding interne
                    padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: 20.0,
                      vertical: 30.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // nom du produit (style title1)
                        Text(
                          notifier.product?.name ?? '',
                          style: context.theme.title1,
                        ),

                        // marques du produit (join pour afficher "marque1, marque2")
                        Text(
                          notifier.product?.brands?.join(', ') ?? '',
                          style: context.theme.title2,
                        ),

                        // widget qui affiche nutri/nova/green
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

/// Widget qui regroupe les 3 infos: NutriScore / Nova / GreenScore
class Scores extends StatelessWidget {
  const Scores({super.key});

  @override
  Widget build(BuildContext context) {
    // on recup le produit une fois ici
    // ca evite de refaire Provider.of partout (meme si ca marche aussi)
    final prod = Provider.of<ProductNotifier>(context).product;

    return Column(
      children: [
        // IntrinsicHeight pour que le VerticalDivider prenne la hauteur des 2 colonnes
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // partie gauche: nutriscore
              Expanded(
                flex: 44,
                child: _Nutriscore(
                  // si null => on met unknown (comme ca ca crash pas)
                  nutriscore: prod?.nutriScore ?? ProductNutriScore.unknown,
                ),
              ),

              // separateur vertical entre nutri et nova
              const VerticalDivider(),

              // partie droite: groupe nova
              Expanded(
                flex: 56,
                child: _NovaGroup(
                  novaScore: prod?.novaScore ?? ProductNovaScore.unknown,
                ),
              ),
            ],
          ),
        ),

        // separateur horizontal
        const Divider(),

        // score environemental
        _GreenScore(
          greenScore: prod?.greenScore ?? ProductGreenScore.unknown,
        ),
      ],
    );
  }
}

/// Bloc qui affiche l'image du nutriscore (A/B/C/D/E)
class _Nutriscore extends StatelessWidget {
  const _Nutriscore({required this.nutriscore});

  // enum du nutriscore du produit
  final ProductNutriScore nutriscore;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // label traduit (nutriscore)
        Text(
          AppLocalizations.of(context)!.nutriscore,
          style: context.theme.title3,
        ),

        const SizedBox(height: 5.0),

        // image asset en fonction de la valeur (A/B/C...)
        Image.asset(_findAssetName(), height: 42.0),
      ],
    );
  }

  /// choisit le fichier image en fonction de l'enum
  /// c'est juste un mapping
  String _findAssetName() {
    return switch (nutriscore) {
      ProductNutriScore.A => 'res/drawables/nutriscore_a.png',
      ProductNutriScore.B => 'res/drawables/nutriscore_b.png',
      ProductNutriScore.C => 'res/drawables/nutriscore_c.png',
      ProductNutriScore.D => 'res/drawables/nutriscore_d.png',
      ProductNutriScore.E => 'res/drawables/nutriscore_e.png',
      ProductNutriScore.unknown => 'TODO', // pas encore geré proprement
    };
  }
}

/// Bloc qui affiche le groupe NOVA (1 a 4)
/// ici on affiche juste un texte explicatif
class _NovaGroup extends StatelessWidget {
  const _NovaGroup({required this.novaScore});

  final ProductNovaScore novaScore;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // label traduit
        Text(
          AppLocalizations.of(context)!.nova_group,
          style: context.theme.title3,
        ),

        const SizedBox(height: 5.0),

        // texte associer au score
        Text(
          _findLabel(),
          style: const TextStyle(color: AppColors.grey2),
        ),
      ],
    );
  }

  /// retourne un texte en fonction du groupe nova
  /// c'est ce qu'on veut montrer a l'utilisateur
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

/// Bloc qui affiche le GreenScore (ecoscore)
/// on met une icone + une couleur + un texte
class _GreenScore extends StatelessWidget {
  const _GreenScore({required this.greenScore});

  final ProductGreenScore greenScore;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // label traduit
        Text(
          AppLocalizations.of(context)!.greenscore,
          style: context.theme.title3,
        ),

        const SizedBox(height: 5.0),

        Row(
          children: <Widget>[
            // icone selon le score
            Icon(_findIcon(), color: _findIconColor()),

            const SizedBox(width: 10.0),

            // Expanded pour que le texte prenne la place et fasse des retours a la ligne
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

  /// retourne l'icone ecoscore (A+, A, B, ...)
  /// ca viens de AppIcons
  IconData _findIcon() {
    return switch (greenScore) {
      ProductGreenScore.APlus => AppIcons.ecoscore_a_plus,
      ProductGreenScore.A => AppIcons.ecoscore_a,
      ProductGreenScore.B => AppIcons.ecoscore_b,
      ProductGreenScore.C => AppIcons.ecoscore_c,
      ProductGreenScore.D => AppIcons.ecoscore_d,
      ProductGreenScore.E => AppIcons.ecoscore_e,
      ProductGreenScore.F => AppIcons.ecoscore_f,
      ProductGreenScore.unknown => AppIcons.ecoscore_e, // fallback un peu random
    };
  }

  /// retourne la couleur de l'icone selon le score
  /// plus c'est "bon", plus c'est vert
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

  /// retourne le texte "humain" associé au greenScore
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

/// widget test qui sert a rien ici, mais je le laisse comme dans ton fichier
class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    // placeholder vide
    return const Placeholder();
  }
}

/// ecran de chargement simple avec un CircularProgressIndicator
/// on le met en widget separé pour le reutiliser si besoin
class _EcranChargement extends StatelessWidget {
  const _EcranChargement();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

/// ProductNotifier = la "source de verité" des données produit
/// il charge un produit depuis l'API et notifie l'UI quand ca change
class ProductNotifier extends ChangeNotifier {
  // le produit chargé (null tant qu'on a rien recu)
  Product? _product = null;

  // petit flag pour savoir si ca charge
  bool _isLoading = false;

  // dio en champ pour eviter de le recréer dans chaque requete
  final Dio _dio = Dio();

  ProductNotifier() {
    // on prépare dio (headers etc)
    _initDio();

    // on lance direct un chargement pour avoir un produit a afficher
    loadProduct("5000159484695");
  }

  // getters public (comme ca on garde les champs en private)
  Product? get product => _product;
  bool get isLoading => _isLoading;

  /// configure dio (headers, options...)
  void _initDio() {
    // header user agent (bon la clé c'est peut etre pas la bonne mais je garde ton idée)
    _dio.options.headers['User-Agents'] =
        'FormationFlutter - Android - Version 1.0';
  }

  /// charge un produit depuis l'api en utilisant un barcode
  /// met _isLoading a true, puis une fois fini repasse a false
  Future<void> loadProduct(String barcode) async {
    _isLoading = true;
    notifyListeners(); // prevenu l'UI qu'on est en chargement

    try {
      // appel GET avec queryParameters => ?barcode=xxx
      final response = await _dio.get(
        'https://api.formation-flutter.fr/v2/getProduct',
        queryParameters: {'barcode': barcode},
      );

      // on check le code http
      if (response.statusCode == 200) {
        // parfois dio donne deja un Map, parfois une String json, donc on gère les 2
        final Map<String, dynamic> data =
            (response.data is String) ? jsonDecode(response.data) : response.data;

        // parse vers notre objet Response (celui du model API)
        final responseApi = Response.fromJson(data);

        // si produit existe, on converti vers le model "Product" de l'app
        // (responseApi est pas null normalement mais je garde un check)
        if (responseApi != null) {
          _product = _convertToProduct(responseApi.produit!);
        }
      }
    } catch (e) {
      // si y'a une erreur (reseau, parse, etc) on le log
      debugPrint("Erreur reseau $e");
    } finally {
      // quoi qu'il arrive on arrete le loading
      _isLoading = false;
      notifyListeners(); // l'UI se met a jour (spinner etc)
    }
  }

  /// converti le model API (Product_API) vers le model affichage (Product)
  /// c'est pratique car l'API et l'app on pas toujours les memes champs
  Product _convertToProduct(Product_API api) {
    return Product(
      name: api.name ?? "Nom inconnu", // fallback si nom null
      picture: api.pictures?.front, // image front si dispo
      barcode: api.barcode,
      brands: api.brands,
      altName: api.altName,

      // on map les scores qui sont pas exactement les memes formats
      nutriScore: _mapNutriScore(api.nutriScore),
      novaScore: _mapNovaScore(api.novaScore?.toInt()),
      greenScore: _mapGreenScore(api.ecoScoreGrade),
    );
  }

  /// transform le score nutri (String) en enum ProductNutriScore
  /// ex: "A" => ProductNutriScore.A
  ProductNutriScore? _mapNutriScore(String? score) {
    if (score == null) return null;

    // firstWhere pour retrouver l'enum qui match le name
    // orElse pour eviter un crash si valeur inconnue
    return ProductNutriScore.values.firstWhere(
      (e) => e.name.toLowerCase() == score.toLowerCase(),
      orElse: () => ProductNutriScore.unknown,
    );
  }

  /// transform le score nova (int) en enum
  /// 1 => group1, 2 => group2 etc
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
        // si la valeur est null ou autre => pas de score
        return null;
    }
  }

  /// transform le score eco (String) en enum ProductGreenScore
  /// attention: l'api peut renvoyer "a+" donc on le traite a part
  ProductGreenScore? _mapGreenScore(String? score) {
    if (score == 'a+') return ProductGreenScore.APlus;

    return ProductGreenScore.values.firstWhere(
      (e) => e.name.toLowerCase() == score?.toLowerCase(),
      orElse: () => ProductGreenScore.unknown,
    );
  }
}
