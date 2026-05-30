import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/values/assets.dart';
import '../core/values/colors.dart';
import '../core/values/strings.dart';

class AppDrawer extends StatelessWidget {
  final String activeRoute;

  const AppDrawer({super.key, required this.activeRoute});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.white,
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: AppColors.profileHeaderBg),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(AppAssets.logo, width: 64, height: 64),
                  const SizedBox(height: 12),
                  Text(
                    AppStrings.appName,
                    style: GoogleFonts.manrope(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          _buildDrawerItem(
            AppStrings.navMarketplace,
            AppAssets.icMarketplace,
            '/marketplace',
          ),
          _buildDrawerItem(
            AppStrings.navExchange,
            AppAssets.icExchange,
            '/exchange',
          ),
          _buildDrawerItem(
            AppStrings.navMessages,
            AppAssets.icMessages,
            '/messages',
          ),
          _buildDrawerItem(
            AppStrings.navProfile,
            AppAssets.icProfile,
            '/profile',
          ),
          const Spacer(),
          const Divider(),
          _buildDrawerItem(AppStrings.navFaq, AppAssets.icFaq, '/faq'),
          _buildDrawerItem(AppStrings.navExit, AppAssets.icExit, '/exit'),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(String title, String icon, String route) {
    final isActive = activeRoute == route;
    return ListTile(
      leading: SvgPicture.asset(
        icon,
        colorFilter: ColorFilter.mode(
          isActive ? AppColors.primaryGreen : AppColors.profileJobTitle,
          BlendMode.srcIn,
        ),
      ),
      title: Text(
        title,
        style: GoogleFonts.manrope(
          fontSize: 16,
          fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
          color: isActive ? AppColors.primaryGreen : AppColors.profileJobTitle,
        ),
      ),
      selected: isActive,
      onTap: () {
        Get.back(); // Close drawer
        if (!isActive) Get.toNamed(route);
      },
    );
  }
}
