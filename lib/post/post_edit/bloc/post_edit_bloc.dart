part of pestisland.post.post_edit.bloc;

class PostEditBloc extends TBloc<PostEditEvent, PostEditState> {
  final List<String> imagesLocalPath = <String>[];
  final List<String> imagesServerDeleted = <String>[];
  String title = '';
  double price = -1;
  String description = '';
  String location = '';
  PetCategory petCategory;
  List<Tag> tags = <Tag>[];

  @override
  Duration get delayEvent => const Duration(milliseconds: 0);

  @override
  Stream<PostEditState> errorToState(BaseErrorEvent event) {
    return null;
  }

  @override
  Stream<PostEditState> eventToState(BaseEvent event) async* {
    switch (event.runtimeType) {
      case TitleInputChange:
        yield* _handleTitleInputChange(event);
        break;
      case PriceInputChange:
        yield* _handlePriceInputChange(event);
        break;
      case ExpandChange:
        yield* _handleExpandChange(event);
        break;
      case AddImageEvent:
        yield* _handleAddImageEvent(event);
        break;
      case RemoveImageEvent:
        yield* _handleRemoveImageEvent(event);
        break;
      default:
    }
  }

  @override
  PostEditState get initialState => InitState();

  Stream<PostEditState> _handleTitleInputChange(TitleInputChange event) async* {
    this.title = event.title ?? '';
    yield TitleState(event.title);
  }

  Stream<PostEditState> _handlePriceInputChange(PriceInputChange event) async* {
    this.price = event.price ?? 0;
    yield PriceState(event.price);
  }

  Stream<PostEditState> _handleExpandChange(ExpandChange event) async* {
    yield ExpandState();
  }

  Stream<PostEditState> _handleAddImageEvent(AddImageEvent event) async* {
    String image = event.imageLocalPath ?? "";

    imagesLocalPath.add(image);
    if (imagesLocalPath != null)
      yield ImageState(imagesLocalPath);
    else
      yield ImageState(<String>[]);
  }

  Stream<PostEditState> _handleRemoveImageEvent(RemoveImageEvent event) async* {
    String image = imagesLocalPath[event.index];
    if (UrlUtils.isImageUrlFormat(image) && imagesServerDeleted != null) {
      imagesServerDeleted.add(image);
    }
    imagesLocalPath.removeAt(event.index);
    if (imagesLocalPath != null)
      yield ImageState(imagesLocalPath);
    else
      yield ImageState(<String>[]);
  }

  void inputChange(String title) {
    add(TitleInputChange(title));
  }

  void priceChange(double price) {
    add(PriceInputChange(price));
  }

  void expandChange() {
    add(ExpandChange());
  }

  void addImage(String imagesPath) {
    add(AddImageEvent(imagesPath ?? ''));
  }

  void removeImage(int index, String imagePath) {
    add(RemoveImageEvent(index ?? 0, imagePath ?? ''));
  }
}
