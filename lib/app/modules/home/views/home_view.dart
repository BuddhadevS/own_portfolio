import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:lottie/lottie.dart';
import 'package:buddhadev/app/modules/chat/views/chat_bottom_sheet.dart';
import 'package:buddhadev/app/modules/contact/views/contact_screen.dart';
import 'package:buddhadev/app/modules/home/controllers/home_controller.dart';
import 'package:buddhadev/shared/constants/app_constants.dart';
import 'package:buddhadev/shared/models/skill_model.dart';
import 'package:buddhadev/shared/theme/app_colors.dart';
import 'package:buddhadev/shared/theme/text_styles.dart';
import 'package:buddhadev/shared/widgets/contact_buttons.dart';
import 'package:url_launcher/url_launcher.dart';

/// Hostinger Horizons–inspired professional portfolio layout.
class HomeView extends GetView<HomeController> {
  HomeView({super.key});

  final ScrollController _scrollController = ScrollController();
  final RxBool _isLoading = true.obs;
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _servicesKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  static const double _maxWidth = 1140;

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(milliseconds: AppDimensions.loadingDelayMilliseconds),
      () {
        if (_isLoading.value) _isLoading.value = false;
      },
    );

    return Obx(
      () => _isLoading.value
          ? _buildLoadingScreen()
          : LayoutBuilder(
              builder: (context, constraints) {
                final isDesktop =
                    constraints.maxWidth > AppDimensions.homeDesktopBreakpoint;
                return Scaffold(
                  backgroundColor: AppColors.pureWhite,
                  drawer: !isDesktop ? _buildMobileDrawer() : null,
                  body: Stack(
                    children: [
                      CustomScrollView(
                        controller: _scrollController,
                        physics: const ClampingScrollPhysics(),
                        slivers: [
                          if (isDesktop)
                            SliverPersistentHeader(
                              pinned: true,
                              delegate: _StickyHeaderDelegate(
                                child: _buildStickyHeader(isDesktop),
                              ),
                            )
                          else
                            SliverAppBar(
                              pinned: true,
                              backgroundColor: AppColors.pureWhite,
                              foregroundColor: AppColors.primaryText,
                              elevation: 0,
                              title: Text(
                                'Buddhadev Sahu',
                                style: GoogleFonts.syne(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16,
                                  color: AppColors.primaryText,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      _scrollToSection(_contactKey),
                                  child: Text(
                                    'Hire Me',
                                    style: GoogleFonts.outfit(
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.appAccentColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          SliverToBoxAdapter(
                            child: _buildHero(isDesktop, constraints),
                          ),
                          SliverToBoxAdapter(
                            child: KeyedSubtree(
                              key: _aboutKey,
                              child: _sectionShell(
                                color: AppColors.pureWhite,
                                child: _buildAbout(isDesktop),
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: KeyedSubtree(
                              key: _servicesKey,
                              child: _sectionShell(
                                color: AppColors.secondaryBackground,
                                child: _buildServices(isDesktop),
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: KeyedSubtree(
                              key: _projectsKey,
                              child: _sectionShell(
                                color: AppColors.pureWhite,
                                child: _buildProjects(isDesktop),
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: KeyedSubtree(
                              key: _experienceKey,
                              child: _sectionShell(
                                color: AppColors.secondaryBackground,
                                child: _buildExperience(isDesktop),
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: KeyedSubtree(
                              key: _skillsKey,
                              child: _sectionShell(
                                color: AppColors.pureWhite,
                                child: _buildSkills(isDesktop),
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: KeyedSubtree(
                              key: _contactKey,
                              child: _buildContactBand(isDesktop),
                            ),
                          ),
                          SliverToBoxAdapter(child: _buildFooter(isDesktop)),
                        ],
                      ),
                      Positioned(
                        right: isDesktop ? 28 : 16,
                        bottom: isDesktop ? 28 : 16,
                        child: _buildChatFab(),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  Widget _sectionShell({required Color color, required Widget child}) {
    return ColoredBox(
      color: color,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: _maxWidth),
          child: child,
        ),
      ),
    );
  }

  // ── Sticky header (Hostinger-style) ─────────────────────────────────────

  Widget _buildStickyHeader(bool isDesktop) {
    return Material(
      color: AppColors.pureWhite.withValues(alpha: 0.96),
      elevation: 0,
      child: Container(
        height: 72,
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.borderColor)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: _maxWidth),
            child: Row(
              children: [
                Text(
                  'Buddhadev Sahu',
                  style: GoogleFonts.syne(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primaryText,
                  ),
                ),
                const Spacer(),
                _nav('About', _aboutKey),
                _nav('Services', _servicesKey),
                _nav('Work', _projectsKey),
                _nav('Experience', _experienceKey),
                _nav('Skills', _skillsKey),
                const SizedBox(width: 16),
                _primaryBtn('Hire Me', () => _scrollToSection(_contactKey)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _nav(String label, GlobalKey key) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: InkWell(
        onTap: () => _scrollToSection(key),
        child: Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.secondaryText,
          ),
        ),
      ),
    );
  }

  // ── Hero ────────────────────────────────────────────────────────────────

  Widget _buildHero(bool isDesktop, BoxConstraints constraints) {
    final hero = isDesktop
        ? SizedBox(
            height: 520,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                  right: -80,
                  top: -40,
                  child: _blob(280, AppColors.accentSoft.withValues(alpha: 0.7)),
                ),
                Positioned(
                  left: -60,
                  bottom: 40,
                  child: _blob(
                    180,
                    AppColors.mediumAccent.withValues(alpha: 0.12),
                  ),
                ),
                Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: _maxWidth),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Row(
                        children: [
                          Expanded(flex: 7, child: _heroCopy(true)),
                          const SizedBox(width: 32),
                          _heroPhoto(true),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        : Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 36),
            child: Column(
              children: [
                _heroPhoto(false),
                const SizedBox(height: 22),
                _heroCopy(false),
              ],
            ),
          );

    return ColoredBox(
      color: AppColors.canvasStart,
      child: hero,
    );
  }

  Widget _blob(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }

  Widget _heroPhoto(bool isDesktop) {
    final size = isDesktop ? 168.0 : 112.0;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.appAccentColor, width: 3),
        boxShadow: [
          BoxShadow(
            color: AppColors.appAccentColor.withValues(alpha: 0.25),
            blurRadius: 24,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ClipOval(
        child: Image.asset(
          AppAssets.profilePic,
          fit: BoxFit.cover,
          alignment: const Alignment(0, -0.2),
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 600.ms)
        .scale(
          begin: const Offset(0.85, 0.85),
          end: const Offset(1, 1),
          duration: 700.ms,
          curve: Curves.easeOutBack,
        );
  }

  Widget _heroCopy(bool isDesktop) {
    final nameStyle = GoogleFonts.syne(
      fontSize: isDesktop ? 40 : 28,
      fontWeight: FontWeight.w800,
      letterSpacing: -0.8,
      height: 1.1,
      color: AppColors.primaryText,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment:
          isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        Text(
          'Available for opportunities',
          style: GoogleFonts.outfit(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.appAccentColor,
          ),
        )
            .animate(onPlay: (c) => c.repeat(reverse: true))
            .fadeIn(duration: 400.ms)
            .then()
            .shimmer(
              duration: 2200.ms,
              color: AppColors.mediumAccent.withValues(alpha: 0.55),
            ),
        const SizedBox(height: 14),
        // Sparkling sliding name (animated)
        DefaultTextStyle(
          style: nameStyle,
          child: AnimatedTextKit(
            isRepeatingAnimation: true,
            repeatForever: true,
            pause: const Duration(milliseconds: 1200),
            animatedTexts: [
              ColorizeAnimatedText(
                AppStrings.profileName,
                textStyle: nameStyle,
                colors: const [
                  AppColors.primaryText,
                  AppColors.appAccentColor,
                  AppColors.mediumAccent,
                  AppColors.primaryText,
                  AppColors.appAccentColor,
                ],
                speed: const Duration(milliseconds: 180),
              ),
            ],
          ),
        )
            .animate()
            .fadeIn(duration: 500.ms)
            .slideX(
              begin: isDesktop ? -0.12 : 0,
              end: 0,
              duration: 650.ms,
              curve: Curves.easeOutCubic,
            ),
        const SizedBox(height: 12),
        // Sliding / rotating tech stack roles
        SizedBox(
          height: isDesktop ? 36 : 32,
          child: DefaultTextStyle(
            style: GoogleFonts.outfit(
              fontSize: isDesktop ? 20 : 16,
              fontWeight: FontWeight.w600,
              color: AppColors.appAccentColor,
            ),
            textAlign: isDesktop ? TextAlign.left : TextAlign.center,
            child: AnimatedTextKit(
              repeatForever: true,
              pause: const Duration(milliseconds: 800),
              animatedTexts: [
                RotateAnimatedText(
                  'Java Backend Developer',
                  textAlign: isDesktop ? TextAlign.left : TextAlign.center,
                  duration: const Duration(milliseconds: 2200),
                ),
                RotateAnimatedText(
                  'Spring Boot  •  Microservices',
                  textAlign: isDesktop ? TextAlign.left : TextAlign.center,
                  duration: const Duration(milliseconds: 2200),
                ),
                RotateAnimatedText(
                  'Keycloak  •  OAuth2  •  OIDC',
                  textAlign: isDesktop ? TextAlign.left : TextAlign.center,
                  duration: const Duration(milliseconds: 2200),
                ),
                RotateAnimatedText(
                  'Azure  •  Docker  •  CI/CD',
                  textAlign: isDesktop ? TextAlign.left : TextAlign.center,
                  duration: const Duration(milliseconds: 2200),
                ),
                RotateAnimatedText(
                  'Spring AI  •  RAG  •  GenAI',
                  textAlign: isDesktop ? TextAlign.left : TextAlign.center,
                  duration: const Duration(milliseconds: 2200),
                ),
                RotateAnimatedText(
                  'OpenTelemetry  •  Observability',
                  textAlign: isDesktop ? TextAlign.left : TextAlign.center,
                  duration: const Duration(milliseconds: 2200),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'I design and build resilient Java backends, cloud-native microservices, and GenAI-powered platforms that scale.',
          textAlign: isDesktop ? TextAlign.left : TextAlign.center,
          style: isDesktop
              ? TextStyles.heroSubtitle.copyWith(fontSize: 16)
              : TextStyles.sectionDescriptionMobile,
        ).animate().fadeIn(delay: 200.ms, duration: 500.ms),
        const SizedBox(height: 24),
        Wrap(
          alignment: isDesktop ? WrapAlignment.start : WrapAlignment.center,
          spacing: 12,
          runSpacing: 12,
          children: [
            _primaryBtn(
              AppStrings.hireMe,
              () => _scrollToSection(_contactKey),
            ),
            _outlineBtn(AppStrings.bookConsultation, _openCalendly),
            _outlineBtn(AppStrings.downloadResume, _downloadCv),
          ],
        ).animate().fadeIn(delay: 280.ms, duration: 500.ms),
        const SizedBox(height: 22),
        Wrap(
          alignment: isDesktop ? WrapAlignment.start : WrapAlignment.center,
          spacing: 10,
          runSpacing: 8,
          children: [
            'Java 17',
            'Spring Boot 3',
            'Microservices',
            'Keycloak',
            'Azure',
            'Spring AI',
          ]
              .asMap()
              .entries
              .map(
                (e) => _techPill(e.value)
                    .animate(delay: (350 + e.key * 80).ms)
                    .fadeIn(duration: 400.ms)
                    .slideY(begin: 0.35, end: 0, duration: 450.ms)
                    .shimmer(
                      delay: (900 + e.key * 120).ms,
                      duration: 1800.ms,
                      color: AppColors.mediumAccent.withValues(alpha: 0.35),
                    ),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget _techPill(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Text(
        label,
        style: GoogleFonts.outfit(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.secondaryText,
        ),
      ),
    );
  }

  // ── About ───────────────────────────────────────────────────────────────

  Widget _buildAbout(bool isDesktop) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 40 : 20,
        vertical: isDesktop ? 88 : 56,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader(
            eyebrow: 'About',
            title: AppStrings.aboutMeTitle,
            subtitle: AppStrings.aboutMeDescription,
            icon: Icons.person_rounded,
            isDesktop: isDesktop,
          ),
          const SizedBox(height: 36),
          Wrap(
            spacing: isDesktop ? 48 : 24,
            runSpacing: 20,
            children: [
              _stat('2+', 'Years Experience'),
              _stat('2', 'Enterprise Platforms'),
              _stat('6+', 'Core Services'),
              _stat('India', 'Based · Remote OK'),
            ],
          ),
          const SizedBox(height: 28),
          Wrap(
            spacing: 28,
            runSpacing: 12,
            children: [
              _linkMeta(Icons.mail_outline, AppStrings.emailAddress, () {
                _launchURL('mailto:${AppStrings.emailAddress}');
              }),
              _linkMeta(Icons.phone_outlined, AppStrings.phoneNumber, () {
                _launchURL('tel:${AppStrings.phoneNumber}');
              }),
              _linkMeta(Icons.location_on_outlined, AppStrings.location, null),
            ],
          ),
        ],
      ),
    );
  }

  Widget _stat(String value, String label) {
    return SizedBox(
      width: 140,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: GoogleFonts.syne(
              fontSize: 32,
              fontWeight: FontWeight.w800,
              color: AppColors.appAccentColor,
              letterSpacing: -0.8,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.outfit(
              fontSize: 13,
              color: AppColors.mutedText,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  // ── Services (Hostinger grid) ───────────────────────────────────────────

  Widget _buildServices(bool isDesktop) {
    final services = [
      (
        Icons.account_tree_rounded,
        AppStrings.microservicesDevTitle,
        AppStrings.microservicesDevDesc,
      ),
      (
        Icons.developer_board_rounded,
        AppStrings.springBootDevTitle,
        AppStrings.springBootDevDesc,
      ),
      (
        Icons.verified_user_rounded,
        AppStrings.identitySecurityTitle,
        AppStrings.identitySecurityDesc,
      ),
      (
        Icons.auto_awesome_rounded,
        AppStrings.genAiIntegrationTitle,
        AppStrings.genAiIntegrationDesc,
      ),
      (
        Icons.cloud_done_rounded,
        AppStrings.cloudDevOpsTitle,
        AppStrings.cloudDevOpsDesc,
      ),
      (
        Icons.ssid_chart_rounded,
        AppStrings.observabilityTitle,
        AppStrings.observabilityDesc,
      ),
    ];

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 40 : 20,
        vertical: isDesktop ? 88 : 56,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader(
            eyebrow: 'What I Offer',
            title: AppStrings.servicesSection,
            subtitle:
                'End-to-end backend engineering — from architecture and security to GenAI and cloud delivery.',
            icon: Icons.architecture_rounded,
            isDesktop: isDesktop,
          ),
          const SizedBox(height: 36),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: services.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isDesktop ? 3 : 1,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: isDesktop ? 1.05 : 1.85,
            ),
            itemBuilder: (context, i) {
              final s = services[i];
              return Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.pureWhite,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.borderColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.accentSoft,
                            AppColors.mediumAccent.withValues(alpha: 0.25),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(
                        s.$1,
                        color: AppColors.appAccentColor,
                        size: 28,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      s.$2,
                      style: isDesktop
                          ? TextStyles.cardTitle
                          : TextStyles.cardTitleMobile,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Text(
                        s.$3,
                        style: isDesktop
                            ? TextStyles.cardDescription
                            : TextStyles.cardDescriptionMobile,
                        maxLines: isDesktop ? 5 : 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              )
                  .animate(delay: (80 * i).ms)
                  .fadeIn(duration: 400.ms)
                  .slideY(begin: 0.08, end: 0, duration: 450.ms);
            },
          ),
        ],
      ),
    );
  }

  // ── Projects work grid ──────────────────────────────────────────────────

  Widget _buildProjects(bool isDesktop) {
    final projects = [
      (
        AppStrings.coffeeWebProjectTitle,
        AppStrings.coffeeWebProjectDesc,
        AppStrings.coffeeWebDomain,
        'Enterprise Cloud',
        ['Java 17', 'Spring Boot', 'Keycloak', 'Azure ACA', 'Spring AI'],
        Icons.coffee_rounded,
      ),
      (
        AppStrings.lraProjectTitle,
        AppStrings.lraProjectDesc,
        AppStrings.zediantDomain,
        'Fintech System',
        ['Java', 'Spring Boot', 'Microservices', 'PostgreSQL'],
        Icons.account_balance_rounded,
      ),
      (
        AppStrings.genAiRagTitle,
        AppStrings.genAiRagDesc,
        'AI & Generative AI',
        'Document Intelligence',
        ['Spring AI', 'RAG', 'Ollama', 'Gemini'],
        Icons.auto_awesome_rounded,
      ),
      (
        AppStrings.keycloakAuthTitle,
        AppStrings.keycloakAuthDesc,
        'Identity & Security',
        'Security Gateway',
        ['Keycloak', 'OAuth 2.0', 'OIDC', 'RBAC'],
        Icons.shield_rounded,
      ),
    ];

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 40 : 20,
        vertical: isDesktop ? 88 : 56,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader(
            eyebrow: 'Selected Work',
            title: AppStrings.featuredProjectsTitle,
            subtitle:
                'Real platforms spanning social media, fintech, GenAI, and identity.',
            icon: Icons.work_rounded,
            isDesktop: isDesktop,
          ),
          const SizedBox(height: 36),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: projects.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isDesktop ? 2 : 1,
              crossAxisSpacing: 22,
              mainAxisSpacing: 22,
              childAspectRatio: isDesktop ? 1.35 : 1.15,
            ),
            itemBuilder: (context, i) {
              final p = projects[i];
              return Container(
                padding: const EdgeInsets.all(26),
                decoration: BoxDecoration(
                  color: AppColors.pureWhite,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.borderColor),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.pureBlack.withValues(alpha: 0.04),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: AppColors.accentSoft,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            p.$6,
                            color: AppColors.appAccentColor,
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            p.$4,
                            style: GoogleFonts.outfit(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: AppColors.appAccentColor,
                              letterSpacing: 0.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Text(
                      p.$1,
                      style: isDesktop
                          ? TextStyles.cardTitle
                          : TextStyles.cardTitleMobile,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      p.$3,
                      style: GoogleFonts.outfit(
                        fontSize: 13,
                        color: AppColors.mutedText,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: Text(
                        p.$2,
                        style: isDesktop
                            ? TextStyles.cardDescription
                            : TextStyles.cardDescriptionMobile,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: p.$5.map(_techPill).toList(),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // ── Experience ──────────────────────────────────────────────────────────

  Widget _buildExperience(bool isDesktop) {
    final items = controller.workExperiences;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 40 : 20,
        vertical: isDesktop ? 88 : 56,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader(
            eyebrow: 'Career',
            title: AppStrings.experienceTitle,
            subtitle: null,
            icon: Icons.business_center_rounded,
            isDesktop: isDesktop,
          ),
          const SizedBox(height: 36),
          ...items.map((exp) {
            return Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 20),
              padding: EdgeInsets.all(isDesktop ? 28 : 20),
              decoration: BoxDecoration(
                color: AppColors.pureWhite,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.borderColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isDesktop)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(exp.role, style: TextStyles.cardTitle),
                              const SizedBox(height: 6),
                              Text(
                                exp.company,
                                style: GoogleFonts.outfit(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.appAccentColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              exp.duration,
                              style: GoogleFonts.outfit(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: AppColors.secondaryText,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              exp.domain,
                              style: GoogleFonts.outfit(
                                fontSize: 13,
                                color: AppColors.mutedText,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  else ...[
                    Text(exp.role, style: TextStyles.cardTitleMobile),
                    const SizedBox(height: 4),
                    Text(
                      exp.company,
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.w600,
                        color: AppColors.appAccentColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${exp.duration} · ${exp.domain}',
                      style: GoogleFonts.outfit(
                        fontSize: 13,
                        color: AppColors.mutedText,
                      ),
                    ),
                  ],
                  const SizedBox(height: 14),
                  Text(
                    exp.description,
                    style: isDesktop
                        ? TextStyles.cardDescription
                        : TextStyles.cardDescriptionMobile,
                  ),
                  const SizedBox(height: 14),
                  ...exp.responsibilities.take(4).map(
                        (r) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 6),
                                child: Icon(
                                  Icons.check_circle,
                                  size: 16,
                                  color: AppColors.appAccentColor,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  r,
                                  style: GoogleFonts.outfit(
                                    fontSize: 13.5,
                                    height: 1.45,
                                    color: AppColors.secondaryText,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  const SizedBox(height: 8),
                  Text(
                    exp.techStack.join('  ·  '),
                    style: GoogleFonts.outfit(
                      fontSize: 12,
                      color: AppColors.mutedText,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  // ── Skills grouped (Hostinger style) ────────────────────────────────────

  Widget _buildSkills(bool isDesktop) {
    final groups = <String, List<Skill>>{
      'Backend & APIs': controller.skills
          .where(
            (s) => [
              'Java 17',
              'Spring Boot 3',
              'Microservices',
              'RESTful APIs',
              'PostgreSQL & SQL',
              'Redis Caching',
            ].contains(s.name),
          )
          .toList(),
      'Security & Cloud': controller.skills
          .where(
            (s) => [
              'Keycloak & OAuth2',
              'Microsoft Azure',
              'Docker & CI/CD',
            ].contains(s.name),
          )
          .toList(),
      'AI & Observability': controller.skills
          .where(
            (s) => [
              'Spring AI & GenAI',
              'OpenTelemetry',
              'Git & GitHub',
            ].contains(s.name),
          )
          .toList(),
    };

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 40 : 20,
        vertical: isDesktop ? 88 : 56,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader(
            eyebrow: 'Capabilities',
            title: AppStrings.skillsTitle,
            subtitle: null,
            icon: Icons.bolt_rounded,
            isDesktop: isDesktop,
          ),
          const SizedBox(height: 36),
          ...groups.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.key,
                    style: GoogleFonts.syne(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryText,
                    ),
                  ),
                  const SizedBox(height: 14),
                  ...entry.value.map((skill) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: SvgPicture.asset(
                              skill.iconPath,
                              colorFilter: const ColorFilter.mode(
                                AppColors.appAccentColor,
                                BlendMode.srcIn,
                              ),
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(
                                Icons.code,
                                size: 18,
                                color: AppColors.appAccentColor,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          SizedBox(
                            width: isDesktop ? 170 : 120,
                            child: Text(
                              skill.name,
                              style: TextStyles.skillName,
                            ),
                          ),
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                value: skill.proficiency,
                                minHeight: 6,
                                backgroundColor: AppColors.surfaceColor,
                                valueColor: const AlwaysStoppedAnimation(
                                  AppColors.appAccentColor,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            '${(skill.proficiency * 100).round()}%',
                            style: TextStyles.skillPercentage,
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  // ── Contact band ────────────────────────────────────────────────────────

  Widget _buildContactBand(bool isDesktop) {
    return Container(
      width: double.infinity,
      color: AppColors.pureBlack,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 40 : 20,
        vertical: isDesktop ? 88 : 56,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: _maxWidth),
          child: isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: _contactCopy(isDesktop)),
                    const SizedBox(width: 48),
                    SizedBox(width: 360, child: _contactActions()),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _contactCopy(isDesktop),
                    const SizedBox(height: 28),
                    _contactActions(),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _contactCopy(bool isDesktop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Let's build something resilient.",
          style: GoogleFonts.syne(
            fontSize: isDesktop ? 36 : 26,
            fontWeight: FontWeight.w800,
            color: AppColors.pureWhite,
            letterSpacing: -0.8,
            height: 1.15,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          AppStrings.contactPageDescription,
          style: GoogleFonts.outfit(
            fontSize: isDesktop ? 16 : 14,
            height: 1.55,
            color: AppColors.pureWhite.withValues(alpha: 0.72),
          ),
        ),
        const SizedBox(height: 8),
        const ContactButtons(onDark: true),
      ],
    );
  }

  Widget _contactActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _primaryBtn(
          AppStrings.sendButtonText,
          () => Get.to(() => ContactView()),
          fullWidth: true,
        ),
        const SizedBox(height: 12),
        _outlineBtn(
          AppStrings.bookConsultation,
          _openCalendly,
          onDark: true,
          fullWidth: true,
        ),
        const SizedBox(height: 12),
        _outlineBtn(
          AppStrings.chatAction,
          _showChatBottomSheet,
          onDark: true,
          fullWidth: true,
        ),
      ],
    );
  }

  Widget _buildFooter(bool isDesktop) {
    return ColoredBox(
      color: AppColors.pureBlack,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(
          isDesktop ? 40 : 20,
          0,
          isDesktop ? 40 : 20,
          36,
        ),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: AppColors.pureWhite.withValues(alpha: 0.1),
            ),
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: _maxWidth),
            child: Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Text(
                '© ${DateTime.now().year} Buddhadev Sahu · Java Backend Developer',
                style: GoogleFonts.outfit(
                  fontSize: 13,
                  color: AppColors.pureWhite.withValues(alpha: 0.45),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ── Shared UI ───────────────────────────────────────────────────────────

  Widget _sectionHeader({
    required String eyebrow,
    required String title,
    String? subtitle,
    required IconData icon,
    required bool isDesktop,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: AppColors.accentSoft,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppColors.appAccentColor, size: 22),
            ),
            const SizedBox(width: 12),
            Text(
              eyebrow.toUpperCase(),
              style: GoogleFonts.outfit(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.6,
                color: AppColors.appAccentColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Text(
          title,
          style: isDesktop
              ? TextStyles.sectionTitle
              : TextStyles.sectionTitleMobile,
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 12),
          Text(
            subtitle,
            style: isDesktop
                ? TextStyles.sectionDescription
                : TextStyles.sectionDescriptionMobile,
          ),
        ],
      ],
    );
  }

  Widget _primaryBtn(
    String label,
    VoidCallback onTap, {
    bool fullWidth = false,
  }) {
    final child = Material(
      color: AppColors.appAccentColor,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.pureWhite,
            ),
          ),
        ),
      ),
    );
    return fullWidth ? SizedBox(width: double.infinity, child: child) : child;
  }

  Widget _outlineBtn(
    String label,
    VoidCallback onTap, {
    bool onDark = false,
    bool fullWidth = false,
  }) {
    final border = onDark
        ? AppColors.pureWhite.withValues(alpha: 0.35)
        : AppColors.lightBorder;
    final fg = onDark ? AppColors.pureWhite : AppColors.primaryText;
    final child = Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: border),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: fg,
            ),
          ),
        ),
      ),
    );
    return fullWidth ? SizedBox(width: double.infinity, child: child) : child;
  }

  Widget _linkMeta(IconData icon, String label, VoidCallback? onTap) {
    final row = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18, color: AppColors.appAccentColor),
        const SizedBox(width: 8),
        Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.secondaryText,
          ),
        ),
      ],
    );
    if (onTap == null) return row;
    return InkWell(onTap: onTap, child: row);
  }

  Widget _buildLoadingScreen() {
    return Scaffold(
      backgroundColor: AppColors.pureWhite,
      body: Center(
        child: Lottie.asset(
          AppAssets.loaderAnimation,
          width: AppDimensions.loadingAnimationSize,
          height: AppDimensions.loadingAnimationSize,
          errorBuilder: (context, error, stackTrace) =>
              const CircularProgressIndicator(color: AppColors.appAccentColor),
        ),
      ),
    );
  }

  Widget _buildMobileDrawer() {
    return Drawer(
      backgroundColor: AppColors.pureWhite,
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 24),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
              child: Text(
                'Buddhadev Sahu',
                style: GoogleFonts.syne(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            _drawerItem('About', _aboutKey),
            _drawerItem('Services', _servicesKey),
            _drawerItem('Work', _projectsKey),
            _drawerItem('Experience', _experienceKey),
            _drawerItem('Skills', _skillsKey),
            _drawerItem('Contact', _contactKey),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem(String title, GlobalKey key) {
    return ListTile(
      title: Text(title, style: GoogleFonts.outfit(fontWeight: FontWeight.w500)),
      onTap: () {
        Get.back();
        Future.delayed(const Duration(milliseconds: 200), () {
          _scrollToSection(key);
        });
      },
    );
  }

  Widget _buildChatFab() {
    return FloatingActionButton.extended(
      onPressed: _showChatBottomSheet,
      icon: const Icon(Icons.chat_bubble_outline),
      label: Text(
        'Chat',
        style: GoogleFonts.outfit(fontWeight: FontWeight.w600),
      ),
    );
  }

  void _scrollToSection(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 550),
      curve: Curves.easeInOutCubic,
      alignment: 0.05,
    );
  }

  void _showChatBottomSheet() {
    Get.bottomSheet(
      const ChatBottomSheet(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  Future<void> _openCalendly() async => _launchURL(AppStrings.calendlyUrl);
  Future<void> _downloadCv() async => _launchURL(AppStrings.cvDownloadUrl);

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  _StickyHeaderDelegate({required this.child});

  @override
  double get minExtent => 72;
  @override
  double get maxExtent => 72;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return child;
  }

  @override
  bool shouldRebuild(covariant _StickyHeaderDelegate oldDelegate) =>
      oldDelegate.child != child;
}
