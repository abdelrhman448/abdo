class ApiRoutes {
  static const String urlPublic = "";
  static const String urlLocal = "https://waslinak.com/";
  static const String api = urlLocal + "api/v2/";
  static const String api_auth = urlLocal + "api/v2/auth/";
  static const String register = api + "register";
  static const String login = api + "login";
  static const String otp = api_auth + "verify";
  static const String send = api_auth + "send";
  static const String user = api_auth + "user";

  /// [1] Retrieve all markets
  static const String markets = api + "markets";

  /// [2] Retrieve markets by ID
  static String getMarketsByID(marketsID) {
    return api + 'markets/$marketsID';
  }

  /// [3] Retrieve Markets Shops by markets ID
  static String getMarketsShops(marketsID) {
    return api + 'markets/$marketsID/shops';
  }

  /// [4] Retrieve all shops
  static const String shops = api + "shops";

  /// [5] Retrieve Shops by shops ID
  static String getShopsByID(shopsID) {
    return api + 'shops/$shopsID';
  }

  static String getShopsByMarketsID(marketsID) {
    return api + 'markets/$marketsID/shops';
  }

  static String getProductsByCategoryID(categoryID) {
    return api + 'categories/$categoryID/products';
  }

  static const String shopsCategories = api + "categories";

  static String getShopsCategoriesByID(shopsID) {
    return api + 'shops/$shopsID/categories';
  }

  static const String categories = api + "categories";

  static String getCategoriesByID(categoriesID) {
    return api + 'categories/$categoriesID';
  }

  static const String offers = api + "offers";

  static String getOffersByID(categoriesID) {
    return api + 'offers/$categoriesID';
  }

  static String sendMessage(id1, id2) {
    return api + 'chats/$id1/sendMessage/$id2';
  }

  static String starFavorite(id) {
    return api + '/chats/$id/star';
  }

  static String favorites() {
    return api + '/chats/favorites';
  }

  static String search() {
    return api + '/chats/search';
  }

  static String getContacts(id) {
    return api + '/chats/$id/getContacts';
  }

  static String shared(id) {
    return api + '/chats/$id/shared';
  }

  static String deleteConversation(id) {
    return api + '/chats/$id/deleteConversation';
  }

  static String setActiveStatus(id) {
    return api + '/chats/$id/setActiveStatus';
  }

  static String fetchMessages(id) {
    return api + '/chats/$id/fetchMessages';
  }

  static String makeSeen(id) {
    return api + '/chats/$id/makeSeen';
  }

  static String updateContacts(id) {
    return api + '/chats/$id/updateContacts';
  }
}
