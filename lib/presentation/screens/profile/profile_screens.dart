import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/profile_option_tile.dart';
import 'profile_viewmodel.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(userProfileProvider);
    final viewModel = ref.read(userProfileProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24),

            /// 👤 Profile Header
            Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: CircularProgressIndicator(
                        value: 1.0,
                        strokeWidth: 6,
                        backgroundColor: Colors.grey.shade200,
                        valueColor: const AlwaysStoppedAnimation<Color>(Colors.purple),
                      ),
                    ),
                    CircleAvatar(
                      radius: 35,
                      backgroundImage: profile.photoUrl.isNotEmpty
                          ? NetworkImage(profile.photoUrl)
                          : null,
                      child: profile.photoUrl.isEmpty
                          ? const Icon(Icons.person, size: 40)
                          : null,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  profile.name.isNotEmpty ? profile.name : "Your Name",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  profile.phone.isNotEmpty ? profile.phone : "Phone not available",
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),

            const SizedBox(height: 30),

            /// Option List
            ProfileOptionTile(
              icon: Icons.person_outline,
              title: "Profile details",
              onTap: () => context.push('/edit-profile'),
            ),
            const ProfileOptionTile(
              icon: Icons.share_outlined,
              title: "Invite a friend",
              trailing: Chip(label: Text("INVITE", style: TextStyle(fontSize: 12))),
            ),
            const ProfileOptionTile(icon: Icons.phone_outlined, title: "Talk to our expert"),
            const ProfileOptionTile(icon: Icons.help_outline, title: "Support and FAQs"),
            const ProfileOptionTile(icon: Icons.star_border, title: "Rate us on Play Store"),

            ProfileOptionTile(
              icon: Icons.logout,
              title: "Logout",
              onTap: () async {
                final shouldLogout = await showDialog<bool>(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text("Logout"),
                    content: const Text("Are you sure you want to logout?"),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Cancel")),
                      TextButton(onPressed: () => Navigator.pop(context, true), child: const Text("Logout")),
                    ],
                  ),
                );

                if (shouldLogout == true) {
                  await viewModel.logout();
                  if (context.mounted) {
                    context.go('/login');
                  }
                }
              },
            ),

            const Spacer(),

            ///  Footer
            Column(
              children: [
                const Text("App version 1.0.0", style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: const [
                    Text("TnC", style: TextStyle(decoration: TextDecoration.underline, color: Colors.blue)),
                    Text("|", style: TextStyle(color: Colors.grey)),
                    Text("Privacy Policy", style: TextStyle(decoration: TextDecoration.underline, color: Colors.blue)),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
