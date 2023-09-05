import 'package:get/get.dart';

class HomeState {
  final _progress = 0.0.obs;

  set progress(value) => _progress.value = value;
  get progress => _progress.value;

  final _downloading = false.obs;

  set downloading(value) => _downloading.value = value;
  get downloading => _downloading.value;
}
