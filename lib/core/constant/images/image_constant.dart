class ImageConstants {
  static ImageConstants _instace;

  static ImageConstants get instance => _instace ??= ImageConstants._init();

  ImageConstants._init();

  String get logo => toPng('veli');

  String get piano => toPng('login');

  String toPng(String name) => 'assets/image/$name.png';
}
