import 'package:flutter/material.dart';
import 'package:unity_funds/widgets/people/new_people_form.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NewPeopleForm(),
    );
  }
}
