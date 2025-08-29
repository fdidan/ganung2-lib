class RecommendedBook {
  final String id;
  final double similarity;

  RecommendedBook({required this.id, required this.similarity});

  factory RecommendedBook.fromJson(Map<String, dynamic> json) {
    return RecommendedBook(
      id: json['id'],
      similarity: json['similarity'].toDouble(),
    );
  }
}
