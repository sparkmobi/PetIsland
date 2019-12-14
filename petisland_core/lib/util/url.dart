class UrlUtils {
  static bool isImageUrlFormat(String url) {
    return url.contains(RegExp('^https?://')) ||
        url.contains(RegExp('^http?://'));
  }
}
