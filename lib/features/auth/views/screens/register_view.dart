import 'package:final_project/features/auth/views/widgets/secondary_button_widget.dart';
import 'package:final_project/features/auth/views/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  static const String id = '/registerView';

  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late TextEditingController nameController;

  late TextEditingController emailController;

  late TextEditingController passwordController;

  late TextEditingController confirmPasswordController;

  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
          //replace with our own icon data.
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height -
                AppBar().preferredSize.height,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Spacer(),
                  // SizedBox(
                  //     height: MediaQuery.of(context).size.height / 8,
                  //     child: Hero(
                  //         tag: 'authImage',
                  //         child: SvgPicture.asset(AssetsData.authImage))),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomTextFormField(
                    controller: nameController,
                    hint: 'John Doe',
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  CustomTextFormField(
                    controller: emailController,
                    hint: 'example@gmail.com',
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  CustomTextFormField(
                    controller: passwordController,
                    hint: 'Enter password',
                    password: true,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomTextFormField(
                    controller: confirmPasswordController,
                    hint: 'Confirm  Password',
                    password: true,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  SecondaryButtonWidget(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          // ApiHelper()
                          //     .register(context,
                          //         email: emailController.text,
                          //         name: nameController.text,
                          //         password: passwordController.text,
                          //         passwordConfirmation:
                          //             confirmPasswordController.text)
                          //     .catchError((e) {
                          //   showAlert(context, message: e.toString());
                          // });
                        }
                      },
                      text: 'REGISTER'),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    '-  or  -',
                    style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 18,
                        fontWeight: FontWeight.w300),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
