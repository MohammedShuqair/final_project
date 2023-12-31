import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/app_views/home/views/home_screen.dart';
import 'package:final_project/app_views/shared/custom_sized_box.dart';
import 'package:final_project/core/util/assets.dart';
import 'package:final_project/core/util/colors.dart';
import 'package:final_project/features/auth/provider/auth_provider.dart';
import 'package:final_project/features/auth/views/widgets/auth_button.dart';
import 'package:final_project/features/auth/views/widgets/auth_option_button.dart';
import 'package:final_project/features/auth/views/widgets/custom_text_form_field.dart';
import 'package:final_project/features/auth/views/widgets/curved_bacground.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/util/shared_methodes.dart';

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
  Duration duration = const Duration(milliseconds: 700);
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
            child: IntrinsicHeight(
              child: Stack(
                children: [
                  AnimatedAlign(
                    alignment: isSignin
                        ? AlignmentDirectional.centerStart
                        : AlignmentDirectional.centerEnd,
                    duration: duration,
                    child: Container(
                      // height: 70,
                      width: 120.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: kDarkSub),
                    ),
                  ),
                  Row(
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
                            label: context.tr('login'),
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
                            label: context.tr('signup'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          AnimatedContainer(
            duration: duration,
            height: isSignup ? 60 : 0,
            child: Padding(
              padding: const EdgeInsets.only(top: 14.0),
              child: CustomTextFormField.username(
                controller: isSignup ? usernameController : null,
                focusNode: isSignup ? usernameNode : null,
                validator: isSignup
                    ? (value) {
                        if (testEmpty(value)) {
                          return context.tr('pl_username');
                        }
                        return null;
                      }
                    : null,
              ),
            ),
          ),
          const SSizedBox(
            height: 14,
          ),
          CustomTextFormField.email(
            controller: emailController,
            focusNode: emailNode,
            validator: (value) {
              if (testNull(value)) {
                return context.tr('pl_email');
              } else if (testEmpty(value)) {
                return context.tr('pl_email');
              } else if (!testEmailValidation(value)) {
                return context.tr('pl_valid_email');
              }
              return null;
            },
          ),
          const SSizedBox(
            height: 14,
          ),
          CustomTextFormField.password(
            controller: passwordController,
            focusNode: passNode,
            textInputAction:
                isSignin ? TextInputAction.done : TextInputAction.next,
            validator: (value) {
              if (testNull(value)) {
                return context.tr("pl_password");
              } else if (testEmpty(value)) {
                return context.tr("pl_password");
              } else if (testPasswordLength(value)) {
                return context.tr("pl_len");
              }
              return null;
            },
          ),
          AnimatedContainer(
            duration: duration,
            height: isSignup ? 60 : 0,
            child: Padding(
              padding: const EdgeInsets.only(top: 14.0),
              child: CustomTextFormField.password(
                controller: isSignup ? confPasswordController : null,
                focusNode: isSignup ? confPasslNode : null,
                textInputAction: TextInputAction.done,
                hint: context.tr('confirm_password'),
                validator: isSignup
                    ? (value) {
                        if (testNull(value)) {
                          return context.tr("pl_confirm");
                        } else if (testEmpty(value)) {
                          return context.tr("pl_confirm");
                        } else if (testPasswordLength(value)) {
                          return context.tr("pl_len");
                        } else if (passwordController.text !=
                            confPasswordController.text) {
                          return context.tr("pl_match");
                        }
                        return null;
                      }
                    : null,
              ),
            ),
          ),
          const SSizedBox(
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
                  text: isSignin ? context.tr('login') : context.tr('signup'));
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0),
            child: Text(
              context.tr('or'),
              style: const TextStyle(
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
              Navigator.pushNamedAndRemoveUntil(
                  context, HomeView.id, (p) => false);
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
              Navigator.pushNamedAndRemoveUntil(
                  context, HomeView.id, (p) => false);
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
