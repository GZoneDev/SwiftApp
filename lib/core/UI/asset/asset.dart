import 'package:flutter/material.dart';
part 'asset_file.dart';

class Asset extends ThemeExtension<Asset> {
  final mainPath = 'asset/icon', fixedAssetDirectory = 'static';
  final String assetDirectory;
  const Asset({this.assetDirectory = 'static'});
  String _buildPath(String fileName) => '$mainPath/$assetDirectory/$fileName';

  String _buildStaticPath(String fileName) =>
      '$mainPath/$fixedAssetDirectory/$fileName';

  @override
  Asset copyWith({String? assetDirectory}) {
    return Asset(
      assetDirectory: assetDirectory ?? this.assetDirectory,
    );
  }

  @override
  Asset lerp(ThemeExtension<Asset>? other, double t) {
    if (other is! Asset) return this;

    return Asset(
      assetDirectory: t < 0.5 ? assetDirectory : other.assetDirectory,
    );
  }
}

extension AssetExtension on BuildContext {
  Asset get assetPath => Theme.of(this).extension<Asset>()!;
}
