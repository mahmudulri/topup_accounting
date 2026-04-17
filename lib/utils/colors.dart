import 'package:flutter/material.dart';

class AppColors {
  // ── Brand / Primary ───────────────────────────────
  static const primaryColor = Color(0xFF2DC9A3); // icons, text, shadows
  static const primaryLight = Color(0xFF3DD6B0); // gradient start
  static const primaryDark = Color(0xFF1BAF8C); // gradient end
  static const fontColor = Color.fromARGB(255, 24, 32, 31); // gradient end
  static const fontColor2 = Color(0xff757D88);
  static const borderColor = Color.fromRGBO(224, 224, 224, 1);

  // ── Background ────────────────────────────────────
  static const scaffoldBg = Color(0xFFEEF2F5); // screen background
  static const cardBg = Color(0xFFFFFFFF); // white card
  static const fieldBg = Color(0xFFF0F4FA); // input field background

  // ── Text ──────────────────────────────────────────
  static const titleText = Color(0xFF1A2340); // "Welcome back"
  static const subtitleText = Color(0xFF9AA3B2); // "Manage your wholesale..."
  static const labelText = Color(0xFF3A4358); // "Phone or Email", "Password"
  static const bodyText = Color(0xFF2A3248); // typed input text
  static const hintText = Color(0xFFB0B8C8); // placeholder text
  static const mutedText = Color(0xFF7A8299); // "Forgot password?"

  // ── Shadows ───────────────────────────────────────
  static const cardShadow = Color(0xFF000000); // black @ 0.06 opacity

  //----------------------------Gradient-------------------------------

  static const primaryGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [primaryLight, primaryDark],
  );

  static const iconGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryLight, Color(0xFF1FAF8A)],
  );
}
