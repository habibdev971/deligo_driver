import 'package:deligo_driver/presentation/chat_page/view_model/message_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/chat_repo_impl.dart';
import '../../../data/repositories/interfaces/chat_repo_interface.dart';
import '../../../data/services/chat_service.dart';
import '../../../domain/interfaces/chat_service.dart';
import '../../auth/provider/auth_providers.dart';


final chatServiceProvider = Provider<IChatService>((ref) => ChatService(dioClient: ref.read(dioClientProvider)));

// Repo Provider
final chatRepoProvider = Provider<IChatRepo>((ref) => ChatRepoImpl(chatService: ref.read(chatServiceProvider)));

// Notifier Providers
final messageProvider = StateNotifierProvider<MessageNotifier, MessageState>(
        (ref) => MessageNotifier(ref: ref, repo: ref.read(chatRepoProvider)));
