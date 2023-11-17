


class UploadModel{
  final String title;
  final double price;
  final String description;
  final String image;
  final String categoryString;

  UploadModel({
    required this.title,
    required this.price,
    required this.description,
    required this.image,
    required this.categoryString,
});

  Map<String,Object> toJson() => {
    "title":title,
    "price":price,
    "description":description,
    "image":image,
    "categoryString":categoryString,
  };
}