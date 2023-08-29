import 'package:email_validator/email_validator.dart';
import 'package:final_project/core/util/colors.dart';
import 'package:final_project/core/util/styles.dart';
import 'package:final_project/features/auth/provider/auth_provider.dart';
import 'package:final_project/features/auth/views/screens/register_view.dart';
import 'package:final_project/features/auth/views/widgets/secondary_button_widget.dart';
import 'package:final_project/shared/screens/home_screen.dart';
import 'package:final_project/features/auth/views/widgets/custom_text_form_field.dart';
import 'package:final_project/features/auth/views/widgets/primary_outlined_button_widget.dart';
import 'package:final_project/features/auth/views/widgets/curved_bacground.dart';
import 'package:final_project/shared/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/util/shared_mrthodes.dart';

class LoginView extends StatelessWidget {
  static const String id = '/loginView';

  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: CurvedBackground(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 68.0,
                    ),
                    Container(
                        color: kLightSub,
                        child: Hero(
                            tag: 'logo',
                            child: Logo.small(
                                style: kLogo.copyWith(fontSize: 22)))),
                    const SizedBox(
                      height: 18.0,
                    ),
                    const RegistrationForm(),
                  ],
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Colors.white.withOpacity(0.2),
              Colors.transparent
            ])),
          )
        ],
      ),
    );
  }
}

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({
    super.key,
  });

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 60),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(68)),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(onPressed: () {}, child: const Text('sign in')),
                OutlinedButton(onPressed: () {}, child: const Text('sign out')),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            CustomTextFormField(
              controller: emailController,
              hint: 'example@gmail.com',
              keyboardType: TextInputType.emailAddress,
              autofillHints: const [AutofillHints.email],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'please enter the email';
                } else if (!EmailValidator.validate(value)) {
                  return 'please enter a valid email';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 14,
            ),
            CustomTextFormField(
              controller: passwordController,
              hint: 'Enter password',
              autofillHints: const [AutofillHints.password],
              password: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'please enter the password';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 24,
            ),
            Consumer<AuthProvider>(
              builder: (context, provider, child) {
                return SecondaryButtonWidget(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        await provider.loginUser(
                            emailController.text, passwordController.text);
                        if (mounted) {
                          handelResponseStatus(
                            provider.loginResponse.status,
                            context,
                            message: provider.loginResponse.message,
                            onComplete: () async {
                              if (mounted) {
                                Navigator.pushReplacementNamed(
                                    context, HomeView.id);
                              }
                            },
                          );
                        }
                      }
                    },
                    text: 'LOGIN');
              },
            ),
            const SizedBox(
              height: 24,
            ),
            PrimaryOutlinedButtonWidget(
                onTap: () {
                  Navigator.pushNamed(context, RegisterView.id);
                },
                text: 'REGISTER'),
            const SizedBox(
              height: 12,
            ),
            Text(
              'OR',
              style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 18,
                  fontWeight: FontWeight.w300),
            ),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }
}
