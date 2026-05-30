import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/values/colors.dart';
import '../../core/values/dimensions.dart';
import '../../core/values/strings.dart';
import 'controller.dart';
import 'local_widgets/filter_sidebar.dart';
import 'local_widgets/task_card.dart';
import 'local_widgets/task_search_bar.dart';

class TaskPoolPage extends GetView<TaskPoolController> {
  const TaskPoolPage({super.key});

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
                      child: isDesktop
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const FilterSidebar(),
                                const SizedBox(width: 24),
                                Expanded(child: _buildTaskList(true)),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const TaskSearchBar(),
                                const SizedBox(height: 16),
                                _buildMobileFilters(context),
                                const SizedBox(height: 16),
                                _buildTaskList(false),
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

  Widget _buildTaskList(bool isDesktop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isDesktop) ...[const TaskSearchBar(), const SizedBox(height: 24)],
        Obx(
          () => ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.tasks.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              return TaskCard(task: controller.tasks[index]);
            },
          ),
        ),
        const SizedBox(height: 24),
        Center(
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              side: const BorderSide(color: AppColors.borderColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              AppStrings.loadMoreTasks,
              style: GoogleFonts.manrope(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.priceText,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileFilters(BuildContext context) {
    return ExpansionTile(
      title: Text(
        AppStrings.filters,
        style: GoogleFonts.manrope(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.taskTitle,
        ),
      ),
      leading: const Icon(Icons.filter_list, color: AppColors.primaryGreen),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.borderColor),
      ),
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.borderColor),
      ),
      backgroundColor: AppColors.white,
      collapsedBackgroundColor: AppColors.white,
      children: const [
        Padding(
          padding: EdgeInsets.all(16.0),
          child: FilterSidebar(isMobile: true),
        ),
      ],
    );
  }
}
