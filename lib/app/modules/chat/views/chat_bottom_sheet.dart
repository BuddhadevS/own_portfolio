import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:buddhadev/shared/theme/app_colors.dart';
import 'package:buddhadev/shared/theme/text_styles.dart';
import 'package:buddhadev/shared/constants/app_dimensions.dart';
import 'package:buddhadev/shared/constants/app_strings.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/chat_controller.dart';
import '../models/chat_message.dart';

class ChatBottomSheet extends StatelessWidget {
  const ChatBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChatController());
    final textController = TextEditingController();
    final isWideScreen = Get.width > AppDimensions.mobileBreakpoint;
    final errorText = RxString('');

    return Material(
      type: MaterialType.transparency,
      child: Container(
        height: Get.height * 0.85,
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppDimensions.radiusXXLarge),
            topRight: Radius.circular(AppDimensions.radiusXXLarge),
            bottomLeft:
                isWideScreen ? Radius.circular(AppDimensions.radiusXXLarge) : Radius.zero,
            bottomRight:
                isWideScreen ? Radius.circular(AppDimensions.radiusXXLarge) : Radius.zero,
          ),
          border: Border.all(color: AppColors.borderColor),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(AppDimensions.paddingXLarge),
              decoration: const BoxDecoration(
                color: AppColors.secondaryBackground,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                border: Border(
                  bottom: BorderSide(color: AppColors.borderColor),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.accentSoft,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.chat_bubble_outline,
                      color: AppColors.appAccentColor,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Text(AppStrings.chatTitle, style: TextStyles.chatTitle),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close, color: AppColors.primaryText),
                    onPressed: () => Get.back(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(() {
                if (controller.isFirstTime.value) {
                  return Column(
                    children: [
                      if (controller.messages.isNotEmpty)
                        _buildMessageBubble(controller.messages.first),
                      _buildPredefinedQuestions(controller),
                    ],
                  );
                }
                return _buildChatMessages(controller);
              }),
            ),
            Container(
              padding: EdgeInsets.all(AppDimensions.paddingLarge),
              decoration: const BoxDecoration(
                color: AppColors.cardBackground,
                border: Border(top: BorderSide(color: AppColors.borderColor)),
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    Expanded(
                      child: Obx(
                        () => TextField(
                          controller: textController,
                          style: TextStyles.formInput,
                          decoration: InputDecoration(
                            hintText: AppStrings.chatInputHint,
                            errorText: errorText.value.isEmpty
                                ? null
                                : errorText.value,
                            errorStyle: TextStyles.formError,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: AppColors.borderColor,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: AppColors.borderColor,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: AppColors.appAccentColor,
                                width: 2,
                              ),
                            ),
                            filled: true,
                            fillColor: AppColors.secondaryBackground,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            hintStyle: TextStyles.formHint,
                          ),
                          onSubmitted: (value) {
                            if (value.trim().isEmpty) {
                              errorText.value = AppStrings.chatEmptyMessageError;
                              return;
                            }
                            errorText.value = '';
                            controller.sendMessage(value);
                            textController.clear();
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Obx(
                      () => controller.isLoading.value
                          ? const SizedBox(
                              width: 44,
                              height: 44,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: CircularProgressIndicator(
                                  color: AppColors.appAccentColor,
                                  strokeWidth: 2,
                                ),
                              ),
                            )
                          : Material(
                              color: AppColors.appAccentColor,
                              borderRadius: BorderRadius.circular(10),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: () {
                                  if (textController.text.trim().isEmpty) {
                                    errorText.value =
                                        AppStrings.chatEmptyMessageError;
                                    return;
                                  }
                                  errorText.value = '';
                                  controller.sendMessage(textController.text);
                                  textController.clear();
                                },
                                child: const SizedBox(
                                  width: 44,
                                  height: 44,
                                  child: Icon(
                                    Icons.send_rounded,
                                    color: AppColors.pureWhite,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPredefinedQuestions(ChatController controller) {
    return Flexible(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              AppStrings.chatQuestionPrompt,
              style: GoogleFonts.outfit(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.secondaryText,
              ),
            ),
            const SizedBox(height: 16),
            ...controller.predefinedQuestions.map(
              (question) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Material(
                  color: AppColors.secondaryBackground,
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    onTap: () =>
                        controller.handlePredefinedQuestion(question),
                    borderRadius: BorderRadius.circular(10),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 14,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: AppColors.appAccentColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              question,
                              style: TextStyles.chatMessage.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: AppColors.mutedText,
                            size: 14,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatMessages(ChatController controller) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      reverse: true,
      physics: const BouncingScrollPhysics(),
      itemCount: controller.messages.length,
      itemBuilder: (context, index) {
        final message =
            controller.messages[controller.messages.length - 1 - index];
        return _buildMessageBubble(message);
      },
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          bottom: 12,
          left: message.isUser ? 48 : 0,
          right: message.isUser ? 0 : 48,
        ),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: message.isUser
              ? AppColors.appAccentColor
              : AppColors.secondaryBackground,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(14),
            topRight: const Radius.circular(14),
            bottomLeft: Radius.circular(message.isUser ? 14 : 4),
            bottomRight: Radius.circular(message.isUser ? 4 : 14),
          ),
        ),
        child: message.isUser
            ? Text(
                message.message,
                style: TextStyles.chatMessage.copyWith(
                  color: AppColors.pureWhite,
                  fontWeight: FontWeight.w600,
                ),
              )
            : Linkify(
                text: message.message,
                style: TextStyles.chatMessage.copyWith(
                  color: AppColors.primaryText,
                  height: 1.4,
                ),
                linkStyle: TextStyles.chatMessage.copyWith(
                  color: AppColors.appAccentColor,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w600,
                ),
                onOpen: (link) async {
                  final uri = Uri.parse(link.url);
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                  }
                },
              ),
      ),
    );
  }
}
