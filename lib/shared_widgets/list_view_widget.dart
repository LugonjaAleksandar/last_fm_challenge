import 'package:flutter/material.dart';
import 'package:last_fm_challenge/shared_widgets/divider_widget.dart';
import 'package:last_fm_challenge/shared_widgets/loading_indicator_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ListViewWidget extends StatefulWidget {
  final bool hasMoreData;
  final itemCount;
  final bool primary;
  final Function listItemForIndex;
  final Function shouldShowSeparatorForIndex;
  final bool shrinkWrap;
  final Function didReachEnd;
  final Function onRefresh;
  final bool shouldShowEmptyListIndicator;
  final List<Widget> children;
  final bool pullToRefreshEnabled;
  final bool nextPageLoadingEnabled;
  final ScrollController controller;
  final bool isListRefreshable;

  ListViewWidget({
    this.hasMoreData = false,
    this.itemCount,
    this.primary,
    this.listItemForIndex,
    this.shouldShowSeparatorForIndex,
    this.shrinkWrap = false,
    this.didReachEnd,
    this.onRefresh,
    this.shouldShowEmptyListIndicator = false,
    this.children,
    this.pullToRefreshEnabled = false,
    this.nextPageLoadingEnabled = false,
    this.controller,
    this.isListRefreshable = true,
  });

  @override
  State createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget> {
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  bool _showLoadingIndicatorWidget = false;

  @override
  Widget build(BuildContext context) {
    return widget.shouldShowEmptyListIndicator
        ? Hero(
            tag: 'loader',
            child: LoadingIndicatorWidget(),
          )
        : _optionallyWrapWithSmartRefresh(
            listWidget: widget.children == null
                ? ListView.separated(
                    itemBuilder: (context, index) => widget.listItemForIndex(index),
                    separatorBuilder: (context, index) {
                      if (widget.shouldShowSeparatorForIndex != null) {
                        return widget.shouldShowSeparatorForIndex(index) ? DividerWidget() : Container();
                      } else {
                        return Container();
                      }
                    },
                    itemCount: widget.itemCount,
                    primary: widget.primary,
                    shrinkWrap: widget.shrinkWrap,
                    controller: widget.controller,
                  )
                : ListView(children: widget.children),
          );
  }

  _optionallyWrapWithSmartRefresh({Widget listWidget}) {
    // If isListRefreshable == false just return the widget and don't use SmartRefresh wrapper
    if (widget.isListRefreshable == false) {
      return listWidget;
    }
    return RefreshConfiguration(
      enableScrollWhenRefreshCompleted: true,
      child: SmartRefresher(
        enablePullDown: widget.pullToRefreshEnabled,
        enablePullUp: widget.nextPageLoadingEnabled,
        controller: _refreshController,
        onRefresh: () async {
          if (widget.onRefresh != null) {
            await widget.onRefresh();
            _refreshController.refreshCompleted();
          } else {
            _refreshController.refreshCompleted();
          }
        },
        onLoading: () async {
          if (!_showLoadingIndicatorWidget) {
            setState(() {
              _showLoadingIndicatorWidget = true;
            });
          }
          if (widget.didReachEnd != null) {
            await widget.didReachEnd();
            _refreshController.loadComplete();
          }
        },
        header: CustomHeader(
          refreshStyle: RefreshStyle.Behind,
          builder: (context, refreshStatus) {
            return LoadingIndicatorWidget();
          },
        ),
        footer: CustomFooter(
          loadStyle: LoadStyle.ShowWhenLoading,
          builder: (context, mode) {
            if (widget.hasMoreData && _showLoadingIndicatorWidget) {
              return LoadingIndicatorWidget();
            }
            return Container();
          },
        ),
        child: listWidget,
      ),
    );
  }
}
