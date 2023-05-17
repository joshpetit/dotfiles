class Post {
  final String imageURL;
  final String title;
  final DateTime datePosted;
  final int numUpvotes;

  Post({
    required this.imageURL,
    required this.title,
    required this.datePosted,
    required this.numUpvotes,
  });

  Post.fromJson(Map<String, dynamic> json)
      : this(
          title: json['image']['imageTitle'],
          imageURL: json['image']['imagePath'],
          numUpvotes: json['numUpvotes'],
          datePosted:
              DateTime.parse(json['datePosted'] ?? "2023-05-07T00:00:00.000"),
        );
}
