import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "Account",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const CircleAvatar(
                  radius: 32,
                  child: Icon(Icons.person, size: 48),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Vikas kumar vishwakarma",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      "vikas62081@gmail.com",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 8),
            Divider(
              color:
                  Theme.of(context).colorScheme.inversePrimary.withOpacity(.5),
            )
          ]),
        ),
      ),
    );
  }
}
