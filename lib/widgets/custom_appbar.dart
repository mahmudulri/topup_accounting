import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../global_controllers/languages_controller.dart';
import '../global_controllers/scaffold_controller.dart';
import '../utils/colors.dart';
import 'custom_text.dart';
import 'languagepicker.dart';

class AppTopBar extends StatefulWidget implements PreferredSizeWidget {
  AppTopBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  State<AppTopBar> createState() => _AppTopBarState();
}

class _AppTopBarState extends State<AppTopBar> {
  final lang = Get.find<LanguagesController>();
  final box = GetStorage();

  // Overlay for the profile dropdown
  OverlayEntry? _overlayEntry;
  final GlobalKey _avatarKey = GlobalKey();

  void _toggleDropdown() {
    if (_overlayEntry != null) {
      _closeDropdown();
      return;
    }

    // Find avatar position on screen
    final renderBox =
        _avatarKey.currentContext!.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: _closeDropdown,
        child: Stack(
          children: [
            Positioned(
              top: offset.dy + size.height + 8,
              right: 16,
              child: _ProfileDropdown(
                onClose: _closeDropdown,
                lang: lang,
                box: box,
              ),
            ),
          ],
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _closeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    _closeDropdown();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lang = Get.find<LanguagesController>();

    // Get current region for language button
    final currentLang = lang.selectedlan.value;
    final matched = lang.alllanguagedata.firstWhere(
      (l) => l["name"] == currentLang,
      orElse: () => {"region": "GB"},
    );
    final region = matched["region"] ?? "GB";

    // Get first letter of user name for avatar

    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    final scaffoldController = Get.find<ScaffoldController>();

    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.cardBg,
      elevation: 0,
      title: Row(
        children: [
          GestureDetector(
            onTap: () {
              scaffoldController.openDrawer();
            },
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(9),
              ),
              child: Icon(
                Icons.account_balance_wallet_rounded,
                color: Colors.white,
                size: 17,
              ),
            ),
          ),
          SizedBox(width: 8),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              KText(
                text: lang.tr("DASHBOARD"),
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: AppColors.titleText,
              ),
              KText(
                text: "Tuesday, March 17, 2026",
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: AppColors.subtitleText,
              ),
            ],
          ),
        ],
      ),
      actions: [
        // ── Bell icon with badge ──────────────────────────────
        Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              icon: Icon(
                Icons.notifications_outlined,
                color: AppColors.labelText,
                size: 22,
              ),
              onPressed: () {},
            ),
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Color(0xFFFF6B6B),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),

        SizedBox(width: 4),

        // ── Language button ───────────────────────────────────
        Obx(() {
          final cur = lang.selectedlan.value;
          final m = lang.alllanguagedata.firstWhere(
            (l) => l["name"] == cur,
            orElse: () => {"region": "GB"},
          );
          return GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                barrierColor: Colors.black.withOpacity(0.25),
                builder: (context) {
                  return Dialog(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    insetPadding: const EdgeInsets.only(top: 60, right: 16),
                    alignment: Alignment.topRight,
                    child: LanguagePickerDropdown(
                      languagesController: lang,
                      box: box,
                      onLanguageSelected:
                          (name, isoCode, regionCode, direction) {
                            // 1. Update controller
                            lang.changeLanguage(name);

                            // 2. Persist to storage
                            box.write("language", name);
                            box.write("direction", direction);

                            // 3. Build locale
                            final locale = Locale(isoCode, regionCode);

                            // 4. Apply locale
                            setState(() {
                              EasyLocalization.of(context)!.setLocale(locale);
                            });

                            Navigator.pop(context);
                          },
                    ),
                  );
                },
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Color(0xFFDEF7EF),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.primaryColor, width: 1.5),
              ),
              child: Row(
                children: [
                  Icon(Icons.language, color: AppColors.primaryColor, size: 16),
                  SizedBox(width: 4),
                  Text(
                    m["region"] ?? "GB",
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),

        SizedBox(width: 8),

        // ── Avatar / Profile button ───────────────────────────
        GestureDetector(
          key: _avatarKey,
          onTap: _toggleDropdown,
          child: Container(
            margin: EdgeInsetsDirectional.only(end: 12),
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: Color(0xFF9C6EFF),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                "M",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ── Profile Dropdown ──────────────────────────────────────────────────────────
class _ProfileDropdown extends StatelessWidget {
  final VoidCallback onClose;
  final LanguagesController lang;
  final GetStorage box;

  _ProfileDropdown({
    required this.onClose,
    required this.lang,
    required this.box,
  });

  @override
  Widget build(BuildContext context) {
    final userName = box.read("userName") ?? "Mahmudul Hasan";
    final userPhone = box.read("userPhone") ?? "01798778977";

    return Material(
      color: Colors.transparent,
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 20,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── User info header ────────────────────────────────
            Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 12),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.titleText,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          userPhone,
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.mutedText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Divider(height: 1, color: Color(0xFFF0F4FA)),

            // ── Menu items ──────────────────────────────────────
            _DropdownItem(
              icon: Icons.person_outline,
              label: lang.tr("PROFILE"),
              iconColor: AppColors.labelText,
              onTap: () {
                onClose();
                // Get.to(() =>  ProfileScreen());
              },
            ),
            _DropdownItem(
              icon: Icons.settings_outlined,
              label: lang.tr("SETTINGS"),
              iconColor: AppColors.labelText,
              onTap: () {
                onClose();
                // Get.to(() =>  SettingsScreen());
              },
            ),

            Divider(height: 1, color: Color(0xFFF0F4FA)),

            _DropdownItem(
              icon: Icons.logout_rounded,
              label: lang.tr("LOGOUT"),
              iconColor: Color(0xFFFF6B6B),
              labelColor: Color(0xFFFF6B6B),
              onTap: () {
                onClose();
                // handle logout
              },
            ),

            SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}

// ── Single dropdown row ───────────────────────────────────────────────────────
class _DropdownItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color iconColor;
  final Color? labelColor;
  final VoidCallback onTap;

  _DropdownItem({
    required this.icon,
    required this.label,
    required this.iconColor,
    required this.onTap,
    this.labelColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(icon, size: 18, color: iconColor),
            SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: labelColor ?? AppColors.labelText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
