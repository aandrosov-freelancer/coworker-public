import 'package:app/app/core/values/dimensions.dart';
import 'package:app/app/data/model/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/values/assets.dart';
import '../../core/values/colors.dart';
import '../../core/values/strings.dart';
import '../../routes/routes.dart';
import 'controller.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = context.width >= 1100;

    return controller.obx(
      (state) => Scaffold(
        backgroundColor: AppColors.backgroundLight,
        body: Stack(
          children: [
            // Main Content
            Positioned.fill(
              top: 64, // Height of TopNavBar
              child: RefreshIndicator(
                onRefresh: controller.fetchProfile,
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    vertical: 40,
                    horizontal: isDesktop ? 40 : 16,
                  ),
                  child: Column(
                    children: [
                      _buildProfileHeader(context, state!),
                      const SizedBox(height: 32),
                      _buildMainContentGrid(context),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      onLoading: const Center(child: CircularProgressIndicator()),
      onError: (error) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error: $error'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: controller.fetchProfile,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, ProfileModel profile) {
    final bool isMobile = context.width < AppDimensions.minDesktopWidth;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            offset: Offset(0, 4),
            blurRadius: 24,
          ),
        ],
      ),
      child: Column(
        children: [
          // Cover Image Section
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 192,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColors.profileHeaderBg,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                alignment: isMobile
                    ? Alignment.topCenter
                    : Alignment.centerRight,
                padding: isMobile
                    ? const EdgeInsets.only(top: 16)
                    : const EdgeInsets.only(right: 40),
                child: Text(
                  '${profile.firstName} ${profile.lastName}',
                  style: GoogleFonts.manrope(
                    fontSize: isMobile ? 32 : 60,
                    fontWeight: FontWeight.w800,
                    color: AppColors.white,
                  ),
                ),
              ),
              // Avatar
              Positioned(
                bottom: -64,
                left: isMobile ? 0 : 40,
                right: isMobile ? 0 : null,
                child: Center(
                  child: Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.white,
                      border: Border.all(color: AppColors.white, width: 4),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x1A000000),
                          offset: Offset(0, 4),
                          blurRadius: 6,
                          spreadRadius: -1,
                        ),
                      ],
                      image: profile.imageUrl != null
                          ? DecorationImage(
                              image: NetworkImage(profile.imageUrl!),
                              fit: BoxFit.cover,
                            )
                          : const DecorationImage(
                              image: AssetImage(AppAssets.profileAvatar),
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Info Section
          Padding(
            padding: EdgeInsets.fromLTRB(
              isMobile ? 16 : 224,
              isMobile ? 80 : 24,
              isMobile ? 16 : 40,
              32,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (profile.focus != null)
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    profile.focus!,
                                    style: GoogleFonts.manrope(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.profileJobTitle,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(width: 8),
                              ],
                            ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 16,
                            runSpacing: 8,
                            children: [
                              if (profile.location != null)
                                _buildIconText(
                                  AppAssets.icLocation,
                                  profile.location!,
                                ),
                              // _buildIconText(
                              //   AppAssets.icStar,
                              //   AppStrings.profileRating,
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (!isMobile)
                      _buildOutlineButton(
                        AppStrings.editProfile,
                        AppAssets.icEdit,
                      ),
                  ],
                ),
                if (isMobile) ...[
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: _buildOutlineButton(
                      AppStrings.editProfile,
                      AppAssets.icEdit,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconText(String icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(icon, width: 14, height: 14),
        const SizedBox(width: 4),
        Text(
          text,
          style: GoogleFonts.manrope(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.profileJobTitle,
          ),
        ),
      ],
    );
  }

  Widget _buildOutlineButton(String text, String icon) {
    return InkWell(
      onTap: () => Get.toNamed(AppRoutes.editProfile, id: AppRoutes.homeNavId),
      borderRadius: BorderRadius.circular(9999),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9999),
          border: Border.all(color: AppColors.primaryGreen, width: 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              colorFilter: const ColorFilter.mode(
                AppColors.primaryGreen,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              text,
              style: GoogleFonts.manrope(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainContentGrid(BuildContext context) {
    final bool isDesktop = context.width >= 1100;
    if (isDesktop) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Column
          Expanded(
            flex: 2,
            child: Column(
              children: [
                if (controller.state?.bio != null) _buildAboutMeSection(),
                // const SizedBox(height: 32),
                // _buildServicesSection(),
                // const SizedBox(height: 32),
                // _buildPortfolioSection(context),
              ],
            ),
          ),
          const SizedBox(width: 32),
          // Right Column
          // Expanded(flex: 1, child: _buildReviewsSection()),
        ],
      );
    } else {
      return Column(
        spacing: 32,
        children: [
          if (controller.state?.bio != null) _buildAboutMeSection(),
          // _buildServicesSection(),
          // _buildPortfolioSection(context),
          // _buildReviewsSection(),
        ],
      );
    }
  }

  Widget _buildAboutMeSection() {
    return _buildSectionCard(
      title: AppStrings.aboutMe,
      icon: SvgPicture.asset(
        AppAssets.icProfile,
        width: 16,
        height: 16,
        colorFilter: .mode(AppColors.darkGreen, .srcIn),
      ),
      content: Text(
        controller.state?.bio ?? '',
        style: GoogleFonts.manrope(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.profileJobTitle,
          height: 1.6,
        ),
      ),
    );
  }

  // Widget _buildReviewsSection() {
  //   return _buildSectionCard(
  //     title: AppStrings.reviews,
  //     trailing: Text(
  //       AppStrings.viewAll,
  //       style: GoogleFonts.manrope(
  //         fontSize: 14,
  //         fontWeight: FontWeight.w400,
  //         color: AppColors.primaryGreen,
  //         letterSpacing: 0.8,
  //       ),
  //     ),
  //     content: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           children: List.generate(
  //             5,
  //             (index) => const Icon(
  //               Icons.star,
  //               color: AppColors.profileRatingStar,
  //               size: 16,
  //             ),
  //           ),
  //         ),
  //         const SizedBox(height: 4),
  //         Text(
  //           AppStrings.reviewText,
  //           style: GoogleFonts.manrope(
  //             fontSize: 14,
  //             fontWeight: FontWeight.w400,
  //             color: AppColors.profileJobTitle,
  //             height: 1.5,
  //           ),
  //         ),
  //         const SizedBox(height: 12),
  //         Text(
  //           AppStrings.reviewAuthor,
  //           style: GoogleFonts.manrope(
  //             fontSize: 12,
  //             fontWeight: FontWeight.w500,
  //             color: AppColors.profileReviewAuthor,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildSectionCard({
    required String title,
    Widget? icon,
    Widget? trailing,
    required Widget content,
  }) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.3)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            offset: Offset(0, 4),
            blurRadius: 12,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null) ...[icon, const SizedBox(width: 8)],
              Text(
                title,
                style: GoogleFonts.manrope(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.profileReviewTitle,
                  letterSpacing: 0.8,
                ),
              ),
              if (trailing != null) ...[Spacer(), trailing],
            ],
          ),
          const SizedBox(height: 16),
          content,
        ],
      ),
    );
  }

  // Widget _buildServicesSection() {
  //   return _buildSectionCard(
  //     title: AppStrings.services,
  //     icon: SvgPicture.asset(
  //       AppAssets.icMarkup,
  //       width: 16,
  //       height: 16,
  //       colorFilter: const ColorFilter.mode(
  //         AppColors.darkGreen,
  //         BlendMode.srcIn,
  //       ),
  //     ),
  //     content: LayoutBuilder(
  //       builder: (context, constraints) {
  //         final bool isMobile = constraints.maxWidth < 600;
  //         final bool isTablet =
  //             constraints.maxWidth < AppDimensions.minDesktopWidth;
  //         return GridView.builder(
  //           shrinkWrap: true,
  //           physics: const NeverScrollableScrollPhysics(),
  //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //             crossAxisCount: isMobile ? 1 : 3,
  //             mainAxisSpacing: 16,
  //             crossAxisSpacing: 16,
  //             childAspectRatio: isMobile
  //                 ? 1 / 0.8
  //                 : isTablet
  //                 ? 1 / 1.5
  //                 : 9 / 8,
  //           ),
  //           itemCount: controller.services.length,
  //           itemBuilder: (context, index) {
  //             return ServiceCard(
  //               service: controller.services[index],
  //               onTap: () {
  //                 // Handle tap
  //               },
  //             );
  //           },
  //         );
  //       },
  //     ),
  //   );
  // }

  // Widget _buildPortfolioSection(BuildContext context) {
  //   final bool isMobile = context.width < 600;
  //   return _buildSectionCard(
  //     title: AppStrings.portfolio,
  //     icon: SvgPicture.asset(
  //       AppAssets.icPallete,
  //       width: 16,
  //       height: 16,
  //       colorFilter: .mode(AppColors.darkGreen, .srcIn),
  //     ),
  //     content: GridView.count(
  //       shrinkWrap: true,
  //       physics: const NeverScrollableScrollPhysics(),
  //       crossAxisCount: isMobile ? 1 : 2,
  //       mainAxisSpacing: 16,
  //       crossAxisSpacing: 16,
  //       childAspectRatio: 1.2,
  //       children: [
  //         _buildProjectCard(AppAssets.project1, "E-commerce App Design"),
  //         _buildProjectCard(AppAssets.project2, "Travel Booking Platform"),
  //         _buildProjectCard(AppAssets.project3, "Fitness Tracker UI"),
  //         _buildProjectCard(AppAssets.project4, "Fintech Dashboard Redesign"),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildProjectCard(String image, String title) {
  //   return Container(
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(8),
  //       border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.5)),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.stretch,
  //       children: [
  //         Expanded(
  //           child: ClipRRect(
  //             borderRadius: const BorderRadius.vertical(
  //               top: Radius.circular(8),
  //             ),
  //             child: Image.asset(image, fit: BoxFit.cover),
  //           ),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.all(12),
  //           child: Text(
  //             title,
  //             style: GoogleFonts.manrope(
  //               fontSize: 14,
  //               fontWeight: FontWeight.w600,
  //               color: AppColors.profileJobTitle,
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
