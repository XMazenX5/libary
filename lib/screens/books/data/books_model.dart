class BooksModel {
  String? id;
  String? name;
  String? author;
  String? description;
  String? image;
  String? previewLink;
  String? buyLink;


  BooksModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    previewLink = json['volumeInfo']['previewLink'];
    buyLink = json['saleInfo'] != null ? json['saleInfo']['buyLink'] : null;
    name = json['volumeInfo']['title'] ?? 'Unknown Title';
    author = json['volumeInfo']['authors'] != null
        ? json['volumeInfo']['authors'][0]
        : 'Unknown Author';
    description = json['volumeInfo']['description'] ?? 'No description available';
    image = json['volumeInfo']['imageLinks'] != null
        ? json['volumeInfo']['imageLinks']['thumbnail']
        : 'https://media.istockphoto.com/id/1472933890/vector/no-image-vector-symbol-missing-available-icon-no-gallery-for-this-moment-placeholder.jpg?s=612x612&w=0&k=20&c=Rdn-lecwAj8ciQEccm0Ep2RX50FCuUJOaEM8qQjiLL0=';
  }
}
