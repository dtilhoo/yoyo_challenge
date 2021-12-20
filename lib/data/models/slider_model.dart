class SliderModel {
  String? image;
  String? title;

  SliderModel({this.title, this.image});

  void setImage(String getImage) {
    image = getImage;
  }

  void setTitle(String getTitle) {
    title = getTitle;
  }

  String? getImage() {
    return image;
  }

  String? getTitle() {
    return title;
  }
}

List<SliderModel> getSlides() {
  List<SliderModel> slides = <SliderModel>[];
  SliderModel sliderModel = SliderModel();

  sliderModel.setImage("assets/slider1.svg");
  sliderModel.setTitle("Welcome to Yoyo app");
  slides.add(sliderModel);

  sliderModel.setImage("assets/slider2.svg");
  sliderModel.setTitle("This app contains financial news");
  slides.add(sliderModel);

  sliderModel.setImage("assets/slider3.svg");
  sliderModel.setTitle("Continue to create your account");
  slides.add(sliderModel);

  return slides;
}
