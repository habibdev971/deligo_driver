import 'package:dartz/dartz.dart';
import '../../../core/errors/failure.dart';
import '../../models/chat_message_response/chat_message_response.dart';
import '../../models/chatting_models/get_chat_message_model.dart';
import '../../models/chatting_models/send_message_model.dart';
import '../../models/common_response.dart';

abstract class IChatRepo {
  Future<Either<Failure, GetMessageModel>> getMessage(
      );
  Future<Either<Failure, SendMessageModel>> sendMessage(
      {required String message});
}

