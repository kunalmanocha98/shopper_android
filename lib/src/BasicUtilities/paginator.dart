import 'dart:async';

import 'package:flutter/material.dart' hide ErrorWidgetBuilder;
import 'package:shopper/src/BasicUtilities/custom_localizations.dart';
import 'package:shopper/src/BasicUtilities/custom_text_styles.dart';
import 'package:shopper/src/BasicUtilities/shopper_colors.dart';
import 'package:shopper/src/BasicUtilities/string_constant.dart';
import 'package:shopper/src/UIComponents/custom_buttons.dart';

typedef Future<T> PageLoadFuture<T>(int page);
typedef List<dynamic> PageItemsGetter<T>(T pageData);
typedef Widget ListItemBuilder(dynamic itemData, int index);
typedef Widget LoadingWidgetBuilder();
typedef void RetryListener();
typedef Widget ErrorWidgetBuilder<T>(T pageData, RetryListener retryListener);
typedef Widget EmptyListWidgetBuilder<T>(T pageData);
typedef int TotalItemsGetter<T>(T pageData);
typedef int PageItemCounter<T>(T pageData);
typedef bool PageErrorChecker<T>(T pageData);

/// Paginator extends [StatefulWidget] has 3 constructors namely
/// [Paginator.listView], [Paginator.gridView], [Paginator.pageView]
/// [Paginator.listView], [Paginator.gridView] and [Paginator.pageView] are
/// descendants of [ListView], [GridView] and [PageView].
/// [Paginator.listView], [Paginator.gridView] and [Paginator.pageView] got
/// all the features of their ancestors and they are need to provide additional
/// properties that are essential in doing their job.
///
/// [pageLoadFuture]
///  * Loads the page asynchronously when the page number is given.
///  * This should return an instance of a [Future].
///  * Called when the next page is needed to be loaded.
///
/// [pageItemsGetter]
///  * This function should return list of page item data when page data is given.
///  * This is called after successful completion of [pageLoadFuture].
///  * The page items returned by this method is added to the list of all the
///     page items.
///
/// [listItemBuilder]
///  * Builds list item when item data and item index are given.
///  * This should return an instance of a [Widget].
///
/// [loadingWidgetBuilder]
///  * Builds loading widget.
///  * This should return an instance of a [Widget].
///
/// [errorWidgetBuilder]
///  * Builds error widget when page data and error callback are given.
///  * This should return an instance of a [Widget].
///
/// [emptyListWidgetBuilder]
///  * Builds empty list widget.
///  * This is displayed when the total number of list items is zero.
///  * This should return an instance of a [Widget].
///
/// [totalItemsGetter]
///  * This should return total number of list items when page data is given.
///
/// [pageErrorChecker]
///  * This should return true if page has error else false, when page data is given.

class Paginator<T> extends StatefulWidget {
  final PageLoadFuture<T> pageLoadFuture;
  final PageItemsGetter<T> pageItemsGetter;
  final ListItemBuilder listItemBuilder;
  final LoadingWidgetBuilder loadingWidgetBuilder;
  final ErrorWidgetBuilder<T> errorWidgetBuilder;
  final EmptyListWidgetBuilder<T> emptyListWidgetBuilder;
  final TotalItemsGetter<T> totalItemsGetter;
  final PageErrorChecker<T> pageErrorChecker;

  /// common properties
  final Key scrollViewKey;
  final ScrollPhysics scrollPhysics;
  final Axis scrollDirection;
  final bool reverse;

  /// properties - list view, grid view
  final EdgeInsets padding;
  final bool shrinkWrap;
  final ScrollController scrollController;
  final bool primary;
  final int semanticChildCount;
  final double cacheExtent;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;

  /// properties - list view only
  final double itemExtent;

  /// properties - grid view only
  final SliverGridDelegate gridDelegate;

  /// properties - page view only
  final ValueChanged<int> onPageChanged;
  final bool pageSnapping;
  final PageController pageController;

  final ListType listType;

  const Paginator.listView({
    Key key,
    @required this.pageLoadFuture,
    @required this.pageItemsGetter,
    @required this.listItemBuilder,
    @required this.loadingWidgetBuilder,
    @required this.errorWidgetBuilder,
    @required this.emptyListWidgetBuilder,
    @required this.totalItemsGetter,
    @required this.pageErrorChecker,
    this.scrollViewKey,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.scrollPhysics,
    this.padding,
    this.shrinkWrap = false,
    this.scrollController,
    this.primary,
    this.semanticChildCount,
    this.cacheExtent,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.itemExtent,
  })  : this.listType = ListType.LIST_VIEW,
        this.onPageChanged = null,
        this.pageSnapping = true,
        this.pageController = null,
        this.gridDelegate = null,
        super(key: key);

