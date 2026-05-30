import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../core/values/assets.dart';
import '../../core/values/colors.dart';
import '../../data/model/task_model.dart';
import '../../routes/routes.dart';
import 'controller.dart';
import 'entities/task_response_entity.dart';

class TaskDetailsPage extends GetView<TaskDetailsController> {
  const TaskDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: controller.obx(
        (task) => SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 48.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTaskHeader(task!),
                    const SizedBox(height: 40),
                    _buildResponsesSection(),
                  ],
                ),
              ),
            ],
          ),
        ),
        onLoading: const Center(child: CircularProgressIndicator()),
        onError: (error) => Center(child: Text('Error: $error')),
      ),
    );
  }

  Widget _buildTaskHeader(TaskModel task) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.5)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            offset: Offset(0, 1),
            blurRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF9AF2C5),
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.check_circle_outline,
                              size: 14,
                              color: Color(0xFF0C714D),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Активен',
                              style: GoogleFonts.manrope(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF0C714D),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Row(
                        children: [
                          SvgPicture.asset(
                            AppAssets.icClock,
                            width: 14,
                            colorFilter: const ColorFilter.mode(
                              AppColors.profileJobTitle,
                              BlendMode.srcIn,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Obx(
                            () => Text(
                              controller.categoryTitle.value.isEmpty
                                  ? '...'
                                  : controller.categoryTitle.value,
                              style: GoogleFonts.manrope(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.profileJobTitle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    task.title,
                    style: GoogleFonts.manrope(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: AppColors.taskTitle,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'БЮДЖЕТ',
                    style: GoogleFonts.manrope(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.2,
                      color: AppColors.profileJobTitle,
                    ),
                  ),
                  Text(
                    '₽ ${task.budget.toInt()}',
                    style: GoogleFonts.manrope(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: AppColors.taskTitle,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Divider(color: AppColors.borderColor),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Описание',
                      style: GoogleFonts.manrope(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: AppColors.taskTitle,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      task.description,
                      style: GoogleFonts.manrope(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        height: 1.6,
                        color: AppColors.taskTitle,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 32),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundLight,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.borderColor.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Column(
                    children: [
                      _buildStatRow(
                        'Откликов',
                        controller.responses.length.toString(),
                      ),
                      const Divider(height: 32),
                      _buildStatRow(
                        'Опубликовано',
                        DateFormat(
                          'dd.MM.yyyy',
                        ).format(task.createdAt ?? DateTime.now()),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.manrope(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.profileJobTitle,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.manrope(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.taskTitle,
          ),
        ),
      ],
    );
  }

  Widget _buildResponsesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Отклики исполнителей',
              style: GoogleFonts.manrope(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: AppColors.taskTitle,
              ),
            ),
            Obx(
              () => ElevatedButton.icon(
                onPressed: controller.isMatching.value
                    ? null
                    : () => controller.runMatchAlgorithm(),
                icon: controller.isMatching.value
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.auto_awesome, size: 16),
                label: const Text('Подбор с помощью ИИ'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00342A),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Obx(() {
          if (controller.isLoadingResponses.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.responses.isEmpty) {
            return const Center(child: Text('Откликов пока нет'));
          }
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              mainAxisExtent: 520, // Adjusted for content
            ),
            itemCount: controller.responses.length,
            itemBuilder: (context, index) {
              final response = controller.responses[index];
              return _buildApplicantCard(response);
            },
          );
        }),
      ],
    );
  }

  Widget _buildApplicantCard(TaskResponseEntity response) {
    final performer = response.performer;
    final coincidence = response.coincidence;

    final card =
        Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.borderColor.withValues(alpha: 0.5),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0D000000),
                    offset: Offset(0, 1),
                    blurRadius: 2,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundImage: performer.imageUrl != null
                            ? NetworkImage(performer.imageUrl!)
                            : const AssetImage(AppAssets.profileAvatar)
                                  as ImageProvider,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${performer.firstName} ${performer.lastName}',
                              style: GoogleFonts.manrope(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: AppColors.taskTitle,
                              ),
                            ),
                            Text(
                              performer.focus ?? '',
                              style: GoogleFonts.manrope(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.profileJobTitle,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (coincidence != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(
                              0xFFAFF0DC,
                            ).withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            '${(coincidence).toInt()}% совпадение',
                            style: GoogleFonts.manrope(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF065042),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColors.borderColor.withValues(alpha: 0.5),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 32),
                          child: Text(
                            '"${response.message}"',
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.manrope(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.taskTitle,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Opacity(
                            opacity: 0.5,
                            child: SvgPicture.asset(
                              AppAssets.icMessages,
                              width: 17,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (response.matchingExplanation != null) ...[
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF9AF2C5).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: const Border(
                          left: BorderSide(color: Color(0xFF006C49), width: 4),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.lightbulb_outline,
                                size: 16,
                                color: Color(0xFF006C49),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Почему подходит:',
                                style: GoogleFonts.manrope(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF006C49),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            response.matchingExplanation!,
                            style: GoogleFonts.manrope(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.profileJobTitle,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Get.toNamed(
                            AppRoutes.messenger,
                            arguments: {'startChatWith': response.performer.id},
                            id: AppRoutes.homeNavId,
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.darkGreen,
                            foregroundColor: AppColors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Написать'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Get.toNamed(
                            AppRoutes.profile,
                            arguments: {'id': response.performer.id},
                            id: AppRoutes.homeNavId,
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.taskTitle,
                            side: const BorderSide(
                              color: AppColors.borderColor,
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Профиль'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
            .animate(key: ValueKey('entry_${response.id}'))
            .fadeIn(duration: 300.ms)
            .move(begin: const Offset(0, 20), duration: 300.ms);

    return Obx(() {
      if (controller.isMatching.value) {
        return card
            .animate(
              key: ValueKey('matching_${response.id}'),
              onPlay: (c) => c.repeat(),
            )
            .shimmer(
              duration: 1200.ms,
              color: const Color(0xFF9AF2C5).withValues(alpha: 0.2),
            )
            .shake(hz: 2, offset: const Offset(2, 0), duration: 1200.ms);
      }
      return card;
    });
  }
}
