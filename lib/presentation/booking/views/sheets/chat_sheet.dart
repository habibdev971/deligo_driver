import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:deligo_driver/core/extensions/extensions.dart';
import 'package:deligo_driver/core/utils/is_dark_mode.dart';
import 'package:deligo_driver/data/services/local_storage_service.dart';
import 'package:deligo_driver/data/services/url_launch_services.dart';
import 'package:deligo_driver/presentation/booking/provider/driver_providers.dart';

import '../../../../common/loading_view.dart';
import '../../../../core/state/app_state.dart';
import '../../../../core/state/state_order.dart';
import '../../../../core/theme/color_palette.dart';
import '../../../../core/widgets/buttons/app_back_button.dart';
import '../../../../data/models/chat_message_response/chat_message.dart';
import '../../../../data/models/order_response/order_model/order/order.dart';
import '../../../../gen/assets.gen.dart';
import '../../provider/chat_provider.dart';
import '../../provider/ride_providers.dart';
import 'chat_item_me.dart';
import 'chat_item_other_person.dart';

final scrollController = ScrollController();

class ChatSheet extends ConsumerStatefulWidget {

  const ChatSheet({super.key,});

  @override
  ConsumerState<ChatSheet> createState() => _ChatSheetState();
}

class _ChatSheetState extends ConsumerState<ChatSheet> {
  final textEditingController = TextEditingController();
  bool isSending = false;

  int userId = 0;
  @override
  void initState() {
    super.initState();
    _initializeUserAndChat();
  }

  Future<void> _initializeUserAndChat()async{
    final chatNotifier = ref.read(chatNotifierProvider.notifier);

    userId = await LocalStorageService().getUserId() ?? 0;
    Future.microtask(() async {
      await chatNotifier.getMessage();
      _scrollToBottom();
    });
  }

