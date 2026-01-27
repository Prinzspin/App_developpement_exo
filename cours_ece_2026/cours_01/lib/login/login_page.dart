import 'package:cours_01/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Log in or sign up',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.8,
          child: Column(
            children: [
              EmailAddress(
                valueChanged: (String value) {
                  print(value);
                  _email = value;
                  setState(() {});
                },
              ),
              ContinueButton(onPressed: _email.length > 0 ? () {} : null),
              OrDivider(),
              ContinueWithButton(
                label: 'Continue with Apple',
                asset: 'assets/apple_logo.svg',
                onPressed: () {},
              ),
              ContinueWithButton(
                label: 'Continue with Google',
                asset: 'assets/google_logo.svg',
                onPressed: () {},
              ),
              ContinueWithButton(
                label: 'Continue with Facebook',
                asset: 'assets/facebook_logo.svg',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EmailAddress extends StatelessWidget {
  const EmailAddress({required this.valueChanged, super.key});

  final ValueChanged<String> valueChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: false,
      onChanged: valueChanged,
      style: TextStyle(color: AppColors.textPrimary),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.email_outlined),
        hintText: 'Email Address',
        hintStyle: TextStyle(color: AppColors.textSecondary),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: AppColors.inputFieldActiveBackground),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: AppColors.inputFieldInactiveBackground),
        ),
      ),
    );
  }
}

class ContinueButton extends StatelessWidget {
  const ContinueButton({Key? key, this.onPressed}) : super(key: key);

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(
        foregroundColor: AppColors.buttonPrimaryText,
        backgroundColor: AppColors.buttonPrimaryBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      onPressed: onPressed,
      child: Text('Continue', style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider()),
        Text('Or', style: TextStyle(color: AppColors.textSecondary)),
        Expanded(child: Divider()),
      ],
    );
  }
}

class ContinueWithButton extends StatelessWidget {
  const ContinueWithButton({
    required this.asset,
    required this.label,
    required this.onPressed,
    super.key,
  });

  final String label;
  final String asset;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(
        foregroundColor: AppColors.buttonSecondaryText,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: BorderSide(color: AppColors.buttonSecondaryBackground),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        children: [
          SvgPicture.asset(asset),
          Expanded(child: Text(label, textAlign: TextAlign.center)),
        ],
      ),
    );
  }
}
