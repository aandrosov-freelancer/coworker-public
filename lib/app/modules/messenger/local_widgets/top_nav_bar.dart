import 'package:flutter/material.dart';

class TopNavBar extends StatelessWidget {
  const TopNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFBFC9C4), width: 1)),
        boxShadow: [
          BoxShadow(
            color: Color(0x0C000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo & Navigation
          Row(
            children: [
              // Logo
              Row(
                children: [
                  const Icon(Icons.work_outline, color: Colors.blueAccent),
                  const SizedBox(width: 8),
                  const Text(
                    'Coworker',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1D1E),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 48),
              // Nav Links
              _buildNavLink('Маркетплейс', Icons.storefront_outlined),
              _buildNavLink('Биржа', Icons.work_outline),
              _buildNavLink(
                'Сообщения',
                Icons.chat_bubble_outline,
                isActive: true,
              ),
              _buildNavLink('Профиль', Icons.person_outline),
            ],
          ),

          // User Profile Area
          Row(
            children: [
              Container(
                height: 40,
                width: 1,
                color: const Color(0xFFBFC9C4),
                margin: const EdgeInsets.symmetric(horizontal: 16),
              ),
              const CircleAvatar(
                radius: 20,
                backgroundColor: Color(0xFFE0E0E0),
                child: Icon(Icons.person, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavLink(String text, IconData icon, {bool isActive = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Icon(
            icon,
            color: isActive ? Colors.black : const Color(0xFF757575),
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              color: isActive ? Colors.black : const Color(0xFF757575),
            ),
          ),
        ],
      ),
    );
  }
}
