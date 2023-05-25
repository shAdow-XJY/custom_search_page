class ChangeIsCustomBackImgEvent {
  final bool isCustomBackImg;
  ChangeIsCustomBackImgEvent({this.isCustomBackImg = false});
}

class ChangeBackImgEvent {
  final String imgEncode;
  ChangeBackImgEvent({this.imgEncode = ''});
}

class ChangeBoxFitEvent {
  final int boxFitOption;
  ChangeBoxFitEvent({this.boxFitOption = 0});
}