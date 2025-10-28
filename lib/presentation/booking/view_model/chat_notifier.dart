// import 'package:flutter/cupertino.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../../core/state/app_state.dart';
// import '../../../data/models/chat_message_response/chat_message.dart';
// import '../../../data/repositories/interfaces/chat_repo_interface.dart';
// import '../../../data/services/local_storage_service.dart';
// import '../provider/ride_providers.dart';
// import '../views/sheets/chat_sheet.dart';
//
// class ChatNotifier extends StateNotifier<AppState<List<Message>>> {
//   final IChatRepo chatRepo;
//   final Ref ref;
//   ChatNotifier( {required this.chatRepo, required this.ref
//   }) : super(const AppState.initial()) {getMessage();}
//
//
//   Future<void> getMessage() async {
//     state = const AppState.loading();
//     // final raiderId = ref.watch(rideOrderNotifierProvider).maybeWhen(orElse: ()=> null, success: (data)=> data?.rider?.id);
//
//     final result = await chatRepo.getMessage();
//     result.fold(
//           (failure) => state = AppState.error(failure),
//           (data) => state = AppState.success(data.data),
//     );
//   }
//
//   Future<void> sendMessage({required String message}) async {
//
//     final previousMessages = state.maybeWhen(
//       success: (messages) => messages,
//       orElse: () => [],
//     );
//     final raiderId = ref.read(rideOrderNotifierProvider).maybeWhen(orElse: ()=> null, success: (data)=> data?.rider?.id);
//
//     final result = await chatRepo.sendMessage(
//       receiverId: (raiderId ?? 0).toInt(),
//       message: message,
//     );
//
//     result.fold(
//           (failure) {
//         state = AppState.error(failure);
//       },
//           (data) async {
//         final userId = await LocalStorageService().getUserId();
//
//         final newMessage = Message(
//           id: 0,
//           senderId: userId ?? 0,
//           receiverId: (raiderId ?? 0).toInt(),
//           message: message,
//           createdAt: DateTime.now(),
//           updatedAt: DateTime.now(),
//         );
//
//         final List<Message> updatedList = [...previousMessages, newMessage];
//         state = AppState.success(updatedList);
//       },
//     );
//   }
//
//   Future<void> addMessage(Message message) async {
//     state.maybeWhen(
//       success: (messages) {
//         final updatedList = [...messages, message];
//         state = AppState.success(updatedList);
//         _scrollToBottom();
//       },
//       orElse: () {
//         state = AppState.success([message]);
//       },
//     );
//   }
//
//   void _scrollToBottom() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (scrollController.hasClients) {
//         scrollController.jumpTo(scrollController.position.maxScrollExtent + 50);
//       }
//     });
//   }
// }
