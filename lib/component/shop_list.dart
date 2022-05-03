import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:trivelaapp/component/campeonato_list_item.dart';
import 'package:trivelaapp/controller/campeonato_controller.dart';
import 'package:trivelaapp/model/campeonato_model.dart';
import 'package:trivelaapp/response/campeonato_response.dart';

class ShopList extends StatefulWidget {
  @override
  _ShopListState createState() => _ShopListState();
}

class _ShopListState extends State<ShopList> {
  CampeonatoController _controller;
  List<CampeonatoModel> campeonatos = [];
  PagingController<int, CampeonatoModel> _pagingController =
      PagingController<int, CampeonatoModel>(firstPageKey: 1);
  @override
  void initState() {
    _controller = CampeonatoController();
    _pagingController.addPageRequestListener((pageKey) {
      _pagination(pageKey);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          child: Container(
            child: Scaffold(
              body: Container(
                  child: RefreshIndicator(
                onRefresh: () => Future.sync(() => _pagingController.refresh()),
                child: PagedListView.separated(
                    pagingController: _pagingController,
                    padding: EdgeInsets.all(16),
                    builderDelegate: PagedChildBuilderDelegate<CampeonatoModel>(
                        itemBuilder: (context, campeonato, index) =>
                            CampeonatoListItem(campeonato: campeonato)),
                    separatorBuilder: (context, index) => SizedBox(
                          height: 16.0,
                        )),
              )),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _populate() async {
    CampeonatoResponse response = await _controller.getCampeonatos();
    if (response != null && !response.error) {
      setState(() {
        campeonatos = response.lista;
      });
    }
  }

  Future<void> _pagination(int pageKey) async {
    final previousFetchedItemCount = _pagingController.itemList?.length ?? 0;
    try {
      final List<CampeonatoModel> campeonatoList =
          await _controller.pagination(pageKey, 2);
      final List<CampeonatoModel> lastElement = <CampeonatoModel>[];
      if (campeonatoList.isNotEmpty) {
        lastElement.add(campeonatoList.last);
      }

      final isLastPage = campeonatoList.length < 2;
      if (isLastPage) {
        _pagingController.appendLastPage(lastElement);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(campeonatoList, nextPageKey);
      }
    } catch (e) {
      _pagingController.error = e;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
