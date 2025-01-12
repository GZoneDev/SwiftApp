part of 'asset.dart';

extension AssetFile on Asset {
  get logo => _buildStaticPath('logo.svg');
  get appleLogo => _buildStaticPath('apple_logo.svg');

  get googleLogo => _buildStaticPath('google_logo.svg');
}
