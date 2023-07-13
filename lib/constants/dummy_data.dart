import '../models/models.dart';

class DummyData {
  static final MarkerModel selectedMarker = MarkerModel(
      id: "BRT-GRID-0000001",
      name: "Citadines Berawa Beach Bali",
      address:
          "Jl. Pemelisan Agung, Tibubeneng, Kec. Kuta Utara, Kabupaten Badung, Bali 80363",
      chargingPorts: [1, 2, 3],
      rating: 4.5,
      reviews: [
        Reviews(message: "Best Day Ever", userId: "1", userName: "Bagas"),
        Reviews(message: "Mantap sekali", userId: "1", userName: "Lukman"),
        Reviews(message: "Ramah lingkungan", userId: "1", userName: "Nicol"),
      ]);
}
