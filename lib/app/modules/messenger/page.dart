import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller.dart';
import 'local_widgets/chat_list_pane.dart';
import 'local_widgets/chat_history_pane.dart';

class MessengerPage extends GetView<MessengerController> {
  const MessengerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FF),
      body: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(width: 350, child: ChatListPane()),
                const Expanded(child: ChatHistoryPane()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
