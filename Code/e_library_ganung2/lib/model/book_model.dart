class Book {
  final String id;
  final String title;
  final String author;
  final String description;
  final List<String> genre;
  final String imageUrl;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.genre,
    required this.imageUrl,
  });

  factory Book.fromFirestore(String id, Map<String, dynamic> data) {
    return Book(
      id: id,
      title: data['title'] ?? '',
      author: data['author'] ?? '',
      description: data['description'] ?? '',
      genre: List<String>.from(data['genre'] ?? []),
      imageUrl: data['cover_link'] ?? '',
    );
  }

  factory Book.fromMap(Map<String, dynamic> data) {
    return Book(
      id: data['id'] ?? '',
      title: data['title'] ?? '',
      author: data['author'] ?? '',
      description: data['description'] ?? '',
      genre: List<String>.from(data['genre'] ?? []),
      imageUrl: data['cover_link'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'description': description,
      'genre': genre,
      'cover_link': imageUrl,
    };
  }

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      author: json['author'] ?? '',
      genre: List<String>.from(json['genre'] ?? []),
      imageUrl: json['cover_link'] ?? '',
      description: json['description'] ?? '',
    );
  }
}
