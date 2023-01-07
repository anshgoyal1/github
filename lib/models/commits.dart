import 'dart:convert';
import 'dart:ffi';

class Commits {
  Commits({
    required this.commits,
  });

  List<Commit> commits;

  factory Commits.fromJson(List<dynamic> json) {
    List<Commit> commits = [];
    commits = json.map((commit) => Commit.fromJson(commit)).toList();
    return Commits(commits: commits);
  }
}

class Commit {
  Commit({
    required this.sha,
    required this.commit,
  });

  String sha;
  CommitClass? commit;

  factory Commit.fromJson(Map<String, dynamic> json) => Commit(
        sha: json["sha"] ?? "",
        commit: CommitClass.fromJson(json["commit"]),
      );
}

class CommitClass {
  CommitClass({
    required this.author,
    required this.message,
    required this.committer,
  });

  Author? author;
  String message;
  Committer? committer;

  factory CommitClass.fromJson(Map<String, dynamic> json) => CommitClass(
      author: Author.fromJson(json["author"]),
      message: json["message"] ?? "",
      committer: Committer.fromJson(json["committer"]));
}

class Author {
  Author({
    required this.name,
    required this.email,
    required this.date,
  });

  String name;
  String email;
  String date;

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        name: json["name"] ?? "",
        email: json["email"] ?? "",
        date: json["date"] ?? "",
      );
}

class Committer {
  Committer({
    required this.name,
    required this.email,
    required this.date,
  });

  String name;
  String email;
  String date;

  factory Committer.fromJson(Map<String, dynamic> json) => Committer(
        name: json["name"] ?? "",
        email: json["email"] ?? "",
        date: json["date"] ?? "",
      );
}
