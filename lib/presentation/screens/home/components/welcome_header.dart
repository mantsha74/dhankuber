import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../data/sample/upload_service.dart';

Widget buildWelcomeHeader(BuildContext context, String userName, {String? profileImageUrl}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome, $userName 👋",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              "Let’s grow your savings wisely",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[700]),
            ),
          ],
        ),
        GestureDetector(
          onTap: () => {
            context.push('/profile')
          },
          child: CircleAvatar(
            radius: 22,
            backgroundImage: profileImageUrl != null
                ? NetworkImage(profileImageUrl)
                : null,
            backgroundColor: Colors.grey[200],
            child: profileImageUrl == null
                ? const Icon(Icons.person, color: Colors.grey, size: 26)
                : null,
          ),
        ),
      ],
    ),
  );
}
