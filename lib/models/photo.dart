class Photo {
  final String? id;
  final String full;
  final String? regular;
  final String small;
  final String userName;

  Photo({
    this.id,
    required this.full,
    this.regular,
    required this.small,
    required this.userName,
  });

  Photo.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        full = json['urls']['full'],
        regular = json['urls']['regular'],
        small = json['urls']['small'],
        userName = json['user']['name'];
}
