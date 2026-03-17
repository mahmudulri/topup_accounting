import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:topup_accounting/controllers/sign_in_controller.dart';
import 'package:topup_accounting/global_controllers/languages_controller.dart';

import '../widgets/custom_text.dart';
import '../widgets/languagepicker.dart';

class SigninScreen extends StatefulWidget {
  SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  SignInController signInController = Get.put(SignInController());

  final languagesController = Get.find<LanguagesController>();
  bool _obscurePassword = true;
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFFEEF2F5),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Obx(() {
                      final currentLang = languagesController.selectedlan.value;
                      final matched = languagesController.alllanguagedata
                          .firstWhere(
                            (l) => l["name"] == currentLang,
                            orElse: () => {"region": "US"},
                          );
                      final region = matched["region"] ?? "US";

                      return GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            barrierColor: Colors.black.withOpacity(0.25),
                            builder: (context) {
                              return Dialog(
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                insetPadding: const EdgeInsets.only(
                                  top: 60,
                                  right: 16,
                                ),
                                alignment: Alignment.topRight,
                                child: LanguagePickerDropdown(
                                  languagesController: languagesController,
                                  box: box,
                                  onLanguageSelected:
                                      (name, isoCode, regionCode, direction) {
                                        // 1. Update controller
                                        languagesController.changeLanguage(
                                          name,
                                        );

                                        // 2. Persist to storage
                                        box.write("language", name);
                                        box.write("direction", direction);

                                        // 3. Build locale
                                        final locale = Locale(
                                          isoCode,
                                          regionCode,
                                        );

                                        // 4. Apply locale
                                        setState(() {
                                          EasyLocalization.of(
                                            context,
                                          )!.setLocale(locale);
                                        });

                                        Navigator.pop(context);
                                      },
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(
                              0xFFDEF7EF,
                            ), // light mint background
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: const Color(
                                0xFF2DC9A3,
                              ).withValues(alpha: 0.30), // teal border
                              width: 1.5,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.language,
                                color: Color(0xFF2DC9A3), // teal icon
                                size: 15,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                region,
                                style: const TextStyle(
                                  color: Color(0xFF2DC9A3), // teal text
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ],
                ),

                // Wallet Icon
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    signInController.phoneEmailController.text = "01798778977";
                    signInController.passwordController.text = "123456";
                  },
                  child: Container(
                    width: 68,
                    height: 68,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF3DD6B0), Color(0xFF1FAF8A)],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF2DC9A3).withOpacity(0.35),
                          blurRadius: 18,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.account_balance_wallet_rounded,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ),

                SizedBox(height: 22),

                // Title
                KText(
                  text: languagesController.tr("WELCOME_BACK"),

                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A2340),
                ),

                SizedBox(height: 8),

                // Subtitle
                KText(
                  text: languagesController.tr(
                    "MANAGE_YOUR_WHOLESALE_TOP_UP_BUSINESS",
                  ),

                  fontSize: 14,
                  color: Color(0xFF9AA3B2),
                  fontWeight: FontWeight.w400,
                ),

                SizedBox(height: 32),

                // Card
                Container(
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 24,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Phone or Email
                      KText(
                        text: languagesController.tr("PHONE_OR_EMAIL"),

                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF3A4358),
                      ),
                      SizedBox(height: 8),
                      _buildTextField(
                        controller: signInController.phoneEmailController,
                        hintText: languagesController.tr("PHONE_OR_EMAIL"),
                        obscureText: false,
                      ),

                      SizedBox(height: 20),

                      // Password
                      KText(
                        text: languagesController.tr("PASSWORD"),

                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF3A4358),
                      ),
                      SizedBox(height: 8),
                      _buildTextField(
                        controller: signInController.passwordController,
                        hintText: languagesController.tr("PASSWORD"),
                        obscureText: _obscurePassword,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                          child: Icon(
                            _obscurePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: Color(0xFF9AA3B2),
                            size: 22,
                          ),
                        ),
                      ),

                      SizedBox(height: 16),

                      // View Packages & Forgot Password
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.inventory_2_outlined,
                                color: Color(0xFF2DC9A3),
                                size: 18,
                              ),
                              SizedBox(width: 6),
                              GestureDetector(
                                onTap: () {},
                                child: KText(
                                  text: languagesController.tr("VIEW_PACKAGES"),

                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF2DC9A3),
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: KText(
                              text: languagesController.tr("FORGOT_PASSWORD"),

                              fontSize: 13.5,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF7A8299),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 24),

                      // Sign In Button
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [Color(0xFF3DD6B0), Color(0xFF1BAF8C)],
                            ),
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF2DC9A3).withOpacity(0.4),
                                blurRadius: 16,
                                offset: Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Obx(
                            () => ElevatedButton(
                              onPressed: () {
                                signInController.signIn();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: KText(
                                text: signInController.isLoading.value == false
                                    ? languagesController.tr("SIGN_IN")
                                    : languagesController.tr("PLEASE_WAIT"),

                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required bool obscureText,
    Widget? suffixIcon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFF0F4FA),
        borderRadius: BorderRadius.circular(14),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(
          fontSize: 15,
          color: Color(0xFF2A3248),
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Color(0xFFB0B8C8), fontSize: 15),
          suffixIcon: suffixIcon != null
              ? Padding(padding: EdgeInsets.only(right: 14), child: suffixIcon)
              : null,
          suffixIconConstraints: BoxConstraints(minWidth: 44, minHeight: 44),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 15),
        ),
      ),
    );
  }
}
