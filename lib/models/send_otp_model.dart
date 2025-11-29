class Welcome {
  final String phone;

  Welcome({required this.phone});

  Map<String, dynamic> toJson() => {
    "phone": phone,
  };
}
