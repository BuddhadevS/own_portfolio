// Contact form page with validation
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:buddhadev/app/modules/contact/controllers/contact_controller.dart';
import 'package:buddhadev/shared/theme/app_colors.dart';
import 'package:buddhadev/shared/theme/text_styles.dart';
import 'package:buddhadev/shared/constants/app_dimensions.dart';
import 'package:buddhadev/shared/constants/app_strings.dart';
import 'package:buddhadev/shared/constants/app_assets.dart';

class ContactView extends StatelessWidget {
  final ContactController controller = Get.put(ContactController());

  ContactView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = AppDimensions.isDesktop(screenWidth);
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: AppBar(
        title: Text(
          AppStrings.contactPageTitle,
          style: TextStyles.chatTitle,
        ),
        backgroundColor: AppColors.cardBackground,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.primaryText),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.primaryText,
            size: isDesktop ? AppDimensions.iconLarge : AppDimensions.iconMedium,
          ),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isDesktop ? AppDimensions.maxFormWidth : double.infinity,
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(
              AppDimensions.getPadding(
                screenWidth,
                mobile: AppDimensions.paddingXXLarge,
                desktop: AppDimensions.paddingXXXLarge,
              ),
            ),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppDimensions.spacing24),
                  Text(
                    AppStrings.getInTouchTitle,
                    style: TextStyles.getResponsiveTextStyle(
                      screenWidth,
                      desktop: TextStyles.sectionTitle,
                      mobile: TextStyles.sectionTitleMobile,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.spacing8),
                  Text(
                    AppStrings.contactPageDescription,
                    style: TextStyles.getResponsiveTextStyle(
                      screenWidth,
                      desktop: TextStyles.sectionDescription,
                      mobile: TextStyles.sectionDescriptionMobile,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.spacing32),
                  _buildFormField(
                    controller: controller.nameController,
                    label: AppStrings.fullNameLabel,
                    assetName: AppAssets.userIcon,
                    hintText: AppStrings.fullNameHint,
                    validator: controller.validateName,
                  ),
                  const SizedBox(height: AppDimensions.spacing20),
                  _buildFormField(
                    controller: controller.emailController,
                    label: AppStrings.emailLabel,
                    assetName: AppAssets.emailIcon,
                    hintText: AppStrings.emailHint,
                    keyboardType: TextInputType.emailAddress,
                    validator: controller.validateEmail,
                  ),
                  const SizedBox(height: AppDimensions.spacing20),
                  _buildFormField(
                    controller: controller.phoneController,
                    label: AppStrings.phoneLabel,
                    assetName: AppAssets.phoneIcon,
                    hintText: AppStrings.phoneHint,
                    keyboardType: TextInputType.phone,
                    validator: controller.validatePhone,
                  ),
                  const SizedBox(height: AppDimensions.spacing20),
                  _buildFormField(
                    controller: controller.messageController,
                    label: AppStrings.messageLabel,
                    hintText: AppStrings.messageHint,
                    maxLines: 5,
                    validator: controller.validateMessage,
                  ),
                  const SizedBox(height: 32),
                  Obx(
                    () => SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: controller.isSubmitting.value
                            ? null
                            : controller.submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.appAccentColor,
                          foregroundColor: AppColors.pureWhite,
                          disabledBackgroundColor: AppColors.mutedText,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: controller.isSubmitting.value
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(
                                      color: AppColors.pureWhite,
                                      strokeWidth: 2,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    AppStrings.sendingText,
                                    style: TextStyles.buttonText.copyWith(
                                      color: AppColors.pureWhite,
                                    ),
                                  ),
                                ],
                              )
                            : Text(
                                AppStrings.sendButtonText,
                                style: TextStyles.buttonText.copyWith(
                                  color: AppColors.pureWhite,
                                ),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppDimensions.spacing20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormField({
    required TextEditingController controller,
    required String label,
    String? assetName,
    String? hintText,
    required String? Function(String?) validator,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyles.formLabel),
        const SizedBox(height: AppDimensions.spacing8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          validator: validator,
          style: TextStyles.formInput,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: assetName != null
                ? Padding(
                    padding: const EdgeInsets.all(AppDimensions.paddingMedium),
                    child: Image.asset(
                      assetName,
                      width: AppDimensions.iconMedium,
                      height: AppDimensions.iconMedium,
                      color: AppColors.mutedText,
                    ),
                  )
                : null,
            filled: true,
            fillColor: AppColors.cardBackground,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: AppColors.appAccentColor,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.errorColor),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: AppColors.errorColor,
                width: 2,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingLarge,
              vertical: AppDimensions.paddingMedium,
            ),
            hintStyle: TextStyles.formHint,
            errorStyle: TextStyles.formError,
          ),
        ),
      ],
    );
  }
}
