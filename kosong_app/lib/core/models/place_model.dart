class Review {
  final String id;
  final String userName;
  final String userAvatar;
  final double rating;
  final String comment;
  final DateTime createdAt;

  Review({
    required this.id,
    required this.userName,
    required this.userAvatar,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });
}

class Menu {
  final String id;
  final String name;
  final String category;
  final String? description;
  final int price;
  final String? image;

  Menu({
    required this.id,
    required this.name,
    required this.category,
    this.description,
    required this.price,
    this.image,
  });
}

class Place {
  final String id;
  final String name;
  final String category;
  final String location;
  final String distance;
  final double rating;
  final int reviewCount;
  final bool isOpen;
  final String openUntil;
  bool isFavorite;
  final String image;
  final List<String> tags;
  final String? promo;
  final String? price;
  final String? description;
  final List<String> facilities;
  final double latitude;
  final double longitude;
  final List<Menu> menus;
  final List<Review> reviews;

  Place({
    required this.id,
    required this.name,
    required this.category,
    required this.location,
    required this.distance,
    required this.rating,
    required this.reviewCount,
    required this.isOpen,
    required this.openUntil,
    required this.isFavorite,
    required this.image,
    required this.tags,
    this.promo,
    this.price,
    this.description,
    this.facilities = const [],
    this.latitude = 0.0,
    this.longitude = 0.0,
    this.menus = const [],
    this.reviews = const [],
  });
}
