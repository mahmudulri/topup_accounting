import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:topup_accounting/widgets/custom_text.dart';
import '../controllers/add_reseller_controller.dart';
import '../global_controllers/languages_controller.dart';
import '../utils/colors.dart';

void showAddResellerSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => AddResellerBottomSheet(),
  );
}

class AddResellerBottomSheet extends StatefulWidget {
  AddResellerBottomSheet({super.key});

  @override
  State<AddResellerBottomSheet> createState() => _AddResellerBottomSheetState();
}

class _AddResellerBottomSheetState extends State<AddResellerBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  static Color _teal = Color(0xFF2DB8A0);
  static Color _inputBg = Color(0xFFF0F5F4);
  static Color _labelColor = Color(0xFF1A2E2A);
  static Color _hintColor = Color(0xFFADBFBC);
  static Color _iconColor = Color(0xFFADBFBC);
  static Color _cancelBg = Color(0xFFEFF2F1);
  static Color _cancelText = Color(0xFF4A5E5A);

  final languagesController = Get.find<LanguagesController>();

  AddResellerController addResellerController = Get.put(
    AddResellerController(),
  );

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),

      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 16, 20, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Drag handle
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 12, bottom: 8),
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Color(0xFFDDE5E3),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),

                  // Header
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Icon(
                            Icons.arrow_back,
                            color: _labelColor,
                            size: 22,
                          ),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            KText(
                              text: languagesController.tr("ADD_SUPPLIER"),
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: _labelColor,
                            ),
                            SizedBox(height: 2),
                            KText(
                              text: languagesController.tr(
                                "ADD_A_NEW_SUPPLIER_TO_YOUR_NETWORK",
                              ),
                              fontSize: 13,
                              color: Color(0xFF7A9490),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Divider(color: Color(0xFFEAF0EF), height: 1),
                  SizedBox(height: 20),

                  // Form
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel(languagesController.tr("SUPPLIER_NAME")),
                        _buildTextField(
                          controller: addResellerController.nameController,
                          hint: languagesController.tr("ENTER_SUPPLIER_NAME"),
                          prefixIcon: Icons.storefront_outlined,
                          validator: (v) => (v == null || v.trim().isEmpty)
                              ? 'Required'
                              : null,
                        ),
                        SizedBox(height: 16),

                        _buildLabel(languagesController.tr("PHONE")),
                        _buildTextField(
                          controller: addResellerController.phoneController,
                          hint: languagesController.tr("ENTER_PHONE_NUMBER"),
                          prefixIcon: Icons.phone_outlined,
                          keyboardType: TextInputType.phone,
                          helperText: languagesController.tr(
                            "INCLUDE_COUNTRY_CODE_E.G_+93",
                          ),
                          // helperText: 'Include country code e.g. +93',
                          validator: (v) => (v == null || v.trim().isEmpty)
                              ? 'Required'
                              : null,
                        ),
                        SizedBox(height: 16),

                        _buildLabel(languagesController.tr("COMPANY_NAME")),
                        _buildTextField(
                          controller: addResellerController.cityController,
                          hint: languagesController.tr("ENTER_COMPANY_NAME"),
                          validator: (v) => (v == null || v.trim().isEmpty)
                              ? 'Required'
                              : null,
                        ),
                        SizedBox(height: 16),

                        _buildLabel("${languagesController.tr("BONUS")} %"),
                        _buildTextField(
                          controller: addResellerController.bonusController,
                          hint: '0.00',
                          prefixIcon: Icons.percent,
                          keyboardType: TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^\d*\.?\d{0,2}'),
                            ),
                          ],
                          helperText: languagesController.tr(
                            "PERCENTAGE_OF_BONUS_ON_EACH_PURCHASE",
                          ),
                          // helperText: 'Percentage of bonus on each purchase',
                          validator: (v) => (v == null || v.trim().isEmpty)
                              ? 'Required'
                              : null,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 28),

                  // Action buttons
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: _isLoading
                              ? null
                              : () => Navigator.of(context).pop(),
                          style: TextButton.styleFrom(
                            backgroundColor: _cancelBg,
                            foregroundColor: _cancelText,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.close, size: 16),
                              SizedBox(width: 6),
                              KText(
                                text: languagesController.tr("CANCEL"),
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (addResellerController
                                    .nameController
                                    .text
                                    .isNotEmpty &&
                                addResellerController
                                    .phoneController
                                    .text
                                    .isNotEmpty &&
                                addResellerController
                                    .cityController
                                    .text
                                    .isNotEmpty &&
                                addResellerController
                                    .bonusController
                                    .text
                                    .isNotEmpty) {
                              addResellerController.addnow();
                            } else {
                              Fluttertoast.showToast(
                                msg: languagesController.tr(
                                  "FILL_DATA_CORRECTLY",
                                ),
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                gravity: ToastGravity.CENTER,
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _teal,
                            foregroundColor: Colors.white,
                            disabledBackgroundColor: _teal.withOpacity(0.6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 16),
                            elevation: 0,
                          ),
                          child: _isLoading
                              ? SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.2,
                                    color: Colors.white,
                                  ),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.save_outlined, size: 18),
                                    SizedBox(width: 6),
                                    Obx(
                                      () => KText(
                                        text:
                                            addResellerController
                                                    .isLoading
                                                    .value ==
                                                false
                                            ? languagesController.tr("SUBMIT")
                                            : languagesController.tr(
                                                "PLEASE_WAIT",
                                              ),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w600,
              color: _labelColor,
            ),
          ),
          SizedBox(width: 3),
          Text('*', style: TextStyle(color: Colors.red, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    IconData? prefixIcon,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    String? helperText,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          validator: validator,
          style: TextStyle(fontSize: 14.5, color: _labelColor),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: _hintColor, fontSize: 14),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, color: _iconColor, size: 18)
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(color: AppColors.borderColor, width: 1),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(color: AppColors.primaryColor, width: 1),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(color: Colors.redAccent, width: 1.2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(color: Colors.redAccent, width: 1.5),
            ),
          ),
        ),
        if (helperText != null) ...[
          SizedBox(height: 5),
          Text(
            helperText,
            style: TextStyle(fontSize: 11.5, color: Color(0xFF9AB0AC)),
          ),
        ],
      ],
    );
  }
}
