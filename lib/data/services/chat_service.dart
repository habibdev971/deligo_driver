import 'package:dio/dio.dart';
import '../../core/config/api_endpoints.dart';
import '../../domain/interfaces/chat_service.dart';
import 'api/dio_client.dart';
import 'local_storage_service.dart';

class ChatService implements IChatService {
  final DioClient dioClient;

  ChatService({required this.dioClient});
  @override
  Future<Response> sendMessage({required String message,})async{
    final rideId = await LocalStorageService().getRideId();
    return dioClient.dio.post(
        '${ApiEndpoints.sendMessage}/$rideId/chat',
        data: {
          // 'receiver_id': receiverId,
          'message': message
        }
    );
  }
  @override
  Future<Response> getMessage() async {
    final rideId = await LocalStorageService().getRideId();
    return dioClient.dio.get(
      '${ApiEndpoints.getMessage}/$rideId/chat',
      // 'https://lynk.razinsoft.com/api/message',
      // queryParameters: {
      //   'receiver_id': userId
      // }

    );
  }
}
