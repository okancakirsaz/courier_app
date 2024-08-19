part of '../orders_view.dart';

class ActiveOrders extends StatelessWidget {
  final dynamic viewModel;
  const ActiveOrders({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: PaddingConsts.instance.all20,
      height: MediaQuery.of(context).size.height - 100,
      width: MediaQuery.of(context).size.width,
      child: _buildActiveOrders(),
    );
  }

  Widget _buildActiveOrders() {
    return FutureBuilder<bool>(
      future: viewModel.getActiveOrders(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!) {
            return _buildListView();
          } else {
            return Center(child: _buildError());
          }
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: ColorConsts.instance.third,
            ),
          );
        }
      },
    );
  }

  Widget _buildListView() {
    return Observer(builder: (context) {
      if (viewModel.activeOrders.isEmpty) {
        return Center(
          child: Text(
            "Henüz yeni bir siparişiniz yok.",
            style: TextConsts.instance.regularBlack16,
          ),
        );
      } else {
        return ListView.builder(
          itemCount: viewModel.activeOrders.length,
          itemBuilder: (context, i) {
            return Padding(
              padding: PaddingConsts.instance.bottom15,
              child: OrderWidget(
                index: i,
                fetchedCourierName: viewModel.activeOrders[i].courierId != null
                    ? viewModel.getFetchedCourierName(
                        viewModel.activeOrders[i].courierId)
                    : null,
                isOrderExpired: false,
                viewModel: viewModel,
                data: viewModel.activeOrders[i],
              ),
            );
          },
        );
      }
    });
  }

  Widget _buildError() {
    return Text(
      "Beklenmeyen bir sorun oluştu.",
      style: TextConsts.instance.regularBlack18Bold,
    );
  }
}
