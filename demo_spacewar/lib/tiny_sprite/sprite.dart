part of tiny_sprite;

class Sprite extends DisplayObject {

  double scaleX = 0.2;
  double scaleY = 0.2;
  double scaleZ = 0.2;

  double moveX = 0.0;
  double moveY = 0.0;
  double moveZ = 0.0;

  double rotateX = 0.0;
  double rotateY = 0.0;
  double rotateZ = 0.0;

  double centerX = null;
  double centerY = null;
  double centerZ = null;

  Sprite(String name, String path):super(name){
    mat = new sky.Matrix4.zero()..setIdentity();
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
      if(centerX == null) {
        centerX = _image.width/2.0;
        centerY = _image.height/2.0;
        centerZ = 0.0;
      }
      if(this.currentStage != null) {
        this.currentStage.markNeedsPaint();
      }
    }
  }

  void onPaint(Stage stage) {
    loadImage();
    sky.Paint paint = new sky.Paint()..color = new sky.Color.fromARGB(0xff, 0xff, 0xff, 0xff);
    sky.Offset point = new sky.Offset(x, y);
    mat.setIdentity();
    mat.translate(moveX, moveY, moveZ);
    mat.rotateX(rotateX);
    mat.rotateY(rotateY);
    mat.rotateZ(rotateZ);
    mat.scale(scaleX,scaleY,scaleZ);
    mat.translate(-centerX, -centerY, -centerZ);
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