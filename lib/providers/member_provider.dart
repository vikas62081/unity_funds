import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unity_funds/modals/member.dart';

class MemberNotifier extends StateNotifier<List<Member>> {
  MemberNotifier() : super([]);

  void addNewMember(Member member) {
    state = [...state, member];
  }
}

final memberProvider = StateNotifierProvider<MemberNotifier, List<Member>>(
    (ref) => MemberNotifier());