  const Paginator.gridView({
    Key key,
    @required this.pageLoadFuture,
    @required this.pageItemsGetter,
    @required this.listItemBuilder,
    @required this.loadingWidgetBuilder,
    @required this.errorWidgetBuilder,
    @required this.emptyListWidgetBuilder,
    @required this.totalItemsGetter,
    @required this.pageErrorChecker,
    @required this.gridDelegate,
    this.scrollViewKey,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.scrollPhysics,
    this.padding,
    this.shrinkWrap = false,
    this.scrollController,
    this.primary,
    this.semanticChildCount,
    this.cacheExtent,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
  })  : this.listType = ListType.GRID_VIEW,
        this.itemExtent = null,
        this.onPageChanged = null,
        this.pageSnapping = true,
        this.pageController = null,
        super(key: key);

  const Paginator.pageView({
    Key key,
    @required this.pageLoadFuture,
    @required this.pageItemsGetter,
    @required this.listItemBuilder,
    @required this.loadingWidgetBuilder,
    @required this.errorWidgetBuilder,
    @required this.emptyListWidgetBuilder,
    @required this.totalItemsGetter,
    @required this.pageErrorChecker,
    this.scrollViewKey,
    this.scrollDirection = Axis.horizontal,
    this.reverse = false,
    this.scrollPhysics,
    this.onPageChanged,
    this.pageSnapping = true,
    this.pageController,
  })  : this.listType = ListType.PAGE_VIEW,
        this.padding = null,
        this.shrinkWrap = false,
        this.scrollController = null,
        this.primary = null,
        this.semanticChildCount = null,
        this.cacheExtent = null,
        this.addAutomaticKeepAlives = true,
        this.addRepaintBoundaries = true,
        this.addSemanticIndexes = true,
        this.itemExtent = null,
        this.gridDelegate = null,
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PaginatorState<T>(
      this.pageLoadFuture,
      this.pageItemsGetter,
      this.listItemBuilder,
      this.loadingWidgetBuilder,
      this.errorWidgetBuilder,
      this.emptyListWidgetBuilder,
      this.totalItemsGetter,
      this.pageErrorChecker,
      this.gridDelegate,
      this.scrollViewKey,
      this.scrollDirection,
      this.reverse,
      this.scrollPhysics,
      this.padding,
      this.shrinkWrap,
      this.scrollController,
      this.primary,
      this.semanticChildCount,
      this.cacheExtent,
      this.addAutomaticKeepAlives,
      this.addRepaintBoundaries,
      this.addSemanticIndexes,
      this.itemExtent,
      this.onPageChanged,
      this.pageSnapping,
      this.pageController,
      this.listType,
    );
  }
}

class PaginatorState<T> extends State<Paginator> {
  /// essential
  PageLoadFuture<T> _pageLoadFuture;
  PageItemsGetter<T> _pageItemsGetter;
  ListItemBuilder _listItemBuilder;
  LoadingWidgetBuilder _loadingWidgetBuilder;
  ErrorWidgetBuilder<T> _errorWidgetBuilder;
  EmptyListWidgetBuilder<T> _emptyListWidgetBuilder;
  TotalItemsGetter<T> _totalItemsGetter;
  PageErrorChecker<T> _pageErrorChecker;

  /// common properties
  Key _scrollViewKey;
  ScrollPhysics _scrollPhysics;
  Axis _scrollDirection;
  bool _reverse;

  /// properties - list view, grid view
  EdgeInsets _padding;
  bool _shrinkWrap;
  ScrollController _scrollController;
  bool _primary;
  int _semanticChildCount;
  double _cacheExtent;
  bool _addAutomaticKeepAlives;
  bool _addRepaintBoundaries;
  bool _addSemanticIndexes;

  /// properties - list view only
  double _itemExtent;

  /// properties - grid view only
  SliverGridDelegate _gridDelegate;

  /// properties - page view only
  ValueChanged<int> _onPageChanged;
  bool _pageSnapping;
  PageController _pageController;

  /// runtime variables
  ListStatus _listStatus;
  ListType _listType;
  List _listItems;
  int _currentPage;
  int _nTotalItems;
  T _firstPageData;

  PaginatorState(
    this._pageLoadFuture,
    this._pageItemsGetter,
    this._listItemBuilder,
    this._loadingWidgetBuilder,
    this._errorWidgetBuilder,
    this._emptyListWidgetBuilder,
    this._totalItemsGetter,
    this._pageErrorChecker,
    this._gridDelegate,
    this._scrollViewKey,
    this._scrollDirection,
    this._reverse,
    this._scrollPhysics,
    this._padding,
    this._shrinkWrap,
    this._scrollController,
    this._primary,
    this._semanticChildCount,
    this._cacheExtent,
    this._addAutomaticKeepAlives,
    this._addRepaintBoundaries,
    this._addSemanticIndexes,
    this._itemExtent,
    this._onPageChanged,
    this._pageSnapping,
    this._pageController,
    this._listType,
  );

