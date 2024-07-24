import 'package:hive/hive.dart';
import 'package:watchlist/src/features/shared/data/models/tv_series_model.dart';

class HiveDataSource {
  final Box<TVSeriesModel> box;

  HiveDataSource(this.box);

  Future<void> addTVSeries(TVSeriesModel tvSeries) async {
    await box.put(tvSeries.id, tvSeries);
  }

  Future<void> removeTVSeries(int id) async {
    await box.delete(id);
  }

  Future<List<TVSeriesModel>> getTVSeries() async {
    return box.values.toList();
  }
}
