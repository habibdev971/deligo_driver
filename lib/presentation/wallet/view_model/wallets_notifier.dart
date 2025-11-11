import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:deligo_driver/core/utils/helpers.dart';
import 'package:deligo_driver/data/models/common_response.dart';
import 'package:deligo_driver/data/models/wallet_model/wallet_balance_model.dart';
import 'package:deligo_driver/data/models/wallet_model/wallet_transaction_history_model.dart';
import 'package:deligo_driver/data/repositories/interfaces/wallet_repo_interface.dart';
import 'package:deligo_driver/data/services/navigation_service.dart';
import 'package:deligo_driver/presentation/wallet/provider/provider.dart';
import '../../../core/state/app_state.dart';
import '../widgets/withdraw_dialogue.dart';


class WalletsNotifier extends StateNotifier<AppState<WalletBalanceModel>> {
  final IWalletsRepo walletsRepo;
  final Ref ref;

  WalletsNotifier({
    required this.walletsRepo,
    required this.ref,
  }) : super(const AppState.initial());

  Future<void> getWalletBalance() async {
    state = const AppState.loading();
    final result = await walletsRepo.getWallets();
    result.fold(
          (failure) {
        state = AppState.error(failure);
        showNotification(message: failure.message);
      },
          (data) {
        state = AppState.success(data);
      },
    );
  }
}

class WithdrawNotifier extends StateNotifier<AppState<CommonResponse>> {
  final IWalletsRepo walletsRepo;
  final Ref ref;

  WithdrawNotifier({
    required this.walletsRepo,
    required this.ref,
  }) : super(const AppState.initial());

  Future<void> withdraw({required Map<String, dynamic> body, required String amount}) async {
    state = const AppState.loading();
    final result = await walletsRepo.withdraw(body: body);
    result.fold(
          (failure) {
        state = AppState.error(failure);
        showNotification(message: failure.message);
      },
          (data) {
        state = AppState.success(data);
        NavigationService.pop();
        showWithdrawRequestSubmitDialog(NavigationService.navigatorKey.currentContext!, amount: amount);
        ref.read(walletsBalanceProvider.notifier).getWalletBalance();
        ref.read(transactionHistoryProvider.notifier).getTransactionHistory();
      },
    );
  }
}


class TransactionHistoryState {
  final AppState<List<Transaction>> transactions;
  final DateTime? dateTime;
  final int page;
  final int limit;
  final bool hasMore;
  final bool isPaginating;

  const TransactionHistoryState({
    this.transactions = const AppState.initial(),
    this.dateTime,
    this.page = 1,
    this.limit = 10,
    this.hasMore = true,
    this.isPaginating = false,
  });

  TransactionHistoryState copyWith({
    AppState<List<Transaction>>? transactions,
    DateTime? dateTime,
    bool clearDateTime = false,
    int? page,
    int? limit,
    bool? hasMore,
    bool? isPaginating,
  }) {
    return TransactionHistoryState(
      transactions: transactions ?? this.transactions,
      dateTime: clearDateTime ? null : (dateTime ?? this.dateTime),
      page: page ?? this.page,
      limit: limit ?? this.limit,
      hasMore: hasMore ?? this.hasMore,
      isPaginating: isPaginating ?? this.isPaginating,
    );
  }
}

class TransactionHistoryNotifier extends StateNotifier<TransactionHistoryState> {
  final IWalletsRepo walletsRepo;
  final Ref ref;

  TransactionHistoryNotifier({
    required this.walletsRepo,
    required this.ref,
  }) : super(const TransactionHistoryState());

  // 🔹 Date update - resets pagination
  void updateDateTime(DateTime? dateTime) {
    state = state.copyWith(
      dateTime: dateTime,
      clearDateTime: dateTime == null,
      page: 1,
      hasMore: true,
    );
  }

  // 🔹 First load or refresh
  Future<void> getTransactionHistory({bool refresh = false}) async {
    if (refresh) {
      state = state.copyWith(
        page: 1,
        hasMore: true,
        transactions: const AppState.loading(),
      );
    } else {
      state = state.copyWith(transactions: const AppState.loading());
    }

    final result = await walletsRepo.getWalletsTransaction(
      param: {
        'page': 1,
        'limit': state.limit,
        if (state.dateTime != null) 'startDate': state.dateTime,
        if (state.dateTime != null) 'endDate': state.dateTime,
      },
    );

    result.fold(
          (failure) {
        state = state.copyWith(transactions: AppState.error(failure));
        showNotification(message: failure.message);
      },
          (data) {
        final newList = data.data?.disbursementHistory ?? [];
        state = state.copyWith(
          transactions: AppState.success(newList),
          page: 2,
          hasMore: newList.length >= state.limit,
        );
      },
    );
  }

  // 🔹 Pagination - load more data
  Future<void> loadMoreTransactions() async {
    // Prevent multiple simultaneous requests
    if (state.isPaginating || !state.hasMore) return;

    state = state.copyWith(isPaginating: true);

    final currentList = state.transactions.whenOrNull(
      success: (list) => list,
    ) ?? [];

    final result = await walletsRepo.getWalletsTransaction(
      param: {
        'page': state.page,
        'limit': state.limit,
        if (state.dateTime != null) 'startDate': state.dateTime?.toIso8601String(),
        if (state.dateTime != null) 'endDate': state.dateTime?.toIso8601String(),
      },
    );

    result.fold(
          (failure) {
        state = state.copyWith(isPaginating: false);
        // Optionally show error notification
        // showNotification(message: failure.message);
      },
          (data) {
        final newItems = data.data?.disbursementHistory ?? [];
        final mergedList = [...currentList, ...newItems];

        state = state.copyWith(
          transactions: AppState.success(mergedList),
          page: state.page + 1,
          hasMore: newItems.length >= state.limit,
          isPaginating: false,
        );
      },
    );
  }
}