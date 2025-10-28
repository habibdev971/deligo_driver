import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/state/app_state.dart';
import '../../../data/models/chatting_models/chat_message_model.dart';
import '../../../data/models/chatting_models/send_message_model.dart';
import '../../../data/repositories/interfaces/chat_repo_interface.dart';

class MessageState {
  final AppState<List<ChatMessage>> list;
  final AppState<SendMessageModel?> sendMessage;

  const MessageState({
    this.list = const AppState.initial(),
    this.sendMessage = const AppState.initial(),
  });

  // copyWith method
  MessageState copyWith({
    AppState<List<ChatMessage>>? list,
    AppState<SendMessageModel?>? sendMessage,
  }) => MessageState(
      list: list ?? this.list,
      sendMessage: sendMessage ?? this.sendMessage,
    );

  // empty method / factory
  factory MessageState.empty() => const MessageState();
}

class MessageNotifier extends StateNotifier<MessageState> {
  final IChatRepo repo;
  final Ref ref;
  MessageNotifier({required this.ref, required this.repo})
      : super(MessageState.empty());

  Future<void> sendMessage({required String message}) async {
    state = state.copyWith(sendMessage: const AppState.loading());
    final res = await repo.sendMessage(message: message);
    res.fold(
          (l) => state = state.copyWith(sendMessage: AppState.error(l)),
          (success) {
        // পুরনো মেসেজ লিস্ট বের করা
        final currentList =
        state.list.maybeWhen(success: (data) => data, orElse: () => []);

        // নতুন মেসেজ যোগ করা (immutable way)
        final updatedList = <ChatMessage>[...currentList, success.data!];

        // নতুন স্টেট সেট করা
        state = state.copyWith(
          sendMessage: AppState.success(success),
          list: AppState.success(updatedList),
        );
      },
    );
  }

  Future<void> getMessages() async {
    state = state.copyWith(list: const AppState.loading());
    final res = await repo.getMessage();
    res.fold(
          (l) => state = state.copyWith(list: AppState.error(l)),
          (success) =>
      state = state.copyWith(list: AppState.success(success.data ?? [])),
    );
  }

  void addMessage(ChatMessage message) {
    state.list.whenOrNull(success: (list){
      final updatedList = [...list, message];
      state = state.copyWith(list: AppState.success(updatedList));
    },);
  }
}
