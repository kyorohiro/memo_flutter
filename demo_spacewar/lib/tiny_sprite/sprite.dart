part of tiny_sprite;

class Sprite extends DisplayObject {
  Sprite(String name, String path):super(name){
    mat = new sky.Matrix4.zero()..setIdentity();
    mat.scale(0.1,0.1,0.1);
  }
  sky.Matrix4 mat;
  bool _isLoading = false;
  ui.Image _image = null;
  Stage _currentStage = null;
  Stage get currentStage => _currentStage;

  void onInit(Stage stage) {
    _currentStage = stage;
  }

  loadImage() async {
    if (_image == null && _isLoading == false) {
      _isLoading = true;
      _image = await ImageLoader.load("assets/sample.jpeg");
      _isLoading = false;
      if(this.currentStage != null) {
        this.currentStage.markNeedsPaint();
      }
    }
  }

  void onPaint(Stage stage) {
    loadImage();
    sky.Paint paint = new sky.Paint()..color = new sky.Color.fromARGB(0xff, 0xff, 0xff, 0xff);
    sky.Offset point = new sky.Offset(x, y);
    stage.currentCanvas.transform(mat.storage);
    if (_image == null) {
      sky.Rect rect = new sky.Rect.fromLTWH(x, y, 50.0, 50.0);
      stage.currentCanvas.drawRect(rect, paint);
    } else {
      stage.currentCanvas.drawImage(_image, point, paint);
    }
    stage.currentCanvas.transform((new sky.Matrix4.zero()..setIdentity()).storage);
  }

}