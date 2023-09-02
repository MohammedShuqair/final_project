import 'package:final_project/core/util/assets.dart';
import 'package:final_project/core/util/colors.dart';
import 'package:final_project/features/auth/provider/auth_provider.dart';
import 'package:final_project/features/auth/views/widgets/auth_button.dart';
import 'package:final_project/features/auth/views/widgets/auth_option_button.dart';
import 'package:final_project/shared/screens/home_screen.dart';
import 'package:final_project/features/auth/views/widgets/custom_text_form_field.dart';
import 'package:final_project/features/auth/views/widgets/curved_bacground.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/util/shared_mrthodes.dart';

class AuthView extends StatelessWidget {
  static const String id = '/authView';

  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CurvedBackground(
        child: RegistrationForm(),
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
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  late TextEditingController confPasswordController;
  late FocusNode emailNode;
  late FocusNode passNode;
  late FocusNode confPasslNode;
  late FocusNode usernameNode;
  bool isSignin = true;
  bool get isSignup => !isSignin;

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  void dispose() {
    _dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 60),
      margin: const EdgeInsets.only(bottom: 38),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(68)),
      child: Form(
        key: _formKey,
        child: Column(children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: kBorder),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      if (isSignup) {
                        setState(() {
                          isSignin = true;
                        });
                        _sginInFocus();
                      }
                    },
                    child: AuthOption(
                      selectFactor: isSignin,
                      label: 'sign in',
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      if (isSignin) {
                        setState(() {
                          isSignin = false;
                          // ;
                        });
                        _signUpFocus();
                      }
                    },
                    child: AuthOption(
                      selectFactor: isSignup,
                      label: 'sign up',
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (isSignup)
            Padding(
              padding: const EdgeInsets.only(top: 14.0),
              child: CustomTextFormField.username(
                controller: usernameController,
                focusNode: usernameNode,
                validator: (value) {
                  if (testNull(value)) {
                    return 'Please click on the email field and enter your email';
                  } else if (testEmpty(value)) {
                    return 'Please enter the email and do not leave the field empty';
                  }
                  return null;
                },
              ),
            ),
          const SizedBox(
            height: 14,
          ),
          CustomTextFormField.email(
            controller: emailController,
            focusNode: emailNode,
            validator: (value) {
              if (testNull(value)) {
                return 'Please click on the email field and enter your email';
              } else if (testEmpty(value)) {
                return 'Please enter the email and do not leave the field empty';
              } else if (!testEmailValidation(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 14,
          ),
          CustomTextFormField.password(
            controller: passwordController,
            focusNode: passNode,
            textInputAction:
                isSignin ? TextInputAction.done : TextInputAction.next,
            validator: (value) {
              if (testNull(value)) {
                return 'Please click on the password field and enter your password';
              } else if (testEmpty(value)) {
                return 'Please enter the password and do not leave the field empty';
              } else if (testPasswordLength(value)) {
                return 'The password must contain at least 6 characters';
              }
              return null;
            },
          ),
          if (isSignup)
            Padding(
              padding: const EdgeInsets.only(top: 14.0),
              child: CustomTextFormField.password(
                controller: confPasswordController,
                focusNode: confPasslNode,
                textInputAction: TextInputAction.done,
                hint: 'Confirm Password',
                validator: (value) {
                  if (testNull(value)) {
                    return 'Please click on the confirm password field and enter your password';
                  } else if (testEmpty(value)) {
                    return 'Please enter the confirm password and do not leave the field empty';
                  } else if (testPasswordLength(value)) {
                    return 'The confirm password must contain at least 6 characters';
                  } else if (passwordController.text !=
                      confPasswordController.text) {
                    return 'The confirm password must be the same as password';
                  }
                  return null;
                },
              ),
            ),
          const SizedBox(
            height: 24,
          ),
          Consumer<AuthProvider>(
            builder: (context, provider, child) {
              return AuthButton(
                  onTap: () async {
                    if (isSignin) {
                      await signIn(provider, context);
                    } else {
                      await signUp(provider, context);
                    }
                  },
                  text: isSignin ? 'Sign in' : 'Sign up');
            },
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 25.0),
            child: Text(
              'OR',
              style: TextStyle(
                color: kSubText,
              ),
            ),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SocialButton(facebook),
              SocialButton(twitter),
              SocialButton(google),
            ],
          ),
        ]),
      ),
    );
  }

  Future<void> signIn(AuthProvider provider, BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      await provider.loginUser(emailController.text, passwordController.text);
      if (mounted) {
        handelResponseStatus(
          provider.loginResponse.status,
          context,
          message: provider.loginResponse.message,
          onComplete: () async {
            if (mounted) {
              Navigator.pushReplacementNamed(context, HomeView.id);
            }
          },
        );
      }
    }
  }

  Future<void> signUp(AuthProvider provider, BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      await provider.registerUser(emailController.text, usernameController.text,
          passwordController.text, confPasswordController.text);
      if (mounted) {
        handelResponseStatus(
          provider.registerResponse.status,
          context,
          message: provider.registerResponse.message,
          onComplete: () async {
            if (mounted) {
              Navigator.pushReplacementNamed(context, HomeView.id);
            }
          },
        );
      }
    }
  }

  void _signUpFocus() {
    Future.delayed(const Duration(milliseconds: 50), () {
      if (usernameController.text.isEmpty) {
        usernameNode.requestFocus();
      } else if (emailController.text.isEmpty) {
        emailNode.requestFocus();
      } else if (passwordController.text.isEmpty) {
        passNode.requestFocus();
      } else if (confPasswordController.text.isEmpty) {
        confPasslNode.requestFocus();
      }
    });
  }

  void _sginInFocus() {
    Future.delayed(const Duration(milliseconds: 50), () {
      if (emailController.text.isEmpty) {
        emailNode.requestFocus();
        return;
      } else if (passwordController.text.isEmpty) {
        passNode.requestFocus();
        return;
      }
    });
  }

  void _init() {
    passNode = FocusNode();
    confPasslNode = FocusNode();
    usernameNode = FocusNode();
    emailNode = FocusNode();
    emailController = TextEditingController();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    confPasswordController = TextEditingController();
    Future.delayed(const Duration(seconds: 3), () {
      if (isSignin) {
        emailNode.requestFocus();
      }
    });
  }

  void _dispose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    confPasswordController.dispose();
    usernameNode.dispose();
    passNode.dispose();
    confPasslNode.dispose();
    emailNode.dispose();
  }
}

class SocialButton extends StatelessWidget {
  const SocialButton(
    this.path, {
    super.key,
  });
  final String path;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          shape: BoxShape.circle, border: Border.all(color: kUnselect)),
      child: SvgPicture.asset(
        path,
        width: 35,
        height: 35,
      ),
    );
  }
}
