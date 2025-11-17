import 'package:deligo_driver/core/state/app_state.dart';
import 'package:deligo_driver/core/utils/helpers.dart';
import 'package:deligo_driver/data/repositories/interfaces/ride_history_repo_interface.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/ride_details_model/RideDetailsModel.dart';

class RideHistoryState {
  AppState<List<RideRequest>> list;
  String status;
  int page;
  int limit;
  bool hasMore;
  // DateTime? dateTime;

  RideHistoryState({
    this.list = const AppState.initial(),
    this.status = 'COMPLETED',
    this.page = 1,
    this.limit = 10,
    this.hasMore = true,
    // this.dateTime,
  });

  RideHistoryState copyWith({
    AppState<List<RideRequest>>? list,
    String? status,
    int? page,
    int? limit,
    bool? hasMore,
    DateTime? dateTime,
  }) => RideHistoryState(
      list: list ?? this.list,
      status: status ?? this.status,
      page: page ?? this.page,
      limit: limit ?? this.limit,
      hasMore: hasMore ?? this.hasMore,
    // dateTime: dateTime ?? this.dateTime
    );

  RideHistoryState.empty()
      : this(
    list: const AppState.initial(),
    status: 'COMPLETED',
    page: 1,
    limit: 10,
    hasMore: true,
    // dateTime: null,
  );
}

class RideHistoryNotifier extends StateNotifier<RideHistoryState> {
  final IRideHistoryRepo repo;
  final Ref ref;

  RideHistoryNotifier({required this.ref, required this.repo})
      : super(RideHistoryState.empty());

  /// ✅ প্রথমবার history লোড করা
  Future<void> getRideHistory({bool refresh = false, bool isDateToday = false}) async {
    // if (refresh) {
    //   state = RideHistoryState.empty();
    // }
    if(isDateToday){
      state = state.copyWith(status: 'today');
    }
    // if (isDateToday) {
    //   state = RideHistoryState.empty();
    //   state = state.copyWith(dateTime: DateTime.now(), status: '');
    // }else{
    //   if(refresh){
    //     state = RideHistoryState.empty();
    //   }
    //   // state = state.copyWith(dateTime: )
    // }
    // প্রথমবার লোডের সময় লোডিং দেখাবে
    if (state.page == 1) {
      state = state.copyWith(list: const AppState.loading());
    }

    final result = await repo.getRideHistory(params: {
      'status': state.status,
      'page': state.page,
      'limit': state.limit,
      // 'startDate': state.dateTime?.toIso8601String(),
      // 'endDate': state.dateTime?.toIso8601String(),
    });

    result.fold(
          (failure) {
        state = state.copyWith(list: AppState.error(failure));
        showNotification(message: failure.message);
      },
          (success) {
        final newRides = (success.data?.rideRequests != null)
            ? List<RideRequest>.from(success.data!.rideRequests!)
            : <RideRequest>[];

        // ✅ যদি page = 1 হয় → নতুন লিস্ট সেট করো
        // ✅ অন্যথায় → আগের লিস্টে merge করো
        final oldList = state.page == 1 ? <RideRequest>[] : state.list.whenOrNull(success: (data)=> data) ?? [];
        final mergedList = [...oldList, ...newRides];

        // ✅ hasMore নির্ধারণ
        final hasMore = newRides.length >= state.limit;

        state = state.copyWith(
          list: AppState.success(mergedList),
          hasMore: hasMore,
        );
      },
    );
  }

  /// ✅ পরের পেজ লোড করার জন্য
  Future<void> loadMoreRideHistory() async {
    if (!state.hasMore) return; // যদি আর ডেটা না থাকে, কিছু করো না

    state = state.copyWith(page: state.page + 1);
    await getRideHistory();
  }

  /// ✅ Refresh করার জন্য
  Future<void> refreshRideHistory({String? status}) async {
    state = state.copyWith(status: status, page: 1, hasMore: true);
    await getRideHistory(refresh: true);
  }
}
