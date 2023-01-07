// ignore_for_file: non_constant_identifier_names, no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:github/commit_card.dart';
import 'package:github/models/commits.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CommitsPage extends StatefulWidget {
  const CommitsPage({Key? key, required this.commits_url}) : super(key: key);

  final String commits_url;
  @override
  State<CommitsPage> createState() =>
      _CommitsPageState(commits_url: commits_url);
}

class _CommitsPageState extends State<CommitsPage> {
  _CommitsPageState({required this.commits_url});

  Future<Commits>? futureCommits;
  String commits_url;

  Future<Commits> fetchCommits() async {
    if (commits_url != null && commits_url.length >= 5) {
      commits_url = commits_url.substring(0, commits_url.length - 6);
    }
    // print(commits_url);
    final response = await http.get(Uri.parse(commits_url));

    if (response.statusCode == 200) {
      return Commits.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load commits");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureCommits = fetchCommits();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Commits"),
        ),
        body: Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
                child: FutureBuilder<Commits>(
              future: futureCommits,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.commits.length,
                    itemBuilder: (context, index) {
                      return CommitCard(
                        commit: snapshot.data!.commits[index],
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ))));
  }
}
