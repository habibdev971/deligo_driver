import 'package:deligo_driver/core/extensions/extensions.dart';
import 'package:deligo_driver/core/utils/is_dark_mode.dart';
import 'package:deligo_driver/presentation/dashboard/view_model/currency_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:deligo_driver/data/models/wallet_model/wallet_transaction_history_model.dart';

class TransactionTile extends ConsumerWidget {
  final Transaction wallet;
  const TransactionTile({super.key, required this.wallet});

  Color _statusColor(String status) {
    switch (status.toUpperCase()) {
      case 'PROCESSED':
        return const Color(0xFF10B981);
      case 'PENDING':
        return const Color(0xFFF59E0B);
      case 'CANCELLED':
        return const Color(0xFFEF4444);
      default:
        return Colors.grey;
    }
  }

  String _formatDate(String? date) {
    if (date == null) return '-';
    final dt = DateTime.tryParse(date);
    if (dt == null) return '-';
    final now = DateTime.now();
    final diff = now.difference(dt);

    if (diff.inDays == 0) {
      return 'Today, ${DateFormat('hh:mm a').format(dt)}';
    } else if (diff.inDays == 1) {
      return 'Yesterday, ${DateFormat('hh:mm a').format(dt)}';
    } else if (diff.inDays < 7) {
      return DateFormat('EEE, hh:mm a').format(dt);
    }
    return DateFormat('dd MMM, hh:mm a').format(dt);
  }

  String getTransactionType(String? status) {
    switch (status?.toUpperCase()) {
      case 'PROCESSED':
        return 'credit';
      case 'CANCELLED':
        return 'debit';
      default:
        return 'pending';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currency = ref.watch(currencyProvider);
    final type = getTransactionType(wallet.status);
    final isCredit = type == 'credit';
    final isPending = type == 'pending';
    final statusColor = _statusColor(wallet.status ?? '');
    final amountColor = isCredit
        ? const Color(0xFF10B981)
        : (isPending ? const Color(0xFFF59E0B) : const Color(0xFFEF4444));

    return Container(
      padding: const EdgeInsets.all(8),
      margin: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
        color: isDarkMode() ? Colors.black12 : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                // Icon
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: amountColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    isCredit
                        ? Icons.arrow_downward_rounded
                        : (isPending
                        ? Icons.access_time_rounded
                        : Icons.arrow_upward_rounded),
                    color: amountColor,
                    size: 20,
                  ),
                ),

                const SizedBox(width: 12),

                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              wallet.notes ?? 'Transaction',
                              style: context.bodyMedium?.copyWith(color: isDarkMode() ? Colors.white : Colors.black, fontSize: 12.sp, fontWeight: FontWeight.w500),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                        ],
                      ),

                      const SizedBox(height: 4),

                      Row(
                        children: [
                          Icon(
                            Icons.schedule,
                            size: 12,
                            color: Colors.grey.shade500,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              _formatDate(wallet.createdAt),
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                ),



              ],
            ),
          ),
          Gap(8.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  wallet.status ?? '',
                  style: context.bodySmall?.copyWith(fontSize: 8.sp, color: statusColor, letterSpacing: 0.3),
                ),
              ),
              // Amount
              Text(
                "${isCredit ? '+' : isPending ? '' : '-'}$currency${wallet.amount?.toStringAsFixed(2) ?? '0.00'}",
                style: context.bodySmall?.copyWith(fontSize: 15.sp, fontWeight: FontWeight.bold, color: amountColor)),
              if (wallet.fleetManagerId != null) ...[
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'Fleet #${wallet.fleetManagerId}',
                    style: context.bodySmall?.copyWith(fontSize: 8.sp, color: Colors.black, ),
                  ),
                ),
              ],
            ],
          )
        ],
      ),
    );
  }
}