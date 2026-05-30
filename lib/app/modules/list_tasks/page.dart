import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/values/assets.dart';
import '../../core/values/colors.dart';
import '../../core/values/dimensions.dart';
import '../../core/values/strings.dart';
import '../../routes/routes.dart';
import 'controller.dart';
import 'local_widgets/my_task_card.dart';

class ListTasksPage extends GetView<ListTasksController> {
  const ListTasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: Column(
        children: [
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final bool isDesktop =
                    constraints.maxWidth >= AppDimensions.minDesktopWidth;
                final double paddingHorizontal = isDesktop ? 40 : 16;
                final double paddingVertical = isDesktop ? 32 : 16;

                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: paddingHorizontal,
                    vertical: paddingVertical,
                  ),
                  child: Center(
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 1200),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHeader(isDesktop),
                          const SizedBox(height: 40),
                          _buildTaskGrid(isDesktop),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(bool isDesktop) {
    return isDesktop
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.myTasks,
                      style: GoogleFonts.manrope(
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                        color: AppColors.priceText,
                        height: 1.2,
                        letterSpacing: -0.8,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      AppStrings.myTasksDesc,
                      style: GoogleFonts.manrope(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.profileJobTitle,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              _buildPublishButton(),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.myTasks,
                style: GoogleFonts.manrope(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: AppColors.priceText,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                AppStrings.myTasksDesc,
                style: GoogleFonts.manrope(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.profileJobTitle,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 16),
              _buildPublishButton(),
            ],
          );
  }

  Widget _buildPublishButton() {
    return ElevatedButton.icon(
      onPressed: () =>
          Get.toNamed(AppRoutes.publishTask, id: AppRoutes.homeNavId),
      icon: SvgPicture.asset(
        AppAssets.icAddWork,
        width: 16,
        height: 16,
        colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
      ),
      label: Text(
        AppStrings.publishTaskButton,
        style: GoogleFonts.manrope(fontSize: 14, fontWeight: FontWeight.w600),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.priceText,
        foregroundColor: AppColors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 0,
      ),
    );
  }

  Widget _buildTaskGrid(bool isDesktop) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = 1;
        if (constraints.maxWidth > 900) {
          crossAxisCount = 3;
        } else if (constraints.maxWidth > 600) {
          crossAxisCount = 2;
        }

        return Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 100),
                child: CircularProgressIndicator(color: AppColors.priceText),
              ),
            );
          }

          if (controller.tasks.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Text(
                  'У вас пока нет задач',
                  style: GoogleFonts.manrope(
                    fontSize: 16,
                    color: AppColors.profileJobTitle,
                  ),
                ),
              ),
            );
          }

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              mainAxisExtent: 320, // Fixed height for consistency
            ),
            itemCount: controller.tasks.length,
            itemBuilder: (context, index) {
              return MyTaskCard(task: controller.tasks[index]);
            },
          );
        });
      },
    );
  }
}
