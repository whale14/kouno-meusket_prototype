class WorkCategory {
  late List<String> categories;
  WorkCategory() {
    categories = [
      "동행",
      "안심귀가",
      "교통약자",
      "돌봄",
      "우편/민원",
      "펫시터",
      "가사",
      "배달/운송",
      "조립/설치",
      "시간알바",
      "기타/대행"
    ];
  }

  String setWorkCategory(int categoryIdx) {
    return categories[categoryIdx];
  }
}