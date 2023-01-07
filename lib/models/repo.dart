import 'dart:convert';
import 'dart:ffi';

class Repos {
  Repos({
    required this.repos,
  });

  List<Repo> repos;

  factory Repos.fromJson(List<dynamic> json) {
    List<Repo> repos = [];
    repos = json.map((repo) => Repo.fromJson(repo)).toList();
    return Repos(repos: repos);
  }
}

class Repo {
  Repo({
    required this.name,
    required this.htmlUrl,
    required this.stargazers_count,
    required this.description,
    required this.commits_url,
  });

  String name;
  String htmlUrl;
  int stargazers_count;
  String description;
  String commits_url;

  factory Repo.fromJson(Map<String, dynamic> json) => Repo(
        name: json["name"] ?? "",
        htmlUrl: json["htmlUrl"] ?? "",
        stargazers_count: json["stargazers_count"] ?? 0,
        description: json["description"] ?? "",
        commits_url: json["commits_url"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "htmlUrl": htmlUrl,
        "stargazers_count": stargazers_count,
        "description": description,
        "commits_url": commits_url
      };
}
