import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/state/app_state.dart';
import '../../../core/utils/helpers.dart';
import '../../../data/models/common_response.dart';
import '../../../data/models/complaint_model/Data.dart';
import '../../../data/models/complaint_model/my_complaint_model/Complains.dart';
import '../../../data/repositories/interfaces/complaint_repo_interface.dart';
import '../../../data/services/navigation_service.dart';

class ComplaintState {
  final AppState<List<Complains>> myComplaintList;
  final AppState<List<ComplaintType>> typeList;
  final ComplaintType? selectedComplaint;
  final AppState<CommonResponse> createComplaint;
  final List<String> priorityList;
  final String? selectedPriority;
  final int page;
  final int limit;
  final bool hasMore;
  final bool isPaginating;
  ComplaintState({
    this.myComplaintList = const AppState.initial(),
    this.typeList = const AppState.initial(),
    this.selectedComplaint,
    this.createComplaint = const AppState.initial(),
    this.priorityList = const ['HIGH', 'MEDIUM', 'LOW'],
    this.selectedPriority,
    this.page = 1,
    this.limit = 10,
    this.hasMore = true,
    this.isPaginating = false,
  });

  ComplaintState copyWith({
    AppState<List<Complains>>? myComplaintList,
    AppState<List<ComplaintType>>? typeList,
    Object? selectedComplaint = _noValue,
    Object? selectedPriority = _noValue,
    AppState<CommonResponse>? createComplaint,
    List<String>? priorityList,
    int? page,
    int? limit,
    bool? hasMore,
    bool? isPaginating,
  }) => ComplaintState(
      myComplaintList: myComplaintList ?? this.myComplaintList,
      typeList: typeList ?? this.typeList,
      selectedComplaint: selectedComplaint == _noValue
          ? this.selectedComplaint
          : selectedComplaint as ComplaintType?,
      selectedPriority: selectedPriority == _noValue
          ? this.selectedPriority
          : selectedPriority as String?,
      priorityList: priorityList ?? this.priorityList,
      createComplaint: createComplaint ?? this.createComplaint,
      page: page ?? this.page,
      limit: limit ?? this.limit,
      hasMore: hasMore ?? this.hasMore,
      isPaginating: isPaginating ?? this.isPaginating,
    );

// private sentinel object
  static const _noValue = Object();


  ComplaintState.empty()
    : this(
        myComplaintList: const AppState.initial(),
        typeList: const AppState.initial(),
        selectedComplaint: null,
        createComplaint: const AppState.initial(),
        priorityList: const ['HIGH', 'MEDIUM', 'LOW'],
        selectedPriority: null,
        page: 1,
        limit: 10,
        hasMore: true,
        isPaginating: false,
      );
}

class ComplaintNotifier extends StateNotifier<ComplaintState> {
  final Ref ref;
  final IComplaintRepo repo;
  ComplaintNotifier({required this.ref, required this.repo})
    : super(ComplaintState.empty());

  Future<void> getMyComplaintData({bool isPagination = false}) async {
    final prevList = state.myComplaintList.whenOrNull(success: (data)=> data) ?? [];
    if (isPagination) {
      if (!state.hasMore || state.isPaginating) return;
      state = state.copyWith(isPaginating: true);
    } else {
      state = state.copyWith(
        myComplaintList: const AppState.loading(),
        page: 1,
        hasMore: true,
      );
    }

    final result = await repo.getMyComplaintData(params: {
      'page': state.page,
      'limit': state.limit,
    });

    result.fold(
          (failure) {
        if (isPagination) {
          state = state.copyWith(isPaginating: false);
        } else {
          state = state.copyWith(myComplaintList: AppState.error(failure));
        }
        showNotification(message: failure.message);
      },
          (success) {
        final data = success.data;
        final complains = data?.complains ?? [];
        final pagination = data?.pagination;

        final bool hasMore = (pagination?.page ?? 1) < (pagination?.totalPages ?? 1);

        if (isPagination) {

          final updatedList = [...prevList, ...complains];
          state = state.copyWith(
            myComplaintList: AppState.success(updatedList),
            isPaginating: false,
            hasMore: hasMore,
            page: state.page + 1,
          );
        } else {
          state = state.copyWith(
            myComplaintList: AppState.success(complains),
            hasMore: hasMore,
            page: state.page + 1,
          );
        }
      },
    );
  }
  Future<void> getComplaintTypes() async {

    state = state.copyWith(typeList: const AppState.loading());
    final result = await repo.getComplaintTypes();

    result.fold(
      (failure) {
        state = state.copyWith(typeList: AppState.error(failure));
        showNotification(message: failure.message);
      },
      (success) {
        state = state.copyWith(typeList: AppState.success(success.data ?? []));
        showNotification(message: success.message, isSuccess: true);
      },
    );
  }

  Future<void> createComplaint({required num? orderId, required String msg}) async {
    state = state.copyWith(createComplaint: const AppState.loading());
    final result = await repo.createComplaint(
      orderId: orderId,
      data: {
        'complainId': state.selectedComplaint?.id,
        'message': msg,
        'priority': state.selectedPriority,
      },
    );

    result.fold(
      (failure) {
        state = state.copyWith(createComplaint: AppState.error(failure));
        showNotification(message: failure.message);
      },
      (success) {
        state = state.copyWith(createComplaint: AppState.success(success));
        showNotification(message: success.message, isSuccess: true);
        getMyComplaintData(isPagination: false);
        Future.delayed(Duration.zero).then((_){
          NavigationService.pop();
        });
      },
    );
  }

  void selectComplaintType(ComplaintType type){
    state = state.copyWith(selectedComplaint: type);
  }

  void selectPriority(String priority){
    state = state.copyWith(selectedPriority: priority);
  }

  void resetOther(){
    //TODO: fix it it does not set to null
    state = state.copyWith(
      selectedComplaint: null,
      selectedPriority: null,
    );
  }
  void reset(){
    state = ComplaintState.empty();
  }
}
