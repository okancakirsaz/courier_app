part of '../stats_view.dart';

class OrderLogs extends StatelessWidget {
  final dynamic viewModel;
  final bool isCourierOrderLogs;
  const OrderLogs(
      {super.key, required this.viewModel, required this.isCourierOrderLogs});

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const PartTitle(
              title: "Geçmiş Siparişler",
              subtitle: "İstatistikler",
            ),
            Padding(
              padding: PaddingConsts.instance.all10,
              child: _buildPickButton(() async => await viewModel.pickDate(),
                  "Tarih Aralığı Seçebilirsiniz"),
            ),
            viewModel.selectedTimeRange.isNotEmpty
                ? Padding(
                    padding: PaddingConsts.instance.left10,
                    child: _buildSelectedDataText(
                      "${viewModel.parseIso8601DateFormat(viewModel.selectedTimeRange[0])} - ${viewModel.parseIso8601DateFormat(viewModel.selectedTimeRange[1])} aralığındaki veriler",
                    ),
                  )
                : const SizedBox(),
            isCourierOrderLogs
                ? const SizedBox()
                : Padding(
                    padding: PaddingConsts.instance.all10,
                    child: _buildPickButton(
                      () => viewModel.showRestaurants(viewModel),
                      "Restoran Seçebilirsiniz",
                    ),
                  ),
            Padding(
              padding: PaddingConsts.instance.left10,
              child: _buildSelectedDataText(
                viewModel.selectedRestaurantName,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Observer(builder: (context) {
                  return StatContainer(
                    desc: "Toplam\nKazanç",
                    value: "${viewModel.totalRevenue}₺",
                  );
                }),
                Observer(builder: (context) {
                  return StatContainer(
                    desc: "Sipariş\nSayısı",
                    value: "${viewModel.orderLogCount}",
                  );
                }),
              ],
            ),
            Observer(builder: (context) {
              return SizedBox(
                width: 151,
                child: StatContainer(
                  desc: "İptal Edilen\nSipariş Sayısı",
                  value: "${viewModel.cancelledOrderCount}",
                ),
              );
            }),
            Container(
              margin: PaddingConsts.instance.top20,
              width: 430,
              height: 600,
              child: _buildLogs(),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildLogs() {
    return FutureBuilder<bool>(
      future: viewModel.getOrderLogs(),
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
      if (viewModel.orderLogs.isEmpty) {
        return Center(
          child: Text(
            "Geçmiş siparişiniz bulunmamakta.",
            style: TextConsts.instance.regularBlack16,
          ),
        );
      } else {
        return ListView.builder(
          itemCount: viewModel.orderLogs.length,
          itemBuilder: (context, i) {
            return Padding(
              padding: PaddingConsts.instance.bottom15,
              child: OrderWidget(
                index: i,
                isOrderExpired: true,
                viewModel: OrdersViewModel(),
                data: viewModel.orderLogs[i],
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

  Widget _buildSelectedDataText(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextConsts.instance.regularBlack14,
    );
  }

  Widget _buildPickButton(VoidCallback onPressed, String text) {
    return SizedBox(
      height: 45,
      child: CustomStateFullButton(
        onPressed: onPressed,
        text: text,
        width: 300,
        style: TextConsts.instance.regularWhite16,
      ),
    );
  }
}
