part of petisland.common.state;

abstract class TStatelessWidget extends StatelessWidget with BaseTool {
  const TStatelessWidget({Key key}) : super(key: key);
}

abstract class BaseTool {
  Future<T> navigateToScreen<T>({
    @required BuildContext context,
    @required Widget screen,
    String screenName,
  }) {
    final RouteSettings settings = screenName is String ? RouteSettings(name: screenName) : null;

    return Navigator.of(context).push<T>(
      TPageRoute<T>(
        builder: (BuildContext context) => screen,
        settings: settings,
      ),
    );
  }

  void closeScreen(BuildContext context, String screenName) {
    closeUntil(context, screenName);
    if (Navigator.canPop(context)) Navigator.pop(context);
  }

  void closeUntil(BuildContext context, String screenName) {
    Navigator.of(context).popUntil(ModalRoute.withName(screenName));
  }

  void showSnackBar(
    BuildContext context,
    String content,
    Color backgroundColor, {
    Duration duration = const Duration(seconds: 2),
  }) async {
    try {
      Scaffold.of(context).removeCurrentSnackBar();
      await Future<void>.delayed(const Duration(milliseconds: 150));
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(content),
          backgroundColor: backgroundColor,
          duration: duration,
        ),
      );
    } catch (ex) {
      Log.error(ex);
    }
  }

  void showErrorSnackBar({@required BuildContext context, @required String content}) {
    showSnackBar(context, content, Colors.red);
  }
}
