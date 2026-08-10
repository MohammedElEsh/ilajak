import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ilajak/core/constants/app_strings.dart';
import 'package:ilajak/core/routing/route_names.dart';
import 'package:ilajak/core/shared/chips/app_filter_chip.dart';
import 'package:ilajak/core/shared/feedback/feedback_handler.dart';
import 'package:ilajak/core/shared/inputs/search_field.dart';
import 'package:ilajak/core/shared/layout/app_top_bar.dart';
import 'package:ilajak/core/shared/layout/bottom_nav_clearance.dart';
import 'package:ilajak/core/theme/colors/app_color_scheme.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';
import 'package:ilajak/features/doctor/notifications/presentation/widgets/notification_card.dart';

enum _Category { appointments, patients, general }

/// TODO(backend): still mock data, synthesized from a few variants — swap
/// for the real doctor-notifications cubit once the API/integration work
/// starts. Search doesn't filter yet (same TODO as before).
///
/// INTERACTIVITY PASS: everything that can honestly work on local state
/// alone now does — tap to mark read, "mark all read", the 4 filter chips,
/// and the per-notification action buttons. None of it pretends to talk
/// to a server; "Accept" / "Open Labs" just resolve the notification
/// locally + confirm with a toast, and "View Details" goes to the real
/// Schedule tab (not a fake specific-appointment screen, since this
/// notification isn't backed by a real appointment id).
class DoctorNotificationsView extends StatefulWidget {
  const DoctorNotificationsView({super.key});

  @override
  State<DoctorNotificationsView> createState() => _DoctorNotificationsViewState();
}

class _DoctorNotificationsViewState extends State<DoctorNotificationsView> {
  static const _filterKeys = [
    AppStrings.doctorNotificationsFilterAll,
    AppStrings.doctorNotificationsFilterUnread,
    AppStrings.doctorNotificationsFilterAppointments,
    AppStrings.doctorNotificationsFilterPatients,
  ];

  int _selectedFilterIndex = 0;

  /// ids the person has read (by tapping the tile, "mark all read", or an
  /// action button). Everything not in here uses its original mock
  /// unread state.
  final Set<String> _readIds = {};

  /// ids whose action buttons have been resolved (Accept / Open Labs) —
  /// hides the actions row so it doesn't look like it's still pending.
  final Set<String> _handledIds = {};

  TextStyle get _boldSpan =>
      AppTypography.semiBold14.copyWith(color: context.appColors.textPrimary);
  TextStyle get _urgentSpan =>
      AppTypography.semiBold14.copyWith(color: context.appColors.error);

  void _markRead(String id) {
    if (_readIds.contains(id)) return;
    setState(() => _readIds.add(id));
  }

  void _markAllRead() {
    setState(() {
      for (final item in _allItems()) {
        _readIds.add(item.id);
      }
    });
  }

  void _resolve(String id, String confirmationMessage) {
    setState(() {
      _readIds.add(id);
      _handledIds.add(id);
    });
    FeedbackHandler.success(confirmationMessage);
  }

  bool _isUnread(_Item item) => item.defaultUnread && !_readIds.contains(item.id);

