import 'package:flutter/material.dart';

import '../../../data/model/message_model.dart';

class MessageBubble extends StatelessWidget {
  final MessageModel message;
  final bool isMe;

  const MessageBubble({super.key, required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: isMe
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.6,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isMe ? const Color(0xFF1A1D1E) : Colors.white,
              border: isMe ? null : Border.all(color: const Color(0xFFBFC9C4)),
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(12),
                topRight: const Radius.circular(12),
                bottomLeft: Radius.circular(isMe ? 12 : 2),
                bottomRight: Radius.circular(isMe ? 2 : 12),
              ),
              boxShadow: isMe
                  ? null
                  : [
                      const BoxShadow(
                        color: Color(0x0C000000),
                        blurRadius: 2,
                        offset: Offset(0, 1),
                      ),
                    ],
            ),
            child: Text(
              message.text,
              style: TextStyle(
                fontSize: 15,
                color: isMe ? Colors.white : const Color(0xFF1A1D1E),
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                message.createdAt != null
                    ? '${message.createdAt!.hour.toString().padLeft(2, '0')}:${message.createdAt!.minute.toString().padLeft(2, '0')}'
                    : '',
                style: const TextStyle(fontSize: 12, color: Color(0xFF757575)),
              ),
              if (isMe) ...[
                const SizedBox(width: 4),
                Icon(
                  Icons.done_all,
                  size: 14,
                  color: message.isRead ? Colors.blueAccent : Colors.grey,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
