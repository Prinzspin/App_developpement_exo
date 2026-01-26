import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Couleurs
const Color kTitleColor = Color(0xFF0B1320);
const Color kHintColor = Color(0xFF9AA4B2);

const Color kInputFill = Color(0xFFF2F5F9);
const Color kInputBorder = Color(0xFFE2E8F0);

const Color kPrimaryButton = Color(0xFF3F8799);
const Color kPrimaryButtonDisabled = Color(0xFFB5C9CF);

const Color kSocialBorder = Color(0xFFD9E1EA);

/// ===============================
/// PAGE LOGIN (STATEFUL)
/// ===============================
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controller pour lire le texte du champ
  final TextEditingController _emailController = TextEditingController();

  // État : est-ce que l'email est vide ?
  bool get isEmailEmpty => _emailController.text.isEmpty;

  @override
  void initState() {
    super.initState();

    // On écoute chaque changement du champ
    _emailController.addListener(() {
      // À chaque frappe, on reconstruit l'UI
      setState(() {});
    });
  }

  @override
  void dispose() {
    // Toujours libérer les controllers
    _emailController.dispose();
    super.dispose();
  }

  void _onContinue() {
    debugPrint('Email: ${_emailController.text}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const HeaderTitle(),
              const SizedBox(height: 22),

              // Champ email avec controller
              EmailField(controller: _emailController),
              const SizedBox(height: 18),

              // Bouton dépend de l'état
              PrimaryContinueButton(
                enabled: !isEmailEmpty,
                onPressed: isEmailEmpty ? null : _onContinue,
              ),

              const SizedBox(height: 18),
              const OrDivider(),
              const SizedBox(height: 18),

              const AppleButton(),
              const SizedBox(height: 14),
              const GoogleButton(),
              const SizedBox(height: 14),
              const FacebookButton(),
            ],
          ),
        ),
      ),
    );
  }
}

/// ======================
/// Titre
/// ======================
class HeaderTitle extends StatelessWidget {
  const HeaderTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Log in or sign up',
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w800,
        color: kTitleColor,
      ),
    );
  }
}

/// ======================
/// Champ Email
/// ======================
class EmailField extends StatelessWidget {
  const EmailField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        filled: true,
        fillColor: kInputFill,
        prefixIcon: const Icon(Icons.mail_outline),
        hintText: 'Email Address',
        hintStyle: const TextStyle(color: kHintColor),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 14,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: kInputBorder, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: kPrimaryButton, width: 1.5),
        ),
      ),
    );
  }
}

/// ======================
/// Bouton Continue (STATE DEPENDANT)
/// ======================
class PrimaryContinueButton extends StatelessWidget {
  const PrimaryContinueButton({
    super.key,
    required this.enabled,
    required this.onPressed,
  });

  final bool enabled;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: FilledButton(
        onPressed: onPressed, // null => désactivé
        style: FilledButton.styleFrom(
          backgroundColor: enabled ? kPrimaryButton : kPrimaryButtonDisabled,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: const Text(
          'Continue',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

/// ======================
/// Or
/// ======================
class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(child: Divider()),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'Or',
            style: TextStyle(color: kHintColor, fontWeight: FontWeight.w600),
          ),
        ),
        Expanded(child: Divider()),
      ],
    );
  }
}

/// ======================
/// Boutons sociaux
/// ======================

class AppleButton extends StatelessWidget {
  const AppleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SocialButton(
      label: 'Continue with Apple',
      assetPath: 'assets/apple_logo.svg',
      onPressed: () {},
    );
  }
}

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SocialButton(
      label: 'Continue with Google',
      assetPath: 'assets/google_logo.svg',
      onPressed: () {},
    );
  }
}

class FacebookButton extends StatelessWidget {
  const FacebookButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SocialButton(
      label: 'Continue with Facebook',
      assetPath: 'assets/facebook_logo.svg',
      onPressed: () {},
    );
  }
}

/// ======================
/// Widget générique social
/// ======================
class SocialButton extends StatelessWidget {
  const SocialButton({
    super.key,
    required this.label,
    required this.assetPath,
    required this.onPressed,
  });

  final String label;
  final String assetPath;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          side: const BorderSide(color: kSocialBorder, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: SvgPicture.asset(assetPath, width: 24, height: 24),
            ),
            Text(
              label,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: kTitleColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
