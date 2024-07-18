class Book {
  int id;
  String title;
  String? author;
  String? publicationYear;
  List<String>? genre;
  String? description;
  String? coverImage;

  Book({
    required this.id,
    required this.title,
    this.author,
    this.publicationYear,
    this.genre,
    this.description,
    this.coverImage,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        id: json["id"],
        title: json["title"],
        author: json["author"],
        publicationYear: json["publication_year"].toString(),
        genre: List<String>.from(json["genre"].map((x) => x)),
        description: json["description"],
        coverImage: json["cover_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "author": author,
        "publication_year": publicationYear,
        "genre": List<dynamic>.from(genre?.map((x) => x) ?? []),
        "description": description,
        "cover_image": coverImage,
      };
}
