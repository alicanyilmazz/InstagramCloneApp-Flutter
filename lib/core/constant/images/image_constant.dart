class ImageConstants {
  static ImageConstants? _instance;

  static ImageConstants get instance => _instance ??= ImageConstants._init();

  ImageConstants._init();

  String get logo => toPng('veli');

  String get piano => toPng('login');

  String toPng(String name) => 'assets/image/$name.png';
}
