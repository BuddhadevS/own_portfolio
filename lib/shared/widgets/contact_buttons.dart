// Widget for animated social media contact buttons
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:buddhadev/shared/constants/app_strings.dart';
import 'package:buddhadev/shared/theme/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactButtons extends StatefulWidget {
  final bool onDark;

  const ContactButtons({super.key, this.onDark = true});

  @override
  State<ContactButtons> createState() => _ContactButtonsState();
}

class _ContactButtonsState extends State<ContactButtons> {
  double _iconSize = 22.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _iconSize = Get.width < 600 ? 20.0 : 22.0;
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar(
        'Error',
        'Could not launch $url',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.errorColor,
        colorText: AppColors.pureWhite,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final iconColor =
        widget.onDark ? AppColors.pureWhite : AppColors.primaryText;
    final borderColor = widget.onDark
        ? AppColors.pureWhite.withValues(alpha: 0.25)
        : AppColors.borderColor;
    final fillColor = widget.onDark
        ? AppColors.pureWhite.withValues(alpha: 0.08)
        : AppColors.cardBackground;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildButton(
            icon: Icon(Icons.code, size: _iconSize, color: iconColor),
            url: AppStrings.githubUrl,
            label: 'GitHub',
            fillColor: fillColor,
            borderColor: borderColor,
          ),
          const SizedBox(width: 12),
          _buildButton(
            icon: Icon(Icons.person_outline, size: _iconSize, color: iconColor),
            url: AppStrings.linkedinUrl,
            label: 'LinkedIn',
            fillColor: fillColor,
            borderColor: borderColor,
          ),
          const SizedBox(width: 12),
          _buildButton(
            icon: Icon(Icons.article_outlined, size: _iconSize, color: iconColor),
            url: AppStrings.mediumUrl,
            label: 'Medium',
            fillColor: fillColor,
            borderColor: borderColor,
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    required Widget icon,
    required String url,
    required String label,
    required Color fillColor,
    required Color borderColor,
  }) {
    return Tooltip(
      message: label,
      child: Material(
        color: fillColor,
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: () => _launchURL(url),
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: borderColor),
            ),
            alignment: Alignment.center,
            child: icon,
          ),
        ),
      ),
    );
  }
}
