import 'package:app/app/core/values/dimensions.dart';
import 'package:app/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/values/assets.dart';
import '../../../core/values/colors.dart';
import '../../../core/values/strings.dart';
import '../controller.dart';

class TopNavBar extends GetView<HomeController> {
  const TopNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = context.width >= AppDimensions.minDesktopWidth;
    final bool isMobile = !isDesktop;

    return Container(
      height: 64,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 24),
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(
          bottom: BorderSide(color: AppColors.borderColor, width: 0.5),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x0D000000),
            offset: Offset(0, 1),
            blurRadius: 2,
          ),
        ],
      ),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                if (!isDesktop)
                  IconButton(
                    icon: const Icon(Icons.menu, color: AppColors.primaryGreen),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                SvgPicture.asset(AppAssets.logo, width: 32, height: 32),
                const SizedBox(width: 8),
                Text(
                  AppStrings.appName,
                  style: GoogleFonts.manrope(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primaryGreen,
                  ),
                ),
                if (isDesktop) ...[
                  const SizedBox(width: 48),
                  // _buildNavLink(
                  //   AppStrings.navMarketplace,
                  //   AppAssets.icMarketplace,
                  //   '/marketplace',
                  // ),
                  _buildNavLink(
                    AppStrings.navExchange,
                    AppAssets.icExchange,
                    controller.state?.role == .customer
                        ? AppRoutes.listTasks
                        : AppRoutes.taskPool,
                  ),
                  _buildNavLink(
                    AppStrings.navMessages,
                    AppAssets.icMessages,
                    AppRoutes.messenger,
                  ),
                  _buildNavLink(
                    AppStrings.navProfile,
                    AppAssets.icProfile,
                    AppRoutes.profile,
                  ),
                ],
              ],
            ),
            Row(
              children: [
                if (!isMobile) ...[
                  _buildIconButton(
                    AppStrings.navFaq,
                    AppAssets.icFaq,
                    onTap: () {},
                  ),
                  const SizedBox(width: 16),
                  _buildIconButton(
                    AppStrings.navExit,
                    AppAssets.icExit,
                    onTap: () {},
                  ),
                  const SizedBox(width: 16),
                  Container(width: 1, height: 32, color: AppColors.borderColor),
                  const SizedBox(width: 16),
                ],
                const CircleAvatar(
                  radius: 16,
                  backgroundColor: AppColors.backgroundDimmed,
                  backgroundImage: AssetImage(AppAssets.profileAvatar),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavLink(String title, String icon, String route) {
    final isActive = controller.currentRoute == route;
    return TextButton(
      onPressed: () {
        if (!isActive) Get.offNamed(route, id: AppRoutes.homeNavId);
      },
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: isActive
            ? AppColors.profileHeaderBg
            : Colors.transparent,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: isActive ? AppColors.profileHeaderBg : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              colorFilter: ColorFilter.mode(
                isActive
                    ? AppColors.profileNavActive
                    : AppColors.profileJobTitle,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: GoogleFonts.manrope(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isActive
                    ? AppColors.profileNavActive
                    : AppColors.profileJobTitle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton(
    String tooltip,
    String icon, {
    required VoidCallback onTap,
  }) {
    return Tooltip(
      message: tooltip,
      child: IconButton(
        onPressed: onTap,
        padding: const .all(8),
        icon: SvgPicture.asset(
          icon,
          width: 24,
          height: 24,
          colorFilter: const ColorFilter.mode(
            AppColors.profileJobTitle,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
