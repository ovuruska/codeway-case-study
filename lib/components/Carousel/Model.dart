import 'dart:math';

class CarouselModel {
  List<String> urls = [];
  Random random = Random();
  int index = 0;

  setIndex(int index) {
    this.index = index;
    if (index >= urls.length - 2) {
      addNext();
    }
    return this;
  }

  addNext() {
    var url = getImageUrl();
    urls.add(url);

    return this;
  }

  getImageUrl() {
    var id = random.nextInt(250);
    if (id == 245) {
      return "https://picsum.photos/id/244/200/300";
    } else if (id == 138) {
      return "https://picsum.photos/id/139/200/300";
    } else if (id == 224) {
      return "https://picsum.photos/id/225/200/300";
    }
    var url = "https://picsum.photos/id/$id/900/1600";
    return url;
  }
}
