class OverviewModel {
  final String name,address,about,other;
  OverviewModel({required this.name, required this.address, required this.about, required this.other});
  factory OverviewModel.fromJson(Map<String,dynamic> j) => OverviewModel(name:j['name']??'', address:j['address']??'', about:j['about']??'', other:j['otherInfo']??'');
}
