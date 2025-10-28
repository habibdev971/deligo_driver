import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/error_view.dart';
import '../../../common/loading_view.dart';
import '../../../core/utils/is_dark_mode.dart';
import '../../../core/widgets/app_bar/app_bar.dart';
import '../../../core/widgets/text_field_only.dart';
import '../../../data/models/chatting_models/chat_message_model.dart';
import '../../../gen/assets.gen.dart';
import '../provider/message_provider.dart';
import '../widget/chat_item.dart';

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key});

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollToBottom(milliSeconds: 1);
    Future.microtask((){
      ref.read(messageProvider.notifier).getMessages();
    });
  }


  void scrollToBottom({int? milliSeconds}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(milliseconds: milliSeconds ?? 100), () {
        if (_scrollController.hasClients) {
          if(!context.mounted)return;
          final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent + (keyboardHeight > 0 ? 58 : 60), // Add extra offset when keyboard is open
            duration: Duration(milliseconds: milliSeconds ?? 300),
            curve: Curves.easeOut,
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    final isLoading = ref.watch(messageProvider).sendMessage.whenOrNull(loading: ()=> true) ?? false;
    return RefreshIndicator(
      onRefresh: ()async{
        ref.read(messageProvider.notifier).getMessages();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: mainAppBar(context, title: 'Chat'),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.only(bottom: 8.h, top: 8.h),
          decoration: BoxDecoration(
              color: isDarkMode() ? Colors.black45 : Colors.white,
            // border: isDarkMode() ? Border.all(color: AppColors.primary) : null
          ),
          child: Row(
            children: [
              IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: (){

                  },
                  icon: CircleAvatar(
                    radius: 14.h,
                    backgroundColor: Colors.black12,
                    child: CircleAvatar(
                        radius: 13.h,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.add, color: Colors.grey.shade500, size: 24.h,)),
                  )),

              Expanded(child: textFieldOnly(controller: _controller, hint: 'Type your message')),

              isLoading ? const Padding(
                padding: EdgeInsets.all(8.0),
                child: SizedBox(height: 20, width: 20, child: Center(child: CircularProgressIndicator()),),
              ) : IconButton(

                  onPressed: isLoading ? null : ()async{
                    if(_controller.text.isNotEmpty){
                      await ref.read(messageProvider.notifier).sendMessage(message: _controller.text.trim());
                      ref.watch(messageProvider).sendMessage.whenOrNull(success: (d){
                        _controller.clear();
                        setState(() {

                        });
                      });
                      // setState(() {
                      //   list.add(Message(id: 0, senderId: 1, receiverId: 2, message: _controller.text, createdAt: DateTime.now(), updatedAt: DateTime.now()));
                      //   _controller.clear();
                      // });
                      scrollToBottom();
                    }

                  },
                  icon: Assets.images.send.image(height: 40.h, width: 40.w, color: isDarkMode() ? Colors.white : null))
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(
            left: 16.w,
            right: 16.w,
            bottom: 80.0.h ,
          ),
          child: GestureDetector(
            onTap: (){
              FocusScope.of(context).unfocus();
            },
            child: ref.watch(messageProvider).list.when(
              initial: ()=> const SizedBox.shrink(),
              loading: ()=> const LoadingView(),
              success: (data)=> ListView.builder(

                  controller: _scrollController,
                  itemCount: data.length,
                  itemBuilder: (context, index){
                    ChatMessage item = data[index];
                    return chatItem(context, message: item, isMe: item.senderRole?.contains('DRIVER') ?? false);
                  }
              ),
              error: (error,)=> ErrorView(message: error.message)
            ),
            )
          ),

      ),
    );
  }
}
