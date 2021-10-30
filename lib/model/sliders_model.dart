class SlidersModel {
  String imageAssetPath;
  String title;
  String desc;

  SlidersModel({this.imageAssetPath, this.title, this.desc});

  void setImageAssetPath(String getImageAssetPath) {
    imageAssetPath = getImageAssetPath;
  }

  void setTitle(String getTitle) {
    title = getTitle;
  }

  void setDesc(String getDesc) {
    desc = getDesc;
  }

  String getImageAssetPath() {
    return imageAssetPath;
  }

  String getTitle() {
    return title;
  }

  String getDesc() {
    return desc;
  }
}

List<SlidersModel> getSlides() {
  List<SlidersModel> slides = new List<SlidersModel>();
  SlidersModel sliderModel = new SlidersModel();

  //1
  sliderModel.setDesc(
      "نعم يمكننك فعل ذالك! تتبع طعامك أو منتجات السيوبرماركت والبقاله منذ تأكيد الطلب وحتى لحظة وصوله إليك.");
  sliderModel.setTitle("موصول");
  sliderModel.setImageAssetPath("assets/introSlider/illustration.png");
  slides.add(sliderModel);

  sliderModel = new SlidersModel();

  //2
  sliderModel.setDesc(
      "أيوه بنجيك في أي مكان وين ما كنت أطب فقط وقم بتفعيل الإشعارات ستكون دائماً مطلعاً على جميع التحديثات حتى يصلك طلبك.");
  sliderModel.setTitle("في أي مكان");
  sliderModel.setImageAssetPath("assets/introSlider/illustration2.png");
  slides.add(sliderModel);

  sliderModel = new SlidersModel();

  //3
  sliderModel.setDesc(
      "خاصية الرسائل والدردشة اللحظية  مع العملاء والشركات فقط من اجلك أضف بياناتك إلى حسابك في تطبيق موصول وأطلب أكيد ح نوصلك وين ما كنت.");
  sliderModel.setTitle("أطلب الأن");
  sliderModel.setImageAssetPath("assets/introSlider/illustration3.png");
  slides.add(sliderModel);

  sliderModel = new SlidersModel();

  return slides;
}
