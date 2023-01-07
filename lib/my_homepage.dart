import "package:flutter/material.dart";
import 'package:github/commits_page.dart';
import 'package:github/models/repo.dart';
import 'package:github/repo_card.dart';
import "package:http/http.dart" as http;
import 'dart:convert';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

Future<Repos> fetchRepos() async {
  final response = await http
      .get(Uri.parse("https://api.github.com/users/freeCodeCamp/repos#"));

  if (response.statusCode == 200) {
    // print(response.body);
    return Repos.fromJson(json.decode(response.body));
  } else {
    throw Exception("Failed to load repos");
  }
}

class _MyHomePageState extends State<MyHomePage> {
  Future<Repos>? futureRepo;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureRepo = fetchRepos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Github",
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Container(
          child: FutureBuilder<Repos>(
            future: futureRepo,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.repos.length,
                  itemBuilder: (context, index) {
                    return RepoCard(
                      repo: snapshot.data!.repos[index],
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
