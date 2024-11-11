import 'package:flutter/material.dart';

import '../../abg_utils.dart';

List<OfferData> offers = [];
OfferData currentOffer = OfferData.createEmpty();

Future<String?> loadOffers() async{
  try{
    offers = await dbGetAllDocumentInTable("offer");
    if (offers.length != appSettings.customersCount)
      dbSetDocumentInTable("settings", "main", {"customersCount": listUsers.length});
  }catch(ex){
    return "loadOffers " + ex.toString();
  }
  return null;
}

getDiscountText(OfferData item){
  if (item.discountType == "percentage")
    return "${item.discount}%";
  return "\$${item.discount}";
}

getCurrentDiscountText(){
  if (currentOffer.discountType == "percentage")
    return "${currentOffer.discount}%";
  return "\$${currentOffer.discount}";
}

// String couponInfo(
//     List<String> serviceProviders,  // parent.currentService.providers
//     List<String> serviceCategory, // parent.currentService.category
//     String serviceId, // parent.currentService.id
//     String stringCouponNotFound, /// strings.get(162); /// "Coupon not found",
//     String stringCouponHasExpired, /// strings.get(169); /// "Coupon has expired",
//     String stringCouponNotSupportedProvider, /// strings.get(164); /// "Coupon not supported by this provider",
//     String stringCouponNotSupportCategory, /// strings.get(165); /// "Coupon not support this category",
//     String stringCouponNotSupportService, /// strings.get(166); /// "Coupon not support this service",
//     String stringCouponActivated, /// strings.get(163); /// "Coupon activated",
//     ){
//   OfferData? _item;
//   dprint("<-------------couponInfo------------>");
//
//   for (var item in offers) {
//     dprint("offers = ${item.code} - need localSettings.couponCode=$couponCode");
//     if (item.code == couponCode) {
//       _item = item;
//       break;
//     }
//   }
//
//   if (_item == null){
//     dprint("coupon not found");
//     couponId = "";
//     return stringCouponNotFound; /// "Coupon not found",
//   }
//   //
//   // Time
//   //
//   var _now = DateTime.now();
//   dprint("time coupon ${_item.expired}");
//   dprint("time    now $_now");
//   dprint("is   before ${_item.expired.isBefore(_now)}");
//   if (_item.expired.isBefore(_now)){
//     dprint("Coupon has expired");
//     couponId = "";
//     return stringCouponHasExpired; /// "Coupon has expired",
//   }
//
//   //
//   // Provider
//   //
//   // Нам нужно проверить есть ли serviceProviders[0] в списке разрешенных провайдеров
//   if (_item.providers.isNotEmpty){
//     dprint("providers not empty"); // надо проверять
//     if (serviceProviders.isNotEmpty)
//       if (!_item.providers.contains(serviceProviders[0])) { // не найден
//         couponId = "";
//         dprint("Coupon not supported by this provider");
//         return stringCouponNotSupportedProvider; /// "Coupon not supported by this provider",
//       }
//   }else
//     dprint("providers empty");
//
//   //
//   // Category
//   //
//   if (_item.category.isNotEmpty){
//     dprint("category not empty");
//     var _found = false;
//     dprint("current category id: ${serviceCategory.join(" ")} - list offer categories ${_item.category.join(" ")}");
//     for (var item in _item.category){
//       if (serviceCategory.contains(item)){
//         _found = true;
//         break;
//       }
//     }
//     if (!_found){
//       dprint("Coupon not support this category",);
//       couponId = "";
//       return stringCouponNotSupportCategory; /// strings.get(165); /// "Coupon not support this category",
//     }
//   }else
//     dprint("category empty");
//
//   //
//   // Service
//   //
//   if (_item.services.isNotEmpty){
//     dprint("current service id: $serviceId - coupon service list ${_item.services.join(" ")}");
//     if (!_item.services.contains(serviceId)){
//       dprint("Coupon not support this service");
//       couponId = "";
//       return stringCouponNotSupportService; /// strings.get(166); /// "Coupon not support this service",
//     }
//   }else
//     dprint("service empty");
//
//   dprint("Coupon activated");
//   dprint("<-------------couponInfo------------>");
//   // localSettings.coupon = _item;
//   couponId = _item.id;     // 2746fde7643fgd
//   couponCode = _item.code;   // CODE25
//   discountType = _item.discountType; // "percent" or "fixed"
//   discount = _item.discount;      // 12
//   return stringCouponActivated; /// "Coupon activated",
// }