  @override
  void initState() {
    _initialize();
    _initialFutureCall();
    super.initState();
  }

  void _initialize() {
    _listStatus = ListStatus.LOADING;
    _listItems = [];
    _currentPage = 0;
    _nTotalItems = 0;
    _firstPageData = null;
  }

  @override
  Widget build(BuildContext context) {
    switch (_listStatus) {
      case ListStatus.SUCCESS:
        return _buildPaginatorWidget();

      case ListStatus.LOADING:
        return Center(child: _loadingWidgetBuilder());

      case ListStatus.ERROR:
        return Center(child: _errorWidgetBuilder(_firstPageData, _onError));

      case ListStatus.EMPTY:
      default:
        return _emptyListWidgetBuilder(_firstPageData);
    }
  }

  Widget _buildPaginatorWidget() {
    switch (_listType) {
      case ListType.LIST_VIEW:
        return ListView.builder(
          key: _scrollViewKey,
          padding: _padding,
          physics: _scrollPhysics,
          scrollDirection: _scrollDirection,
          shrinkWrap: _shrinkWrap,
          itemCount: _getItemCount(),
          itemBuilder: _itemBuilder,
          controller: _scrollController,
          reverse: _reverse,
          primary: _primary,
          semanticChildCount: _semanticChildCount,
          cacheExtent: _cacheExtent,
          itemExtent: _itemExtent,
          addAutomaticKeepAlives: _addAutomaticKeepAlives,
          addRepaintBoundaries: _addRepaintBoundaries,
          addSemanticIndexes: _addSemanticIndexes,
        );
      case ListType.GRID_VIEW:
        return GridView.builder(
          key: _scrollViewKey,
          gridDelegate: _gridDelegate,
          padding: _padding,
          physics: _scrollPhysics,
          scrollDirection: _scrollDirection,
          shrinkWrap: _shrinkWrap,
          itemCount: _getItemCount(),
          itemBuilder: _itemBuilder,
          controller: _scrollController,
          reverse: _reverse,
          primary: _primary,
          semanticChildCount: _semanticChildCount,
          cacheExtent: _cacheExtent,
          addAutomaticKeepAlives: _addAutomaticKeepAlives,
          addRepaintBoundaries: _addRepaintBoundaries,
          addSemanticIndexes: _addSemanticIndexes,
        );
      case ListType.PAGE_VIEW:
      default:
        return PageView.builder(
          key: _scrollViewKey,
          physics: _scrollPhysics,
          scrollDirection: _scrollDirection,
          itemCount: _getItemCount(),
          itemBuilder: _itemBuilder,
          controller: _pageController,
          reverse: _reverse,
          onPageChanged: _onPageChanged,
          pageSnapping: _pageSnapping,
        );
    }
  }

