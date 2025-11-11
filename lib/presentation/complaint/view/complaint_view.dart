import 'package:deligo_driver/common/error_view.dart';
import 'package:deligo_driver/common/loading_view.dart';
import 'package:deligo_driver/core/extensions/extensions.dart';
import 'package:deligo_driver/core/theme/color_palette.dart';
import 'package:deligo_driver/core/utils/helpers.dart';
import 'package:deligo_driver/core/utils/is_dark_mode.dart';
import 'package:deligo_driver/core/widgets/app_bar/app_bar.dart';
import 'package:deligo_driver/core/widgets/buttons/app_primary_button.dart';
import 'package:deligo_driver/core/widgets/custom_dropdown.dart';
import 'package:deligo_driver/data/models/complaint_model/Data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../provider/complaint_provider.dart';
import '../view_model/complaint_notifier.dart';

class ComplaintView extends ConsumerStatefulWidget {
  final num? orderId;
  const ComplaintView({super.key, this.orderId});

  @override
  ConsumerState<ComplaintView> createState() => _ComplaintViewState();
}

class _ComplaintViewState extends ConsumerState<ComplaintView> {
  final formKey = GlobalKey<FormState>();
  final messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final notifier = ref.read(complaintProvider.notifier)
      ..reset()
      ..getComplaintTypes()
      ..getMyComplaintData();

      _scrollController.addListener(() {
        if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200) {
          notifier.getMyComplaintData(isPagination: true);
        }
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(complaintProvider);
    final notifier = ref.watch(complaintProvider.notifier);

    return Scaffold(
      appBar: mainAppBar(context, title: 'My Complaints'),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SafeArea(
        child: FloatingActionButton(
          backgroundColor: ColorPalette.primary50,
          onPressed: () {
            messageController.clear();
            notifier.resetOther();
            showAddComplaintModal(
              context,
              notifier: notifier,
              state: state,
              formKey: formKey,
              messageController: messageController,
              orderId: widget.orderId,
            );
          },
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: state.myComplaintList.when(
          loading: () => const LoadingView(),
          error: (err) => ErrorView(
            message: err.message,
            onRetry: () => notifier.getMyComplaintData(),
          ),
          success: (list) {
            if (list.isEmpty) {
              return const Center(child: Text('No complaints found.'));
            }

            return RefreshIndicator(
              onRefresh: () async {
                notifier.getMyComplaintData();
              },
              child: ListView.separated(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                separatorBuilder: (_, _) => const SizedBox(height: 12),
                itemCount: list.length + (state.isPaginating ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index >= list.length) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  final complaint = list[index];
                  final complaintTitle = complaint.complain?.title ?? 'N/A';
                  final message = complaint.message ?? '';
                  final status = complaint.status ?? 'UNKNOWN';
                  final priority = complaint.priority ?? 'N/A';

                  return Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isDarkMode()
                          ? Colors.grey[850]
                          : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          complaintTitle,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: context.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: ColorPalette.primary50,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          message,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: context.bodyMedium,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _statusChip(status),
                            _priorityChip(priority),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }, initial: ()=> const SizedBox.shrink(),
        ),
      ),
    );
  }

  Widget _statusChip(String status) {
    Color bg;
    switch (status.toUpperCase()) {
      case 'PENDING':
        bg = Colors.orange;
        break;
      case 'RESOLVED':
        bg = Colors.green;
        break;
      default:
        bg = Colors.grey;
    }

    return Chip(
      backgroundColor: bg.withValues(alpha: 0.2),
      label: Text(
        status,
        style: TextStyle(color: bg, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _priorityChip(String priority) {
    Color color;
    switch (priority.toUpperCase()) {
      case 'HIGH':
        color = Colors.red;
        break;
      case 'MEDIUM':
        color = Colors.orange;
        break;
      default:
        color = Colors.blueGrey;
    }

    return Chip(
      backgroundColor: color.withValues(alpha: 0.2),
      label: Text(
        priority,
        style: TextStyle(color: color, fontWeight: FontWeight.w600),
      ),
    );
  }
}


void showAddComplaintModal(
    BuildContext context, {
      required ComplaintNotifier notifier,
      required ComplaintState state,
      required GlobalKey<FormState> formKey,
      required TextEditingController messageController,
      required num? orderId,
    }) {
  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.7,
        minChildSize: 0.6,
        maxChildSize: 0.95,
        builder: (context, scrollController) => Container(
            decoration: BoxDecoration(
              color: isDarkMode() ? Colors.grey[900] : Colors.white,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: MediaQuery.of(context).viewInsets.bottom + 16,
              top: 16,
            ),
            child: Consumer(
              builder: (context, ref, _) {
                final localState = ref.watch(complaintProvider);
                final notifier = ref.watch(complaintProvider.notifier);

                return SingleChildScrollView(
                  controller: scrollController,
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Center(
                          child: Container(
                            width: 40,
                            height: 4,
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade400,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        Text(
                          'Create a Complaint',
                          textAlign: TextAlign.center,
                          style: context.bodyMedium?.copyWith(fontSize: 18, fontWeight: FontWeight.bold, color: isDarkMode() ? Colors.white : Colors.black),
                        ),
                        const SizedBox(height: 20),

                        // Complaint type dropdown
                        customDropdown<ComplaintType>(
                          context,
                          hint: 'Complaint Type',
                          value: localState.selectedComplaint,
                          items: localState.typeList.whenOrNull(
                            success: (list) => list
                                .map(
                                  (p) => DropdownMenuItem<ComplaintType>(
                                value: p,
                                child: Text(
                                  p.title ?? '',
                                  style: context.bodyMedium,
                                ),
                              ),
                            )
                                .toList(),
                          ),
                          onChanged: (v) {
                            if (v != null) notifier.selectComplaintType(v);
                          },
                          validator: (v) =>
                          v == null ? 'Please select complaint type' : null,
                        ),
                        Gap(16.h),

                        // Priority dropdown
                        customDropdown<String>(
                          context,
                          hint: 'Priority',
                          value: localState.selectedPriority,
                          items: localState.priorityList
                              .map(
                                (p) => DropdownMenuItem<String>(
                              value: p,
                              child: Text(p, style: context.bodyMedium),
                            ),
                          )
                              .toList(),
                          onChanged: (v) {
                            if (v != null) {
                              ref
                                  .read(complaintProvider.notifier)
                                  .selectPriority(v);
                            }
                          },
                          validator: (v) =>
                          v == null ? 'Please select priority' : null,
                        ),

                        const SizedBox(height: 16),

                        // Message input
                        TextFormField(
                          controller: messageController,
                          maxLines: 4,
                          decoration: InputDecoration(
                            labelText: 'Message',
                            alignLabelWithHint: true,
                            filled: true,
                            fillColor:
                            isDarkMode() ? Colors.black : Colors.grey[100],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) {
                              return 'Please enter a message';
                            }
                            if (v.trim().length < 5) {
                              return 'Message too short';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 20),

                        AppPrimaryButton(
                          isLoading: ref
                              .watch(complaintProvider)
                              .createComplaint
                              .whenOrNull(loading: () => true) ??
                              false,
                          onPressed: () {
                            if (formKey.currentState?.validate() ?? false) {
                              if (localState.selectedComplaint == null) {
                                showNotification(
                                    message: 'Please select complaint type');
                                return;
                              }

                              ref
                                  .read(complaintProvider.notifier)
                                  .createComplaint(
                                orderId: orderId,
                                msg: messageController.text.trim(),
                              );
                            }
                          },
                          title: 'Submit Complaint',
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
      ),
  );
}