  @override
  Widget build(BuildContext context) {
    final sections = [
      (
        title: AppStrings.doctorNotificationsSectionToday.tr(),
        items: _todayItems(),
      ),
      (
        title: AppStrings.doctorNotificationsSectionYesterday.tr(),
        items: _yesterdayItems(),
      ),
      (
        title: AppStrings.doctorNotificationsSectionEarlier.tr(),
        items: _earlierItems(),
      ),
    ];

    final visibleSections = sections
        .map((s) => (title: s.title, items: s.items.where(_matchesFilter).toList()))
        .where((s) => s.items.isNotEmpty)
        .toList();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: Scaffold(
        appBar: AppTopBar(
          leadingWidget: GestureDetector(
            onTap: () {
              // TODO(design): same open-a-Drawer TODO as Doctor Profile.
            },
            child: Icon(Icons.menu, color: context.appColors.primary, size: 24.sp),
          ),
          titleWidget: Text(
            AppStrings.doctorNotificationsTitle.tr(),
            style: AppTypography.semiBold18.copyWith(color: context.appColors.primary),
          ),
          actionWidget: TextButton(
            onPressed: _markAllRead,
            child: Text(
              AppStrings.doctorNotificationsMarkAllRead.tr(),
              style: AppTypography.medium14.copyWith(color: context.appColors.primary),
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 14.h),
              SearchField(
                hint: AppStrings.doctorNotificationsSearchHint.tr(),
                onChanged: (_) {},
              ),
              SizedBox(height: 14.h),
              SizedBox(
                height: 38.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _filterKeys.length,
                  separatorBuilder: (_, __) => SizedBox(width: 8.w),
                  itemBuilder: (context, index) {
                    return AppFilterChip(
                      label: _filterKeys[index].tr(),
                      selected: index == _selectedFilterIndex,
                      onTap: () => setState(() => _selectedFilterIndex = index),
                    );
                  },
                ),
              ),
              SizedBox(height: 18.h),

              Expanded(
                child: visibleSections.isEmpty
                    ? _EmptyState(message: AppStrings.doctorNotificationsEmptyState.tr())
                    : ListView(
                        padding: EdgeInsets.only(bottom: 24.h + context.bottomNavClearance),
                        children: [
                          for (final section in visibleSections)
                            _DaySection(
                              title: section.title,
                              unreadCount: section.items.where(_isUnread).length,
                              tiles: [for (final item in section.items) _buildTile(item)],
                            ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _matchesFilter(_Item item) {
    return switch (_selectedFilterIndex) {
      1 => _isUnread(item),
      2 => item.category == _Category.appointments,
      3 => item.category == _Category.patients,
      _ => true,
    };
  }

  Widget _buildTile(_Item item) {
    final isUnread = _isUnread(item);
    final showActions = item.buildActions != null && !_handledIds.contains(item.id);

    return NotificationCard(
      icon: item.icon,
      tone: item.tone,
      title: item.title,
      timestamp: item.timestamp,
      isUnread: isUnread,
      description: item.description,
      onTap: () => _markRead(item.id),
      actions: showActions ? item.buildActions!(this) : const [],
    );
  }

  List<_Item> _allItems() => [..._todayItems(), ..._yesterdayItems(), ..._earlierItems()];

  List<_Item> _todayItems() => [
        _Item(
          id: 'new_appointment',
          icon: Icons.calendar_today_outlined,
          tone: NotificationTone.primary,
          category: _Category.appointments,
          title: 'New Appointment',
          timestamp: 'Just now',
          defaultUnread: true,
          description: TextSpan(children: [
            TextSpan(text: 'James Wilson', style: _boldSpan),
            const TextSpan(text: ' booked a consultation for 2:30 PM today.'),
          ]),
          buildActions: (state) => [
            _ActionPill(
              label: AppStrings.doctorScheduleViewDetails.tr(),
              filled: true,
              onPressed: () => context.go(RouteNames.doctorScheduleFullPath),
            ),
            _ActionPill(
              label: AppStrings.doctorNotificationsAccept.tr(),
              filled: false,
              onPressed: () => state._resolve('new_appointment', 'Appointment confirmed.'),
            ),
          ],
        ),
        _Item(
          id: 'lab_result',
          icon: Icons.science_outlined,
          tone: NotificationTone.urgent,
          category: _Category.patients,
          title: 'Lab Result Ready',
          timestamp: '45m ago',
          defaultUnread: true,
          description: TextSpan(children: [
            const TextSpan(text: 'CBC results uploaded for '),
            TextSpan(text: 'Sarah Chen', style: _boldSpan),
            const TextSpan(text: '. '),
            TextSpan(text: 'Urgent review recommended.', style: _urgentSpan),
          ]),
          buildActions: (state) => [
            _ActionPill(
              label: AppStrings.doctorNotificationsOpenLabs.tr(),
              filled: true,
              // No doctor-facing labs screen exists yet to open for real —
              // resolving locally instead of faking a destination.
              onPressed: () => state._resolve('lab_result', 'Marked as reviewed.'),
            ),
          ],
        ),
        _Item(
          id: 'appointment_cancelled',
          icon: Icons.event_busy_outlined,
          tone: NotificationTone.neutral,
          category: _Category.appointments,
          title: 'Appointment Cancelled',
          timestamp: '2 hours ago',
          description: TextSpan(children: [
            TextSpan(text: 'Michael Rodriguez', style: _boldSpan),
            const TextSpan(text: ' cancelled his '),
            TextSpan(text: '4:00 PM slot', style: _urgentSpan),
            const TextSpan(text: '. The slot is now available for other patients.'),
          ]),
        ),
      ];

  List<_Item> _yesterdayItems() => [
        _Item(
          id: 'new_patient',
          icon: Icons.person_add_alt_outlined,
          tone: NotificationTone.primary,
          category: _Category.patients,
          title: 'New Patient Assigned',
          timestamp: 'Yesterday, 9:15 AM',
          description: TextSpan(children: [
            TextSpan(text: 'Sarah Chen', style: _boldSpan),
            const TextSpan(text: ' has been added to your care list. Review her initial screening.'),
          ]),
        ),
        _Item(
          id: 'rescheduled',
          icon: Icons.history,
          tone: NotificationTone.neutral,
          category: _Category.appointments,
          title: 'Rescheduled',
          timestamp: 'Yesterday, 8:30 AM',
          description: TextSpan(children: [
            TextSpan(text: 'Dr. Elena Vance', style: _boldSpan),
            const TextSpan(text: ' moved the recurring weekly review to 11:30 AM.'),
          ]),
        ),
        _Item(
          id: 'prescription_updated',
          icon: Icons.medication_outlined,
          tone: NotificationTone.neutral,
          category: _Category.patients,
          title: 'Prescription Updated',
          timestamp: 'Yesterday',
          description: TextSpan(children: [
            const TextSpan(text: 'Lisinopril dose adjusted for '),
            TextSpan(text: 'Michael Rodriguez', style: _boldSpan),
            const TextSpan(text: ' from 10mg to 20mg.'),
          ]),
        ),
      ];

  List<_Item> _earlierItems() => [
        _Item(
          id: 'medical_article',
          icon: Icons.description_outlined,
          tone: NotificationTone.neutral,
          category: _Category.general,
          title: 'New Medical Article',
          timestamp: '2 days ago',
          description: const TextSpan(
            text: 'Latest Clinical Guidelines for Hypertension: 2024 Updates for '
                'Primary Care Physicians.',
          ),
        ),
        _Item(
          id: 'system_alert',
          icon: Icons.warning_amber_rounded,
          tone: NotificationTone.urgent,
          category: _Category.general,
          title: 'Urgent System Alert',
          timestamp: '3 days ago',
          description: const TextSpan(
            text: 'Clinic connectivity backup initiated. Data synchronization might be delayed.',
          ),
        ),
        _Item(
          id: 'software_update',
          icon: Icons.campaign_outlined,
          tone: NotificationTone.neutral,
          category: _Category.general,
          title: 'Software Update',
          timestamp: '4 days ago',
          description: const TextSpan(
            text: 'Version 2.4 is now available. New patient dashboard features included.',
          ),
        ),
      ];
}

class _Item {
  _Item({
    required this.id,
    required this.icon,
    required this.tone,
    required this.category,
    required this.title,
    required this.timestamp,
    required this.description,
    this.defaultUnread = false,
    this.buildActions,
  });

  final String id;
  final IconData icon;
  final NotificationTone tone;
  final _Category category;
  final String title;
  final String timestamp;
  final InlineSpan description;
  final bool defaultUnread;
  final List<Widget> Function(_DoctorNotificationsViewState state)? buildActions;
}

/// One day's worth of notifications inside a single flat surface — ONE
/// shadow per group instead of one per item, with `Divider`s marking
/// individual notifications. The unread-count pill is now the real,
/// currently-live count for that section (recomputed on every rebuild),
/// not a hardcoded number.
class _DaySection extends StatelessWidget {
  const _DaySection({required this.title, required this.tiles, this.unreadCount = 0});

  final String title;
  final List<Widget> tiles;
  final int unreadCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: AppTypography.semiBold13.copyWith(
                  color: context.appColors.textSecondary,
                  letterSpacing: .4,
                ),
              ),
              if (unreadCount > 0) ...[
                SizedBox(width: 8.w),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 1.h),
                  decoration: BoxDecoration(
                    color: context.appColors.primaryLight2,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    '$unreadCount',
                    style: AppTypography.medium12.copyWith(color: context.appColors.primary),
                  ),
                ),
              ],
            ],
          ),
          SizedBox(height: 10.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            decoration: BoxDecoration(
              color: context.appColors.surface,
              borderRadius: BorderRadius.circular(18.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: .04),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                for (int i = 0; i < tiles.length; i++) ...[
                  tiles[i],
                  if (i != tiles.length - 1) Divider(height: 1, color: context.appColors.divider),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.notifications_none,
            color: context.appColors.textSecondary.withValues(alpha: .4),
            size: 32.sp,
          ),
          SizedBox(height: 8.h),
          Text(message, style: AppTypography.regular14.copyWith(color: context.appColors.textSecondary)),
        ],
      ),
    );
  }
}

/// Compact, content-sized action button — sized to its label, not
/// stretched full-width.
class _ActionPill extends StatelessWidget {
  const _ActionPill({required this.label, required this.onPressed, required this.filled});

  final String label;
  final VoidCallback onPressed;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    final style = filled
        ? ElevatedButton.styleFrom(
            backgroundColor: context.appColors.primary,
            foregroundColor: context.appColors.surface,
            elevation: 0,
            minimumSize: Size(0, 32.h),
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
            textStyle: AppTypography.semiBold13,
          )
        : OutlinedButton.styleFrom(
            foregroundColor: context.appColors.primary,
            side: BorderSide(color: context.appColors.divider),
            minimumSize: Size(0, 32.h),
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
            textStyle: AppTypography.semiBold13,
          );

    return filled
        ? ElevatedButton(onPressed: onPressed, style: style, child: Text(label))
        : OutlinedButton(onPressed: onPressed, style: style, child: Text(label));
  }
}
