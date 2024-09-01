part of '../orders_view.dart';

class OrderReview extends StatelessWidget {
  final OrdersViewModel viewModel;
  final AddressModel data;
  const OrderReview({super.key, required this.viewModel, required this.data});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "Sipariş Teslim",
            style: TextConsts.instance.regularBlack18Bold,
          ),
          centerTitle: false,
        ),
        body: Padding(
          padding: PaddingConsts.instance.all10,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Bu adrese sipariş götüren ilk kurye sizsiniz.",
                style: TextConsts.instance.regularBlack16,
              ),
              Padding(
                padding: PaddingConsts.instance.top10,
                child: _isAddressTrue(),
              ),
              Padding(
                padding: PaddingConsts.instance.top40,
                child: _addressDescription(),
              ),
              Padding(
                padding: PaddingConsts.instance.top10,
                child: CustomStateFullButton(
                  onPressed: () async => viewModel.updateAddressAsCourier(data),
                  text: "Onayla",
                  style: TextConsts.instance.regularWhite18,
                  gradient: ColorConsts.instance.thirdGradient,
                ),
              ),
            ],
          ),
        ));
  }

  Widget _isAddressTrue() {
    return Column(
      children: <Widget>[
        Text(
          "Adres doğru muydu?",
          style: TextConsts.instance.regularBlack18Bold,
        ),
        Padding(
          padding: PaddingConsts.instance.top10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              CustomButton(
                onPressed: () => viewModel.isAddressTrue = false,
                text: "Hayır",
                style: TextConsts.instance.regularWhite18,
              ),
              CustomButton(
                onPressed: () => viewModel.isAddressTrue = true,
                text: "Evet",
                style: TextConsts.instance.regularWhite18,
                backgroundColor: Colors.green,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _addressDescription() {
    return Column(
      children: <Widget>[
        Text(
          "Bu adresi bulmanın kolaylaşması için bir adres tarifi bırakınız.",
          style: TextConsts.instance.regularBlack18Bold,
        ),
        CustomTextField(
          maxLine: 10,
          height: 100,
          controller: viewModel.addressDirection,
          hintStyle: TextConsts.instance.regularBlack16,
          hint: "Adres Tarifi",
        ),
      ],
    );
  }
}
