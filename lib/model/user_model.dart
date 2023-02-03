class User {
  final String username;
  final String fullname;
  final String nik;
  final String? lat;
  final String? long;
  final String level;
  final String isActive;
  final String createdAt;

  User(
    this.username,
    this.fullname,
    this.nik,
    this.lat,
    this.long,
    this.level,
    this.isActive,
    this.createdAt,
  );

  User.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        fullname = json['fullname'],
        nik = json['nik'],
        lat = json['lat'] ?? "",
        long = json['long'] ?? "",
        level = json['level'],
        isActive = json['is_active'],
        createdAt = json['created_at'];

  Map<String, dynamic> toJson() => {
        'username': username,
        'fullname' : fullname,
        'nik' : nik,
        'lat' : lat,
        'long' : long,
        'level' : level,
        'is_active' : isActive,
        'created_at' : createdAt,
      };
}
