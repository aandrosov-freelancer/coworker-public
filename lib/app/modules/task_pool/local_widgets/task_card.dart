import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/values/dimensions.dart';
import '../../../core/values/assets.dart';
import '../../../core/values/colors.dart';
import '../../../core/values/strings.dart';
import '../controller.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final bool isDesktop =
        MediaQuery.of(context).size.width >= AppDimensions.minDesktopWidth;

    return Container(
      padding: EdgeInsets.all(isDesktop ? 24 : 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            offset: Offset(0, 4),
            blurRadius: 12,
          ),
        ],
      ),
      child: isDesktop ? _buildDesktopLayout() : _buildMobileLayout(),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _buildTaskInfo()),
        const SizedBox(width: 24),
        Container(width: 1, height: 150, color: AppColors.borderColor),
        const SizedBox(width: 24),
        SizedBox(width: 200, child: _buildActionArea(true)),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTaskInfo(),
        const SizedBox(height: 16),
        const Divider(color: AppColors.borderColor),
        const SizedBox(height: 16),
        _buildActionArea(false),
      ],
    );
  }

  Widget _buildTaskInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          task.title,
          style: GoogleFonts.manrope(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.taskTitle,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 16,
          runSpacing: 8,
          children: [
            Text(
              '${AppStrings.postedAt} ${task.postedAt}',
              style: GoogleFonts.manrope(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.profileJobTitle,
              ),
            ),
            SvgPicture.asset(AppAssets.icClock, width: 15, height: 15),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          task.description,
          style: GoogleFonts.manrope(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.profileJobTitle,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: task.tags.map((tag) => _buildTag(tag)).toList(),
        ),
      ],
    );
  }

  Widget _buildActionArea(bool isDesktop) {
    return Column(
      crossAxisAlignment: isDesktop
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      mainAxisAlignment: isDesktop
          ? MainAxisAlignment.spaceBetween
          : MainAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: isDesktop
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Text(
              task.price,
              style: GoogleFonts.manrope(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: AppColors.priceText,
              ),
            ),
            Text(
              AppStrings.projectEstimate,
              style: GoogleFonts.manrope(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.profileJobTitle,
              ),
            ),
          ],
        ),
        SizedBox(height: isDesktop ? 48 : 24),
        SizedBox(
          width: isDesktop ? null : double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.priceText,
              foregroundColor: AppColors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppStrings.apply,
                  style: GoogleFonts.manrope(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 8),
                SvgPicture.asset(AppAssets.icArrowRightWhite),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTag(String tag) {
    final isFirst = task.tags.indexOf(tag) == 0;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: isFirst ? AppColors.activeTagBg : AppColors.tagBg,
        borderRadius: BorderRadius.circular(9999),
        border: isFirst ? Border.all(color: AppColors.successBorder) : null,
      ),
      child: Text(
        tag,
        style: GoogleFonts.manrope(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: isFirst ? AppColors.activeTagText : AppColors.taskTitle,
        ),
      ),
    );
  }
}
