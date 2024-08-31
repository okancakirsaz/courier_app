part of '../orders_view.dart';

class CourierData extends StatelessWidget {
  final OrdersViewModel viewModel;
  const CourierData({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: viewModel.getCourierData(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!) {
          return _courier();
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

  Widget _courier() {
    return Padding(
      padding: PaddingConsts.instance.all10,
      child: Observer(builder: (context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              viewModel.courierData!.nameSurname,
              style: TextConsts.instance.regularBlack18Bold,
            ),
            Row(
              children: <Widget>[
                Text(
                  viewModel.courierData!.phoneNumber,
                  style: TextConsts.instance.regularBlack16,
                ),
                Padding(
                  padding: PaddingConsts.instance.left5,
                  child: Text(
                    viewModel.isWorking ? "Çalışıyor" : "Çalışmıyor",
                    style: TextConsts.instance.regularCustomColor16(
                      viewModel.isWorking ? Colors.green : Colors.red,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: PaddingConsts.instance.top10,
              child: CustomStateFullButton(
                onPressed: () async => viewModel.updateCourierWorkState(),
                style: TextConsts.instance.regularWhite16,
                width: 150,
                text: viewModel.isWorking
                    ? "Çalışmayı Sonlandır"
                    : "Çalışmaya Başla",
              ),
            ),
          ],
        );
      }),
    );
  }
}
