import 'package:final_project/app_views/shared/custom_sized_box.dart';
import 'package:final_project/app_views/users_management/users_management_screen.dart';
import 'package:final_project/features/auth/views/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/util/shared_mrthodes.dart';
import '../../../../features/auth/views/widgets/auth_button.dart';
import '../../../shared/core_background.dart';

class CreateUserScreen extends StatefulWidget {
  static const String id = "create-user";

  const CreateUserScreen({Key? key}) : super(key: key);

  @override
  State<CreateUserScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  late TextEditingController confPasswordController;

  @override
  void initState() {
    _init();
    // TODO: implement initState
    super.initState();
  }

  void _init() {
    emailController = TextEditingController();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    confPasswordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Create User"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () =>
                Navigator.pushReplacementNamed(context, UsersManagement.id),
          ),
        ),
        body: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.only(
                    top: 0.1.sh, left: 20, right: 20, bottom: 20),
                child: Core(
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    key: _formKey,
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      const CustomTextFormField.username(),
                      CustomTextFormField.email(
                        controller: emailController,
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
                      const SSizedBox(
                        height: 14,
                      ),
                      CustomTextFormField.password(
                        controller: passwordController,
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
                      Padding(
                        padding: const EdgeInsets.only(top: 14.0),
                        child: CustomTextFormField.password(
                          controller: confPasswordController,
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
                      const SSizedBox(
                        height: 24,
                      ),
                      DropdownButtonFormField<String>(
                        hint: const Text("Role"),
                        items: const [
                          DropdownMenuItem(child: Text("ali")),
                        ],
                        onChanged: (_) {},
                      ),
                      const SSizedBox(
                        height: 40,
                      ),
                      AuthButton(onTap: () {}, text: 'create user'),

                      // Consumer<AuthProvider>(
                      //   builder: (context, provider, child) {
                      //     return AuthButton(
                      //         onTap: () async {
                      //           if (isSignin) {
                      //             await signIn(provider, context);
                      //           } else {
                      //             await signUp(provider, context);
                      //           }
                      //         },
                      //         text: isSignin ? 'Sign in' : 'Sign up');
                      //   },
                      // ),
                    ]),
                  ),
                )),
          ),
        ));
  }
}
