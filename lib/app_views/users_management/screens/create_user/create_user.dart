import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/app_views/shared/alert.dart';
import 'package:final_project/app_views/shared/custom_sized_box.dart';
import 'package:final_project/app_views/shared/sub_app_bar.dart';
import 'package:final_project/app_views/users_management/users_management_screen.dart';
import 'package:final_project/core/util/constants.dart';
import 'package:final_project/features/auth/model/role.dart';
import 'package:final_project/features/auth/views/widgets/custom_text_form_field.dart';
import 'package:final_project/features/user_management/repo.dart';
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
  int? roleId;
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
    roleId = null;
  }

  @override
  void dispose() {
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SubAppBar(
          title: context.tr("Create User"),
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
                      CustomTextFormField.username(
                        controller: usernameController,
                        validator: (value) {
                          if (testEmpty(value)) {
                            return context.tr('Please enter username');
                          }
                          return null;
                        },
                      ),
                      CustomTextFormField.email(
                        controller: emailController,
                        validator: (value) {
                          if (testNull(value)) {
                            return context.tr(
                                'Please click on the email field and enter your email');
                          } else if (testEmpty(value)) {
                            return context.tr(
                                'Please enter the email and do not leave the field empty');
                          } else if (!testEmailValidation(value)) {
                            return context.tr('Please enter a valid email');
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
                            return context.tr(
                                'Please click on the password field and enter your password');
                          } else if (testEmpty(value)) {
                            return context.tr(
                                'Please enter the password and do not leave the field empty');
                          } else if (testPasswordLength(value)) {
                            return context.tr(
                                'The password must contain at least 6 characters');
                          }
                          return null;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 14.0),
                        child: CustomTextFormField.password(
                          controller: confPasswordController,
                          textInputAction: TextInputAction.done,
                          hint: context.tr('Confirm Password'),
                          validator: (value) {
                            if (testNull(value)) {
                              return context.tr(
                                  'Please click on the confirm password field and enter your password');
                            } else if (testEmpty(value)) {
                              return context.tr(
                                  'Please enter the confirm password and do not leave the field empty');
                            } else if (testPasswordLength(value)) {
                              return context.tr(
                                  'The confirm password must contain at least 6 characters');
                            } else if (passwordController.text !=
                                confPasswordController.text) {
                              return context.tr(
                                  'The confirm password must be the same as password');
                            }
                            return null;
                          },
                        ),
                      ),
                      const SSizedBox(
                        height: 24,
                      ),
                      Row(
                        children: [
                          Text(context.tr("Role")),
                          const SSizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: DropdownButtonFormField<int>(
                              validator: (v) {
                                if (v == null) {
                                  return 'Please select user role';
                                }
                                return null;
                              },
                              value: roleId,
                              hint: Text(context.tr("select role")),
                              items: defaultRoles
                                  .map(
                                    (e) => DropdownMenuItem<int>(
                                      onTap: () => setState(() {
                                        roleId = e.id;
                                      }),
                                      value: e.id,
                                      child: Text(context.tr(e.name ?? 'Name')),
                                    ),
                                  )
                                  .toList() /*const [
                                DropdownMenuItem(child: Text("ali")),
                              ]*/
                              ,
                              onChanged: (_) {},
                            ),
                          ),
                        ],
                      ),
                      const SSizedBox(
                        height: 40,
                      ),
                      AuthButton(
                          onTap: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              UserManagementRepository()
                                  .createUser(
                                      emailController.text,
                                      usernameController.text,
                                      passwordController.text,
                                      confPasswordController.text,
                                      roleId!.toString())
                                  .then((user) {
                                showAlert(context,
                                    message:
                                        '${user.name} created successfully',
                                    isError: false);
                                setState(() {
                                  _init();
                                });
                              }).catchError((e) {
                                showAlert(context, message: e.toString());
                              });
                            }
                          },
                          text: context.tr('create user')),
                    ]),
                  ),
                )),
          ),
        ));
  }
}
