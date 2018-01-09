part of tiny_sprite;

class Sprite extends DisplayObject {

  double scaleX = 1.0;
  double scaleY = 1.0;
  double scaleZ = 1.0;

  double moveX = 0.0;
  double moveY = 0.0;
  double moveZ = 0.0;

  double rotateX = 0.0;
  double rotateY = 0.0;
  double rotateZ = 0.0;

  double centerX = null;
  double centerY = null;
  double centerZ = null;

  String _imagePath = null;
  Sprite(String name, String path):super(name){
    _imagePath = path;
  }

  Sprite.empty(String name):super(name){
    _imagePath = null;
  }


  bool _isLoading = false;
  ui.Image _image = null;
  Stage _currentStage = null;
  Stage get currentStage => _currentStage;

  void onInit(Stage stage) {
    _currentStage = stage;
  }

  loadImage() async {
    if(_imagePath == null) {
      return;
    }
    if (_image == null && _isLoading == false) {
      _isLoading = true;
      _image = await ImageLoader.load(_imagePath);
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
    sky.Offset point = sky.Offset.zero;
    mat.setIdentity();
    mat.translate(moveX, moveY, moveZ);
    mat.rotateX(rotateX);
    mat.rotateY(rotateY);
    mat.rotateZ(rotateZ);
    mat.scale(scaleX,scaleY,scaleZ);
    if(centerX != null)
    {
      mat.translate(-centerX, -centerY, -centerZ);
    }
    stage.currentCanvas.save();
    stage.currentCanvas.transform(mat.storage);
    if(_imagePath != null) {
      if (_image == null) {
        sky.Rect rect = new sky.Rect.fromLTWH(0.0, 0.0, 50.0, 50.0);
        stage.currentCanvas.drawRect(rect, paint);
      } else {
        stage.currentCanvas.drawImage(_image, point, paint);
      }
    }
    onPaintAfterTransform(stage);
    stage.currentCanvas.transform((new sky.Matrix4.zero()..setIdentity()).storage);
    stage.currentCanvas.restore();
  }

  void onPaintAfterTransform(Stage stage) {

  }
}