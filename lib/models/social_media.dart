class SocialModel {
  String platform;
  String prefix;
  String username;
  bool enabled;

  SocialModel({
    required this.platform,
    required this.prefix,
    required this.username,
    this.enabled = true,
  });

  factory SocialModel.fromJson(Map<String, dynamic> j) => SocialModel(
    platform: j['platform'] ?? '',
    prefix: j['prefix'] ?? '',
    username: j['username'] ?? '',
    enabled: j['enabled'] ?? true,
  );

  Map<String, dynamic> toJson() => {
    'platform': platform,
    'prefix': prefix,
    'username': username,
    'enabled': enabled,
  };
}