Future<String?> offerSave() async {
  try{
    var _data = currentOffer.toJson();
    if (currentOffer.id.isEmpty) {
      currentOffer.id = await dbAddDocumentInTable("offer", _data);
      await dbIncrementCounter("settings", "main", "offer_count", 1);
    }else
      await dbSetDocumentInTable("offer", currentOffer.id, _data);
  }catch(ex){
    return "offerSave " + ex.toString();
  }
  return null;
}


Future<String?> offerDelete(OfferData item) async {
  try{
    await dbDeleteDocumentInTable("offer", item.id);
    await dbIncrementCounter("settings", "main", "offer_count", -1);
    if (item.id == currentOffer.id)
      currentOffer = OfferData.createEmpty();
    offers.remove(item);
  }catch(ex){
    return "offerDelete " + ex.toString();
  }
  return null;
}

class OfferData {
  String id;
  String code;
  List<StringData> desc;
  double discount;
  String discountType; // "percent" or "fixed"
  bool visible;
  List<String> services; // Id
  List<String> providers; // Id
  List<String> category; // Id
  List<String> article; // Id
  DateTime expired;
  Color color;
  bool visibleForUser;
  String image;
  String state = "";

  OfferData(this.id, this.code, {this.visible = true, required this.desc, this.discountType = "fixed",
    required this.services, required this.providers, required this.category, this.discount = 0, required this.expired,
    required this.article, required this.color, this.visibleForUser = true, this.image = ""});

  factory OfferData.createEmpty(){
    return OfferData("", "", services: [], providers: [], category: [], expired: DateTime.now(), desc: [],
        article: [], color: Colors.black);
  }

  Map<String, dynamic> toJson() => {
    'code': code,
    'desc': desc.map((i) => i.toJson()).toList(),
    'discount': discount,
    'discountType': discountType,
    'visible': visible,
    'services': services,
    'providers': providers,
    'category': category,
    'expired': expired.millisecondsSinceEpoch,
    'article': article,
    'color': color.value.toString(),
    'image': image,
  };

  factory OfferData.fromJson(String id, Map<String, dynamic> data){
    List<StringData> _desc = [];
    if (data['desc'] != null)
      for (var element in List.from(data['desc'])) {
        _desc.add(StringData.fromJson(element));
      }
    List<String> _services = [];
    if (data['services'] != null)
      for (var element in List.from(data['services'])) {
        _services.add(element);
      }
    List<String> _providers = [];
    if (data['providers'] != null)
      for (var element in List.from(data['providers'])) {
        _providers.add(element);
      }
    List<String> _category = [];
    if (data['category'] != null)
      for (var element in List.from(data['category'])) {
        _category.add(element);
      }
    List<String> _article = [];
    if (data['article'] != null)
      for (var element in List.from(data['article'])) {
        _article.add(element);
      }
    return OfferData(
      id,
      (data["code"] != null) ? data["code"] : "",
      desc: _desc,
      discount: (data["discount"] != null) ? toDouble(data["discount"].toString()) : 0,
      discountType: (data["discountType"] != null) ? data["discountType"] : "",
      visible: (data["visible"] != null) ? data["visible"] : true,
      services: _services,
      providers: _providers,
      category: _category,
      article: _article,
      expired: (data["expired"] != null) ? DateTime.fromMillisecondsSinceEpoch(data["expired"]) : DateTime.now(),
      visibleForUser: (data["visibleForUser"] != null) ? data["visibleForUser"] : true,
      color: (data["color"] != null) ? toColor(data["color"]) : Colors.red,
      image: (data["image"] != null) ? data["image"] : "",
    );
  }

  setDesc(String val, String locale){
    for (var item in desc)
      if (item.code == locale) {
        item.text = val;
        return;
      }
    desc.add(StringData(code: locale, text: val));
  }
}

////

bool needCouponDebugText = false;

_dprint(String text){
  if (needCouponDebugText)
    dprint(text);
}

bool isCouponsPresent(bool cartUser, ProductData currentService){

  List<ProductData> _products = cartGetProductsForBooking();
  for (var item in offers) {
    if (!item.visible)
      continue;
    if (!cartUser){
      if (_isCouponValid(item, currentService))
        return true;
    }else {
      var ret = true;
      for (var product in _products) {
        if (!_isCouponValid(item, product))
          ret = false;
      }
      if (ret)
        return true;
    }
  }
  return false;
}

