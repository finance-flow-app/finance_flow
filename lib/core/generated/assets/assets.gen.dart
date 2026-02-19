// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/Apple.svg
  SvgGenImage get apple => const SvgGenImage('assets/icons/Apple.svg');

  /// File path: assets/icons/BrightnessContrast.svg
  SvgGenImage get brightnessContrast =>
      const SvgGenImage('assets/icons/BrightnessContrast.svg');

  /// File path: assets/icons/Calendar.svg
  SvgGenImage get calendar => const SvgGenImage('assets/icons/Calendar.svg');

  /// File path: assets/icons/Catalog.svg
  SvgGenImage get catalog => const SvgGenImage('assets/icons/Catalog.svg');

  /// File path: assets/icons/ChartClusterBar.svg
  SvgGenImage get chartClusterBar =>
      const SvgGenImage('assets/icons/ChartClusterBar.svg');

  /// File path: assets/icons/CurrencyDollar.svg
  SvgGenImage get currencyDollar =>
      const SvgGenImage('assets/icons/CurrencyDollar.svg');

  /// File path: assets/icons/CurrencyRuble.svg
  SvgGenImage get currencyRuble =>
      const SvgGenImage('assets/icons/CurrencyRuble.svg');

  /// File path: assets/icons/Education.svg
  SvgGenImage get education => const SvgGenImage('assets/icons/Education.svg');

  /// File path: assets/icons/FaceSatisfied.svg
  SvgGenImage get faceSatisfied =>
      const SvgGenImage('assets/icons/FaceSatisfied.svg');

  /// File path: assets/icons/Filter.svg
  SvgGenImage get filter => const SvgGenImage('assets/icons/Filter.svg');

  /// File path: assets/icons/Finance.svg
  SvgGenImage get finance => const SvgGenImage('assets/icons/Finance.svg');

  /// File path: assets/icons/HealthCross.svg
  SvgGenImage get healthCross =>
      const SvgGenImage('assets/icons/HealthCross.svg');

  /// File path: assets/icons/Home.svg
  SvgGenImage get home => const SvgGenImage('assets/icons/Home.svg');

  /// File path: assets/icons/Light.svg
  SvgGenImage get light => const SvgGenImage('assets/icons/Light.svg');

  /// File path: assets/icons/List.svg
  SvgGenImage get list => const SvgGenImage('assets/icons/List.svg');

  /// File path: assets/icons/Money.svg
  SvgGenImage get money => const SvgGenImage('assets/icons/Money.svg');

  /// File path: assets/icons/Moon.svg
  SvgGenImage get moon => const SvgGenImage('assets/icons/Moon.svg');

  /// File path: assets/icons/ResearchHintonPlot.svg
  SvgGenImage get researchHintonPlot =>
      const SvgGenImage('assets/icons/ResearchHintonPlot.svg');

  /// File path: assets/icons/Restaurant.svg
  SvgGenImage get restaurant =>
      const SvgGenImage('assets/icons/Restaurant.svg');

  /// File path: assets/icons/Search.svg
  SvgGenImage get search => const SvgGenImage('assets/icons/Search.svg');

  /// File path: assets/icons/ShoppingCart.svg
  SvgGenImage get shoppingCart =>
      const SvgGenImage('assets/icons/ShoppingCart.svg');

  /// File path: assets/icons/Taxi.svg
  SvgGenImage get taxi => const SvgGenImage('assets/icons/Taxi.svg');

  /// File path: assets/icons/Train.svg
  SvgGenImage get train => const SvgGenImage('assets/icons/Train.svg');

  /// File path: assets/icons/Wifi.svg
  SvgGenImage get wifi => const SvgGenImage('assets/icons/Wifi.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
    apple,
    brightnessContrast,
    calendar,
    catalog,
    chartClusterBar,
    currencyDollar,
    currencyRuble,
    education,
    faceSatisfied,
    filter,
    finance,
    healthCross,
    home,
    light,
    list,
    money,
    moon,
    researchHintonPlot,
    restaurant,
    search,
    shoppingCart,
    taxi,
    train,
    wifi,
  ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/test-svg-icon.svg
  SvgGenImage get testSvgIcon =>
      const SvgGenImage('assets/images/test-svg-icon.svg');

  /// List of all assets
  List<SvgGenImage> get values => [testSvgIcon];
}

class $AssetsTranslationsGen {
  const $AssetsTranslationsGen();

  /// File path: assets/translations/en.json
  String get en => 'assets/translations/en.json';

  /// File path: assets/translations/ru.json
  String get ru => 'assets/translations/ru.json';

  /// List of all assets
  List<String> get values => [en, ru];
}

class Assets {
  const Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsTranslationsGen translations = $AssetsTranslationsGen();
}

class SvgGenImage {
  const SvgGenImage(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = false;

  const SvgGenImage.vec(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    _svg.ColorMapper? colorMapper,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
        colorMapper: colorMapper,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter:
          colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
