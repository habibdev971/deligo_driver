import 'package:dartz/dartz.dart';
import '../../core/errors/failure.dart';
import '../../domain/interfaces/chat_service.dart';
import '../models/chat_message_response/chat_message_response.dart';
import '../models/chatting_models/get_chat_message_model.dart';
import '../models/chatting_models/send_message_model.dart';
import '../models/common_response.dart';
import 'base_repository.dart';
import 'interfaces/chat_repo_interface.dart';

class ChatRepoImpl extends BaseRepository implements IChatRepo {
  final IChatService chatService;

  ChatRepoImpl({required this.chatService});
  @override
  Future<Either<Failure, GetMessageModel>> getMessage() async => await safeApiCall(() async {
      final response = await chatService.getMessage();
      return GetMessageModel.fromJson(response.data);
    });

  @override
  Future<Either<Failure, SendMessageModel>> sendMessage(
      {required String message}) async => await safeApiCall(() async {
      final response = await chatService.sendMessage(message: message, );
      return SendMessageModel.fromJson(response.data);
    });
}
