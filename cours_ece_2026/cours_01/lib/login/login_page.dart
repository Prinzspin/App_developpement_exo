import 'package:flutter/material.dart';

// Couleurs (à adapter plus tard à ton vrai thème)
const Color textPrimary = Colors.black;
const Color textSecondary = Colors.grey;

const Color inputFieldInactiveBackground = Color(0xFFE9EEF5);
const Color inputFieldActiveBackground = Color(0xFFBFD3FF);

const Color buttonPrimaryText = Colors.white;
const Color buttonPrimaryBackground = Color(0xFF2C8AA0);

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login in or sign up',
          style: TextStyle(
            color: textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            EmailField(),
            SizedBox(height: 16),
            ContinueButton(onPressed: null),
          ],
        ),
      ),
    );
  }
}

// -------- Champ email --------
class EmailField extends StatelessWidget {
  const EmailField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: false,
      style: const TextStyle(color: textPrimary),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.email_outlined),
        hintText: 'Email address',
        hintStyle: const TextStyle(color: textSecondary),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: inputFieldInactiveBackground),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: inputFieldActiveBackground),
        ),
      ),
    );
  }
}

// -------- Bouton Continuer --------
class ContinueButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const ContinueButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        foregroundColor: buttonPrimaryText,
        backgroundColor: buttonPrimaryBackground,
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: const Text('Continue'),
    );
  }
}
