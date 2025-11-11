import 'package:deligo_driver/presentation/wallet/widgets/transaction_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:deligo_driver/common/loading_view.dart';
import 'package:deligo_driver/core/extensions/extensions.dart';
import 'package:deligo_driver/core/theme/color_palette.dart';
import 'package:deligo_driver/core/utils/is_dark_mode.dart';
import 'package:deligo_driver/core/utils/localize.dart';
import 'package:deligo_driver/core/widgets/error_view.dart';
import 'package:deligo_driver/presentation/wallet/provider/provider.dart';
import 'package:intl/intl.dart';

import '../../../core/utils/custom_date_picker.dart';

Widget transactionHistory(BuildContext context) => Expanded(
  child: Consumer(
    builder: (context, ref, _) {
      final state = ref.watch(transactionHistoryProvider);
      final notifier = ref.read(transactionHistoryProvider.notifier);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  localize(context).transactions,
                  style: context.bodyMedium?.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode() ? Colors.white : const Color(0xFF24262D),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              InkWell(
                onTap: () async {
                  final date = await customDatePickerReturnDate(
                    context,
                    initialDate: state.dateTime,
                    lastDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(const Duration(days: 1000)),
                  );
                  notifier.updateDateTime(date);
                  // Wait a bit for state to update, then fetch
                  await Future.delayed(const Duration(milliseconds: 50));
                  notifier.getTransactionHistory(refresh: true);
                },
                child: Row(
                  children: [
                    Text(
                      state.dateTime == null
                          ? 'N/A'
                          : DateFormat('dd/MM/yyyy', 'en').format(state.dateTime!),
                      style: context.bodyMedium?.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF687387),
                      ),
                    ),
                    Gap(8.w),
                    Icon(
                      Icons.calendar_month,
                      color: ColorPalette.primary50,
                      size: 24.h,
                    ),
                    Gap(16.w),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          transactionList(context),
        ],
      );
    },
  ),
);

class TransactionListWidget extends ConsumerStatefulWidget {
  const TransactionListWidget({super.key});

  @override
  ConsumerState<TransactionListWidget> createState() => _TransactionListWidgetState();
}

class _TransactionListWidgetState extends ConsumerState<TransactionListWidget> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController..removeListener(_onScroll)
    ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(transactionHistoryProvider.notifier).loadMoreTransactions();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(transactionHistoryProvider);
    final transactions = state.transactions;

    return transactions.when(
      initial: () => const SizedBox.shrink(),
      loading: () => const LoadingView(),
      error: (e) => ErrorView(message: e.message),
      success: (data) {
        if (data.isEmpty) {
          return Center(
            child: Text(localize(context).no_transactions_found),
          );
        }

        return ListView.builder(
          controller: _scrollController,
          padding: EdgeInsets.only(bottom: 20.h),
          itemCount: data.length + (state.isPaginating ? 1 : 0),
          itemBuilder: (context, index) {
            if (index < data.length) {
              return TransactionTile(wallet: data[index]);
            } else {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Center(child: CircularProgressIndicator()),
              );
            }
          },
        );
      },
    );
  }
}

Widget transactionList(BuildContext context) => const Expanded(
  child: TransactionListWidget(),
);