  void _sendMessage() async {
    if (isSending) return; // prevent double tap
    if (textEditingController.text.trim().isEmpty) return;

    setState(() {
      isSending = true;
    });

    final chatNotifier = ref.read(chatNotifierProvider.notifier);
    final chatNotifierState = ref.watch(chatNotifierProvider);

    await chatNotifier.sendMessage(message: textEditingController.text.trim());

    chatNotifierState.maybeWhen(
      orElse: () => null,
      success: (v) {
        textEditingController.clear();
      },
    );

    _scrollToBottom();

    setState(() {
      isSending = false;
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(chatNotifierProvider);
    final rideOrderState = ref.watch(rideOrderNotifierProvider);
    final keyboardInset = MediaQuery.of(context).viewInsets.bottom;
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
            height: context.height ,
            width: double.infinity,
            color: isDarkMode() ? Colors.black : Colors.white,
            padding: EdgeInsets.only(top: statusBarHeight),
            child: Column(
              children: [
                _buildHeader(context, rideOrderState),
                Expanded(child: _buildChatList(chatState, rideOrderState, driverImage: rideOrderState.maybeWhen(
                  success: (data) => data?.driver?.profilePicture,
                  orElse: () => null,
                ),
                  riderImage: rideOrderState.maybeWhen(
                    success: (data) => data?.rider?.profilePicture,
                    orElse: () => null,
                  ),)),
                Padding(
                  padding:  EdgeInsets.only(bottom: keyboardInset),
                  child: _buildInputBar(context,),
                ),
              ],
            )

        ),
      ),
    );
  }
  Widget _buildChatList(AppState<List<Message>> chatState, AppStateOrder<Order?> createOrderState, {String? driverImage, String? riderImage}) => chatState.when(
      initial: () => const SizedBox.shrink(),
      loading: () => const LoadingView(),
      error: (_) => const SizedBox.shrink(),
      success: (messages) => ListView.builder(
        controller: scrollController,
        padding: EdgeInsets.only(
          top: 45.h,
          bottom: 16.h,
          left: 8.w,
          right: 8.w,
        ),
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final message = messages[index];
          final isLastItem = index == messages.length - 1;
          final isMe = message.receiverId.toString() != userId.toString();

          return isMe
              ? ChatItemMe(
            message: message.message,
            dateTime: message.createdAt,
            showTime: isLastItem,
            image: _imageBuilder(40.h, 40.w, createOrderState),
          )
              : ChatItemOtherPerson(
            message: message.message,
            dateTime: message.createdAt,
            showTime: isLastItem,
            image: _imageBuilder(40.h, 40.w, createOrderState, showRiderImage: false),
          );
        },
      ),
    );

  Widget _buildInputBar(BuildContext context,) => Container(
      padding: EdgeInsets.all(16.r),
      color: isDarkMode() ? Colors.black : Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  isDense: true,
                  hintText: 'Type a message',
                  hintStyle: context.bodyMedium?.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w400, color: const Color(0xFF24262D)),
                  border: _border(),
                  focusedBorder: _border(true),
                  enabledBorder: _border(),
                  suffix: InkWell(
                    onTap: isSending ? null : _sendMessage,
                    child: Assets.images.sendRight.image(height: 20.5.h, width: 20.w, fit: BoxFit.fill),
                  )
              ),

            ),
          ),

        ],
      ),
    );

  OutlineInputBorder _border([bool isFocused = false])=> OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide(color: isFocused ? ColorPalette.primary50 : const Color(0xFFD7DAE0)));

  Widget _buildHeader(BuildContext context, AppStateOrder<Order?> createOrderState) {
    final height = 44.h;
    final width = 44.w;

    return Container(
      height: 70,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      margin: EdgeInsets.zero,
      color: context.theme.scaffoldBackgroundColor,
      child: Row(
        children: [
          Consumer(
            builder: (context, ref, _) {
              final tripNotifier = ref.read(ontripStatusNotifier.notifier);
              return AppBackButton(onPressed: tripNotifier.hideChat,);
            },
          ),
          const SizedBox(width: 16),
          _imageBuilder(height, width, createOrderState, showRiderImage: false),
          const SizedBox(width: 12),
          Expanded(child: _buildRiderDetails(createOrderState, context)),
          InkWell(
            onTap: () => _handleCall(createOrderState),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.r),
                  color: isDarkMode() ? Colors.black : const Color(0xFFF6F7F9),
                border: isDarkMode() ? Border.all(color: Colors.white) : null
              ),
              padding: EdgeInsets.all(7.r),
              child: Assets.images.phoneFlip.image(height: 25.h, width: 25.w, fit: BoxFit.fill),
            ),
          )

        ],
      ),
    );
  }

  Widget _imageBuilder(double height, double width, AppStateOrder<Order?> createOrderState, {bool showRiderImage = true})=> createOrderState.maybeWhen(
      success: (data) => ClipOval(
        child: CachedNetworkImage(
          imageUrl: showRiderImage ? data?.driver?.profilePicture ?? '' : data?.rider?.profilePicture ?? '',
          height: height,
          width: width,
          fit: BoxFit.cover,
          placeholder: (_, _) => _buildImagePlaceholder(height, width),
          errorWidget: (_, _, _) => _buildImageError(height, width),
        ),
      ),
      orElse: () => const CircleAvatar(backgroundColor: ColorPalette.primary50),
    );
  Widget _buildImagePlaceholder(double height, double width) => Container(
      height: height,
      width: width,
      color: Colors.grey[300],
      child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
    );

  Widget _buildImageError(double height, double width) => Container(
      height: height,
      width: width,
      color: Colors.grey,
      child: const Icon(Icons.error, color: Colors.white),
    );

  Widget _buildRiderDetails(AppStateOrder<Order?> createOrderState, BuildContext context) => createOrderState.maybeWhen(
      success: (data) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(data?.rider?.name ?? (data?.rider?.mobile ?? 'N/A'), style: context.titleMedium),
            Gap(4.h),
            Text(
              '6 min ago',
              style: context.bodyMedium?.copyWith(
                fontSize: 10.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF687387),
              ),
            ),
          ],
        ),
      orElse: () => const SizedBox.shrink(),
    );

  void _handleCall(AppStateOrder<Order?> createOrderState,) {
    createOrderState.maybeWhen(
      success: (data) {
        if (data?.rider?.mobile != null) {
          UrlLaunchServices.launchDialer(data?.rider!.mobile);
        }
      },
      orElse: () => null,
    );
  }
}
