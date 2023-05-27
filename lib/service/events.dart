class ChangeIsJumpToNewPageEvent {
  final bool isJumpToNewPage;
  ChangeIsJumpToNewPageEvent({this.isJumpToNewPage = false});
}

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

class ChangeSearchBarLengthOptionEvent {
  final int searchBarLengthOption;
  ChangeSearchBarLengthOptionEvent({this.searchBarLengthOption = 0});
}

class ChangeSearchBarAlignOptionEvent {
  final int searchBarAlignOption;
  ChangeSearchBarAlignOptionEvent({this.searchBarAlignOption = 0});
}

/// custom color events
class ChangePageBackColorEvent {
  final int colorValue;
  ChangePageBackColorEvent({required this.colorValue});
}
class ChangeSettingBtnColorEvent {
  final int colorValue;
  ChangeSettingBtnColorEvent({required this.colorValue});
}
class ChangeSearchBtnColorEvent {
  final int colorValue;
  ChangeSearchBtnColorEvent({required this.colorValue});
}
class ChangeSearchBarTextColorEvent {
  final int colorValue;
  ChangeSearchBarTextColorEvent({required this.colorValue});
}
class ChangeSearchBarBorderColorEvent {
  final int colorValue;
  ChangeSearchBarBorderColorEvent({required this.colorValue});
}
class ChangeSearchBarBackColorEvent {
  final int colorValue;
  ChangeSearchBarBackColorEvent({required this.colorValue});
}