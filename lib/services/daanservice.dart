import '../models/donation_model.dart';

class DaanService {
  static final List<DaanModel> _store = [
    DaanModel(
      id: '1',
      imageUrl: 'https://picsum.photos/seed/1/200/200',
      title: 'Help ISKCON\'s Govardhan Eco Village in caring for cows and other animals',
      buttonLabel: 'Donate Now',
      buttonUrl: 'https://example.com/donate',
      createdAt: DateTime.now().subtract(Duration(days: 3)),
    ),
    DaanModel(
      id: '2',
      imageUrl: 'https://picsum.photos/seed/2/200/200',
      title: 'Support the temple renovation fund',
      buttonLabel: 'Donate Now',
      buttonUrl: 'https://example.com/donate2',
      createdAt: DateTime.now().subtract(Duration(days: 7)),
    ),
  ];

  static Future<List<DaanModel>> getAll() async {
    await Future.delayed(Duration(milliseconds: 500));
    return List.from(_store);
  }

  static Future<DaanModel> add(DaanModel daan) async {
    await Future.delayed(Duration(milliseconds: 500));
    daan.id = DateTime.now().millisecondsSinceEpoch.toString();
    _store.insert(0, daan);
    return daan;
  }

  static Future<DaanModel?> update(DaanModel daan) async {
    await Future.delayed(Duration(milliseconds: 500));
    final idx = _store.indexWhere((d) => d.id == daan.id);
    if (idx != -1) {
      _store[idx] = daan;
      return daan;
    }
    return null;
  }

  static Future<void> remove(String id) async {
    await Future.delayed(Duration(milliseconds: 300));
    _store.removeWhere((d) => d.id == id);
  }
}

