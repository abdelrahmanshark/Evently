import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/user.dart';
import 'package:evently/ui/home/home_screen.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_const.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:evently/utils/fire_base_utils.dart';
import 'package:evently/wigets/custom_alert_dialog.dart';
import 'package:evently/wigets/custom_elevated_button.dart';
import 'package:evently/wigets/custom_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../providers/app_local_provider.dart';
import '../../../providers/app_theme_provider.dart';
import '../../../providers/my_user_provider.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController(text: 'shark@gmail.com');

  final passwordController = TextEditingController(text: '123456');
  final rePasswordController = TextEditingController(text: '123456');
  final nameController = TextEditingController(text: 'shark');

  @override
  Widget build(BuildContext context) {
    final textFromLocal = AppLocalizations.of(context)!;
    final textStyle = Theme.of(context).textTheme;
    final localProvider = Provider.of<AppLocalProvider>(context);
    final themeProvider = Provider.of<AppThemeProvider>(context);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(textFromLocal.register, style: AppStyles.primaryMed20),
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.primaryColor),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(AppAssets.eventlyLogo),
                CustomTextFormField(
                  controller: nameController,
                  hintText: textFromLocal.name,
                  hasSuffixIcon: true,
                  prefixIcon: Icons.person_outline,
                  onValidator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return textFromLocal.please_enter_your_name;
                    }
                    return null;
                  },
                ),
                CustomTextFormField(
                  controller: emailController,
                  hintText: textFromLocal.email,
                  prefixIcon: Icons.email_outlined,
                  onValidator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return textFromLocal.please_enter_an_email;
                    }
                    final bool emailValid = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                    ).hasMatch(text);
                    if (!emailValid) {
                      return textFromLocal.please_enter_a_valid_email;
                    }
                    return null;
                  },
                ),
                CustomTextFormField(
                  controller: passwordController,
                  hintText: textFromLocal.password,
                  hasSuffixIcon: true,
                  suffixIcon: Icons.visibility_off_outlined,
                  prefixIcon: Icons.lock,
                  onValidator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return textFromLocal.please_enter_a_password;
                    }
                    if (text.length < 6) {
                      return textFromLocal.password_must_be_at_least_6_char;
                    }
                    return null;
                  },
                ),
                CustomTextFormField(
                  controller: rePasswordController,
                  hintText: textFromLocal.re_password,
                  hasSuffixIcon: true,
                  suffixIcon: Icons.visibility_off_outlined,
                  prefixIcon: Icons.lock,
                  onValidator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return textFromLocal.please_enter_a_password;
                    }
                    if (text != passwordController.text) {
                      return textFromLocal.re_password_dosnt_match;
                    }
                    return null;
                  },
                ),
                CustomElevatedButton(
                  onPressed: goToHomeScreen,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        textFromLocal.create_account,
                        style: AppStyles.whiteMed20,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      textFromLocal.already_have_account,
                      style: textStyle.bodyMedium,
                    ),
                    TextButton(
                      onPressed: gotoLoginScreen,
                      child: Text(
                        textFromLocal.login,
                        style: AppStyles.primaryBold16.copyWith(
                          decoration: TextDecoration.underline,
                          decorationThickness: 2,
                          decorationColor: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                AnimatedToggleSwitch<String>.rolling(
                  current: localProvider.appLocal,

                  values: ['en', 'ar'],
                  onChanged: (newLanguage) {
                    setState(() {
                      localProvider.changeLanguage(newLanguage);
                    });
                  },
                  iconList: [
                    SvgPicture.asset(AppAssets.englishFlag),
                    SvgPicture.asset(AppAssets.arabicFlag),
                  ],
                  height: 37,
                  style: ToggleStyle(
                    backgroundColor: Colors.transparent,
                    borderColor: AppColors.primaryColor,
                    indicatorColor: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void goToHomeScreen() async {
    var myUserProvider = Provider.of<MyUserProvider>(context, listen: false);
    var appConst = AppConst(context);
    if (formKey.currentState!.validate()) {
      setState(() {});
      CustomAlertDialog.showLoading(
          context: context, msg: appConst.text.loading);
      try {
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        if (credential.user?.uid == null) {
          CustomAlertDialog.hideLoading(context: context);
          return;
        }
        MyUsers newUser = MyUsers(id: credential.user!.uid,
            name: nameController.text,
            email: emailController.text);
        await FireBaseUtils.setUser(newUser);
        CustomAlertDialog.hideLoading(context: context);
        CustomAlertDialog.showMsg(
            context: context, msg: appConst.text.register_Successfully);


        myUserProvider.updateUser(newUser);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
              (route) => false,
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
          CustomAlertDialog.hideLoading(context: context);
          CustomAlertDialog.showMsg(context: context,
              msg: appConst.text.the_password_provided_is_too_weak);
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
          CustomAlertDialog.hideLoading(context: context);
          CustomAlertDialog.showMsg(context: context,
              msg: appConst.text.the_account_already_exists_for_that_email);
        }
      } catch (e) {
        print(e);
      }

    }
  }

  void gotoLoginScreen() {
    Navigator.pop(context);
  }
}