  Widget _itemBuilder(BuildContext context, int index) {
    if (index < _listItems.length) {
      return _listItemBuilder(_listItems[index], index);
    } else {
      return FutureBuilder(
        future: _pageLoadFuture(_currentPage + 1),
        builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              return _loadingWidgetBuilder();
            case ConnectionState.done:
              if (_pageErrorChecker(snapshot.data)) {
                return _errorWidgetBuilder(snapshot.data, _onError);
              }
              _listItems.addAll(_pageItemsGetter(snapshot.data));
              _currentPage++;
              Future.microtask(() {
                setState(() {});
              });
              return _loadingWidgetBuilder();
            default:
              return _loadingWidgetBuilder();
          }
        },
      );
    }
  }

  int _getItemCount() {
    if (_nTotalItems > _listItems.length) {
      return _listItems.length + 1;
    }
    return _nTotalItems;
  }

  void _onError() {
    if (_listItems.length == 0) {
      setState(
        () {
          this._listStatus = ListStatus.LOADING;
        },
      );
      _initialFutureCall();
    } else {
      setState(() {});
    }
  }

  void changeState({
    PageLoadFuture<T> pageLoadFuture,
    PageItemsGetter<T> pageItemsGetter,
    ListItemBuilder listItemBuilder,
    LoadingWidgetBuilder loadingWidgetBuilder,
    ErrorWidgetBuilder<T> errorWidgetBuilder,
    EmptyListWidgetBuilder<T> emptyListWidgetMaker,
    TotalItemsGetter<T> totalItemsGetter,
    PageErrorChecker<T> pageErrorChecker,
    Key scrollViewKey,
    ScrollPhysics scrollPhysics,
    Axis scrollDirection,
    bool reverse,
    EdgeInsets padding,
    bool shrinkWrap,
    ScrollController scrollController,
    bool primary,
    int semanticChildCount,
    double cacheExtent,
    bool addAutomaticKeepAlives,
    bool addRepaintBoundaries,
    bool addSemanticIndexes,
    double itemExtent,
    SliverGridDelegate gridDelegate,
    ValueChanged<int> onPageChanged,
    bool pageSnapping,
    PageController pageController,
    ListType listType,
    bool resetState = false,
  }) {
    _pageLoadFuture = pageLoadFuture ?? _pageLoadFuture;
    _pageItemsGetter = pageItemsGetter ?? _pageItemsGetter;
    _listItemBuilder = listItemBuilder ?? _listItemBuilder;
    _loadingWidgetBuilder = loadingWidgetBuilder ?? _loadingWidgetBuilder;
    _errorWidgetBuilder = errorWidgetBuilder ?? _errorWidgetBuilder;
    _emptyListWidgetBuilder = emptyListWidgetMaker ?? _emptyListWidgetBuilder;
    _totalItemsGetter = totalItemsGetter ?? _totalItemsGetter;
    _pageErrorChecker = pageErrorChecker ?? _pageErrorChecker;
    _scrollViewKey = scrollViewKey ?? _scrollViewKey;
    _scrollPhysics = scrollPhysics ?? _scrollPhysics;
    _scrollDirection = scrollDirection ?? _scrollDirection;
    _reverse = reverse ?? _reverse;
    _padding = padding ?? _padding;
    _shrinkWrap = shrinkWrap ?? _shrinkWrap;
    _scrollController = scrollController ?? _scrollController;
    _primary = primary ?? _primary;
    _semanticChildCount = semanticChildCount ?? _semanticChildCount;
    _cacheExtent = cacheExtent ?? _cacheExtent;
    _addAutomaticKeepAlives = addAutomaticKeepAlives ?? _addAutomaticKeepAlives;
    _addRepaintBoundaries = addRepaintBoundaries ?? _addRepaintBoundaries;
    _addSemanticIndexes = addSemanticIndexes ?? _addSemanticIndexes;
    _itemExtent = itemExtent ?? _itemExtent;
    _gridDelegate = gridDelegate ?? _gridDelegate;
    _onPageChanged = onPageChanged ?? _onPageChanged;
    _pageSnapping = pageSnapping ?? _pageSnapping;
    _pageController = pageController ?? _pageController;
    _listType = listType ?? _listType;

    if (resetState) {
      _initialize();
      setState(() {});
      _initialFutureCall();
    }
    setState(() {});
  }

  void _initialFutureCall() {
    Future<T> future = _pageLoadFuture(1);
    future.then((T pageData) {
      _firstPageData = pageData;
      _nTotalItems = _totalItemsGetter(pageData);
      if (_pageErrorChecker(pageData)) {
        setState(() {
          _listStatus = ListStatus.ERROR;
        });
      } else if (_nTotalItems == 0) {
        setState(() {
          _listStatus = ListStatus.EMPTY;
        });
      } else {
        _currentPage++;
        _listItems.addAll(_pageItemsGetter(pageData));
        setState(() {
          _listStatus = ListStatus.SUCCESS;
        });
      }
    });
  }
}

enum ListStatus { LOADING, ERROR, SUCCESS, EMPTY }
enum ListType { LIST_VIEW, GRID_VIEW, PAGE_VIEW }

class CustomPaginator {
  BuildContext context;

  List<dynamic> listItemsGetter(dynamic response) {
    return response.results;
  }

  Widget loadingWidgetMaker() {
    return Container(
      alignment: Alignment.center,
      height: 160.0,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(ShopperColor.appMainColor),
      ),
    );
  }

  Widget errorWidgetMaker(dynamic response, retryListener) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ShopperElevatedButton(
          buttonText: ShopperLocalizations(context).localization.retry,
          onPressed: retryListener,
        )
      ],
    );
  }

  Widget blank(dynamic response, retryListener) {
    return Center(
      child: Container(),
    );
  }

  Widget emptyListWidgetMaker(dynamic response,
      {String message, String assetImage}) {
    return Center(
        child: Container(
            child: Text(
      ShopperLocalizations(context).localization.empty,
      style: ShopperTextStyles.subtitle1,
    )));
  }

  int totalPagesGetter(dynamic response) {
    return response.total;
  }

  bool pageErrorChecker(dynamic response) {
    if (response != null && (response.code == Strings.successCode)) {
      return false;
    } else {
      // ToastBuilder().showToast(response.message??"", context, HexColor(AppColors.information));
      return true;
    }
  }

  CustomPaginator(this.context);
}
