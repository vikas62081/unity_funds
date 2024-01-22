import 'package:flutter/material.dart';
import 'package:unity_funds/widgets/group/search_result.dart';

class GroupSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '',
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return GroupSearchResult(query: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return GroupSearchResult(query: query);
  }
}
