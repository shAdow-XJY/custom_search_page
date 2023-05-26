class ChangeIsCustomBackImgEvent {
  final bool isCustomBackImg;
  ChangeIsCustomBackImgEvent({this.isCustomBackImg = false});
}

class ChangeBackImgEvent {
  final String imgEncode;
  ChangeBackImgEvent({this.imgEncode = ''});
}


class ChangeSearchBarOptionEvent {
  final int searchBarOption;
  ChangeSearchBarOptionEvent({this.searchBarOption = 0});
}

class ChangeBoxFitEvent {
  final int boxFitOption;
  ChangeBoxFitEvent({this.boxFitOption = 0});
}

class ChangeIsJumpToNewPageEvent {
  final bool isJumpToNewPage;
  ChangeIsJumpToNewPageEvent({this.isJumpToNewPage = false});
}