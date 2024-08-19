import 'package:flutter/material.dart';
import 'package:haydi_ekspres_dev_tools/models/bucket_element_model.dart';
import 'package:haydi_ekspres_dev_tools/widgets/error_dialog.dart';
import 'package:haydi_ekspres_dev_tools/widgets/success_dialog.dart';

import 'package:intl/intl.dart';

import '../../init/cache/local_keys_enums.dart';
import '../../init/cache/local_manager.dart';
import '../../managers/navigation_manager.dart';

abstract mixin class BaseViewModel {
  late BuildContext viewModelContext;
  void setContext(BuildContext context);
  LocaleManager localeManager = LocaleManager.instance;
  NavigationManager get navigationManager =>
      NavigationManager(viewModelContext);
  void init() {}
  final ScrollController defaultScrollController = ScrollController();

  showErrorDialog([String? reason]) {
    ErrorDialog(
      context: viewModelContext,
      reason: reason,
    );
  }

  showSuccessDialog([String? reason]) {
    SuccessDialog(context: viewModelContext, reason: reason);
  }

  navigatorPop() {
    if (Navigator.canPop(viewModelContext)) {
      Navigator.pop(viewModelContext);
    }
  }

  String parseIso8601DateFormat(String isoDate) {
    DateTime dateTime = DateTime.parse(isoDate);

    return DateFormat('dd.MM.yyyy').format(dateTime);
  }

  String parseIso8601DateFormatDetailed(String isoDate) {
    DateTime dateTime = DateTime.parse(isoDate);
    String hourFormat = DateFormat('HH.mm').format(dateTime);
    String dateFormat = DateFormat('dd.MM.yyyy').format(dateTime);
    return "$hourFormat - $dateFormat";
  }

  String fetchMenuPrice(BucketElementModel bucketElement) {
    return "${bucketElement.menuElement.isOnDiscount ? calculateDiscount(bucketElement.menuElement.price, bucketElement.menuElement.discountAmount!) : (bucketElement.menuElement.price * bucketElement.count)}₺";
  }

  int calculateDiscount(int price, int discountAmount) {
    return (price - ((price * discountAmount) / 100)).toInt();
  }

  String? get accessToken =>
      localeManager.getNullableStringData(LocaleKeysEnums.accessToken.name);
}
