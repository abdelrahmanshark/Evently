import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/user.dart';
import 'package:evently/providers/my_user_provider.dart';
import 'package:evently/ui/home/home_screen.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_routes.dart';
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
import '../../../utils/app_const.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController(text: 'shark@gmail.com');

  final passwordController = TextEditingController(text: '123456');

  @override
  Widget build(BuildContext context) {
    final textFromLocal = AppLocalizations.of(context)!;
    final textStyle = Theme
        .of(context)
        .textTheme;
    final localProvider = Provider.of<AppLocalProvider>(context);
    final themeProvider = Provider.of<AppThemeProvider>(context);
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 14, vertical: 4
          ),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(AppAssets.eventlyLogo,),
                CustomTextFormField(
                  controller: emailController,
                  hintText: textFromLocal.email,
                  prefixIcon: Icons.email_outlined,
                  onValidator: (text) {
                    if (text == null || text
                        .trim()
                        .isEmpty) {
                      return textFromLocal.please_enter_an_email;
                    }
                    final bool emailValid =
                    RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(text);
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
                      if (text == null || text
                          .trim()
                          .isEmpty) {
                        return textFromLocal.please_enter_a_password;
                      }
                      if (text.length < 6) {
                        return textFromLocal.password_must_be_at_least_6_char;
                      }
                      return null;
                    }
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: () {}, child: Text(
                      textFromLocal.forget_password_q,
                      style: AppStyles.primaryBold16.copyWith(
                        decoration: TextDecoration.underline,
                        decorationThickness: 2,
                        decorationColor: AppColors.primaryColor,
                      ),
                      textAlign: TextAlign.end,
                    )),
                  ],
                ),
                CustomElevatedButton(
                    onPressed: Login,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(textFromLocal.login, style: AppStyles.whiteMed20,),
                      ],
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(textFromLocal.dont_have_account,
                      style: textStyle.bodyMedium,),
                    TextButton(onPressed: goToRegisterScreen, child: Text(
                      textFromLocal.create_account,
                      style: AppStyles.primaryBold16.copyWith(
                        decoration: TextDecoration.underline,
                        decorationThickness: 2,
                        decorationColor: AppColors.primaryColor,
                      ),
                    )),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: AppColors.primaryColor,
                        thickness: 2,
                        endIndent: 10,
                        indent: 12,
                      ),
                    ),
                    Text(textFromLocal.or, style: AppStyles.primaryMed16,),
                    Expanded(
                      child: Divider(
                        color: AppColors.primaryColor,
                        thickness: 2,
                        endIndent: 10,
                        indent: 12,
                      ),
                    ),
                  ],
                ),
                CustomElevatedButton(
                  onPressed: loginWithGoogle,
                  backGroundColor: Colors.transparent,
                  borderColor: AppColors.primaryColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(textFromLocal.login_with_google,
                        style: AppStyles.primaryMed20,)
                    ],
                  ),
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
                AnimatedToggleSwitch<ThemeMode>.rolling(
                  current: themeProvider.appTheme,
                  values: [ThemeMode.light, ThemeMode.dark],
                  onChanged: (newTheme) {
                    setState(() {
                      themeProvider.changeAppTheme(newTheme);
                    });
                  },
                  iconBuilder: (value, selected) {
                    if (value == ThemeMode.light) {
                      return Icon(
                        Icons.sunny,
                        color: selected ? theme.cardColor : AppColors
                            .primaryColor,
                      );
                    } else {
                      return Icon(
                        Icons.dark_mode_sharp,
                        color: selected ? theme.cardColor : AppColors
                            .primaryColor,
                      );
                    }
                  },

                  style: ToggleStyle(
                    backgroundColor: Colors.transparent,
                    borderColor: AppColors.primaryColor,
                    indicatorColor: AppColors.primaryColor,
                  ),
                  height: 37,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void Login() async {
    var myUserProvider = Provider.of<MyUserProvider>(context, listen: false);
    var appConst = AppConst(context);
    if (formKey.currentState!.validate()) {
      setState(() {});
      CustomAlertDialog.showLoading(
          context: context, msg: appConst.text.loading);
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text
        );
        if (credential.user?.uid == null) {
          CustomAlertDialog.hideLoading(context: context);
          return;
        }
        MyUsers? newUser = await FireBaseUtils.getUser(
            userId: credential.user!.uid);
        myUserProvider.updateUser(newUser!);
        CustomAlertDialog.hideLoading(context: context);
        CustomAlertDialog.showMsg(
            context: context, msg: appConst.text.login_Successfully);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen(),));
      } catch (e) {
        print(e.toString());
        CustomAlertDialog.hideLoading(context: context);
        CustomAlertDialog.showMsg(
            context: context, msg: appConst.text.wrong_email_or_password);
      }

    }
  }

  void goToRegisterScreen() {
    Navigator.of(context).pushNamed(AppRoutes.registerScreensRouteName);
  }


  Future<void> loginWithGoogle() async {
    var myUserProvider = Provider.of<MyUserProvider>(context, listen: false);
    var googleUser = await FireBaseUtils.signInWithGoogle();
    MyUsers newUser = MyUsers(id: googleUser.user?.uid,
        name: googleUser.user?.displayName,
        email: googleUser.user?.email);
    var currentUser = await FireBaseUtils.getUser(userId: newUser.id!);
    if (currentUser == null) {
      await FireBaseUtils.setUser(newUser);
      myUserProvider.updateUser(newUser);
    }
    myUserProvider.updateUser(newUser);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomeScreen(),));
  }
}