List<OfferData> getVisibleCoupons(bool cartUser, ProductData currentService){
  List<OfferData> ret = [];
  List<ProductData> _products = [];
  if (!cartUser)
    _products.add(currentService);
  else
    _products = cartGetProductsForBooking();

  for (var item in offers) {
    if (!item.visible)
      continue;
    if (item.expired.isBefore(DateTime.now())) // expired
      continue;
    if (!item.visibleForUser)
      continue;
    //
    item.state = "";
    for (var product in _products) {
      if (!_isCouponValid(item, product)) {
        item.state = _lastCouponTextError;
        break;
      }
    }
    ret.add(item);
  }

  return ret;
}

String isValidCodeForCard(String code, bool cartUser, ProductData currentService){
  _lastCouponTextError = "";
  lastCouponAdditionTextError = "";
  List<ProductData> _products = cartGetProductsForBooking();

  for (var item in offers) {
    if (!item.visible)
      continue;
    if (item.code.toUpperCase() == code.toUpperCase()) {

      if (!cartUser){
        if (!_isCouponValid(item, currentService))
          return _lastCouponTextError;
      }else {
        for (var product in _products) {
          if (!_isCouponValid(item, product))
            return _lastCouponTextError;

        }
      }

      return "";
    }
  }
  return "not_found";
}

//
// "expired"
// "not_supported_by_this_provider"
// "not_support_this_category"
// "not_support_this_service"
// "not_support_this_product"
//
String _lastCouponTextError = "";
String lastCouponAdditionTextError = "";

bool _isCouponValid(OfferData _item, ProductData product){
  _lastCouponTextError = "";
  lastCouponAdditionTextError = "";
  var _now = DateTime.now();
  _dprint("time coupon ${_item.expired}");
  _dprint("time    now $_now");
  _dprint("is   before ${_item.expired.isBefore(_now)}");
  if (_item.expired.isBefore(_now)){
    _dprint("Coupon has expired");
    _lastCouponTextError = "expired";
    return false;
  }

  //
  // Provider
  //
  // Нам нужно проверить есть ли serviceProviders[0] в списке разрешенных провайдеров
  if (_item.providers.isNotEmpty){
    _dprint("providers not empty"); // надо проверять
    if (_item.providers[0] != '1') {
      if (product.providers.isNotEmpty)
        if (!_item.providers.contains(product.providers[0])) { // не найден
          _dprint("Coupon not supported by this provider");
          lastCouponAdditionTextError =
              getProviderNameById(product.providers[0], locale);
          _lastCouponTextError = "not_supported_by_this_provider";
          return false;
        }
    }
  }else
    _dprint("providers empty");

  //
  // Category
  //
  if (_item.category.isNotEmpty){
    if (_item.category[0] != '1') {
      _dprint("category not empty");
      var _found = false;
      _dprint("current category id: ${product.category.join(" ")} - list offer categories ${_item.category.join(" ")}");
      for (var item in _item.category){
        if (product.category.contains(item)){
          _found = true;
          break;
        }
      }
      if (!_found){
        _dprint("Coupon not support this category",);
        _lastCouponTextError = "not_support_this_category";
        return false;
      }
    }
  }else
    _dprint("category empty");

  //
  // Service
  //
  if (_item.services.isNotEmpty && !product.thisIsArticle){
    if (_item.services[0] != '1'){
      _dprint("current service id: ${product.id} - coupon service list ${_item.services.join(" ")}");
      if (!_item.services.contains(product.id)){
        _dprint("Coupon not support this service");
        lastCouponAdditionTextError = getTextByLocale(product.name, locale);
        _lastCouponTextError = "not_support_this_service";
        return false;
      }
    }
  }else
    _dprint("service empty");

  //
  // Product
  //
  if (_item.article.isNotEmpty && product.thisIsArticle){
    if (_item.article[0] != '1'){
      _dprint("current product id: ${product.id} - coupon product list ${_item.article.join(" ")}");
      if (!_item.services.contains(product.id)){
        _dprint("Coupon not support this product");
        lastCouponAdditionTextError = getTextByLocale(product.name, locale);
        _lastCouponTextError = "not_support_this_product";
        return false;
      }
    }
  }else
    _dprint("article empty");

  _dprint("Coupon come");
  return true;
}

activateCoupon(String code){
  for (var item in offers) {
    if (!item.visible)
      continue;
    if (item.code.toUpperCase() == code.toUpperCase()) {
      couponId = item.id;     // 2746fde7643fgd
      couponCode = item.code;   // CODE25
      discountType = item.discountType; // "percent" or "fixed"
      discount = item.discount;      // 12
    }
  }
}

clearCoupon(){
  couponId = "";     // 2746fde7643fgd
  couponCode = "";   // CODE25
  discountType = ""; // "percent" or "fixed"
  discount = 0;      // 12
}