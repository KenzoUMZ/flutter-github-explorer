class Repository {
  final String name;
  final String avatar;
  final String description;
  final int stars;
  final int forks;
  final int issues;
  final int watchers;
  final String url;

  const Repository({
    required this.name,
    required this.description,
    required this.avatar,
    required this.stars,
    required this.forks,
    required this.issues,
    required this.watchers,
    required this.url,
  });

  factory Repository.fromJson(Map<String, dynamic> json) {
    return Repository(
        name: json['full_name'],
        avatar: json['owner']['avatar_url'],
        description: json['description'],
        stars: json['stargazers_count'],
        forks: json['forks_count'],
        issues: json['open_issues_count'],
        watchers: json['watchers'],
        url: json['html_url']);
  }
}
