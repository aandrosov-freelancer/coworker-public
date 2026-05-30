class ServiceModel {
  final String title;
  final String price;
  final String imagePath;

  ServiceModel({
    required this.title,
    required this.price,
    required this.imagePath,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      title: json['title'],
      price: json['price'],
      imagePath: json['imagePath'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'title': title, 'price': price, 'imagePath': imagePath};
  }
}
