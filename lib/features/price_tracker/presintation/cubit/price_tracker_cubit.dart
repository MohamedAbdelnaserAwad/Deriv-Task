import 'dart:convert';
import 'dart:ui';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:price_tracker/features/price_tracker/presintation/cubit/price_tracker_states.dart';
import '../../../../core/enums/cubit_status.dart';
import '../../../../core/services/web_socket_service.dart';
import '../../../../core/utils/app_color.dart';
import '../../data/available_symbol_model.dart';
import '../../data/market_model.dart';

class PriceTrackerCubit extends Cubit<PriceTrackerStates> {
  final WebSocketService webService;

  PriceTrackerCubit(this.webService) : super(PriceTrackerStates());

  static PriceTrackerCubit get(context) => BlocProvider.of(context);

  String selectedMarket = 'Select a Market';
  String selectedAsset = 'Select a Asset';
  String symbol = '';
  bool isDate = false;
  double qoute =0;
  double oldQoute =0;
  Color priceColor = AppColor.priceDefaultTextColor;
  String noMarket = '';
  getMarkets() async {
    emit(state.copyWith(status: CubitStatus.loading));
    Future.delayed(const Duration(seconds: 2));


    try {
      webService.channel.sink.add(
          json.encode({"active_symbols": "brief", "product_type": "basic"}));
      webService.channel.stream.listen((data) {

        final result = json.decode(data);
        print(result);
        if (result["active_symbols"] != null) {
          List<ActiveSymbols> activeSymbols = List<ActiveSymbols>.from(
              result["active_symbols"].map((e) => ActiveSymbols.fromJson(e)));

          var seen = <String?>{};
           List<ActiveSymbols> markets =
               activeSymbols.where((value) => seen.add(value.market)).toList();
          List<ActiveSymbols>? availableSymbol;
          for (int i = 0; i < activeSymbols.length; i++) {
            if (activeSymbols[i].market == selectedMarket) {
              availableSymbol!.add(activeSymbols[i]);
            }
          }

          emit(state.copyWith(
              status: CubitStatus.success,
              activeSymbols: activeSymbols,
              markets: markets,
              availableSymbol: availableSymbol));

          onError:
          (error) => emit(state.copyWith(
              status: CubitStatus.failure, errorMessage: error.toString()));
        }else if (result["tick"] != null){
          emit(state.copyWith(ticksStatus: CubitStatus.loading));
          Future.delayed(const Duration(seconds: 2));
          Tick tick = Tick.fromJson(result["tick"]);
          qoute = tick.quote!;
          if(oldQoute==0){
            oldQoute = qoute;
          }if(oldQoute > qoute ){
            priceColor = AppColor.priceDecreaseTextColor;
            oldQoute = qoute;
          }if(oldQoute < qoute ){
            priceColor = AppColor.priceIncreaseTextColor;
          }


          emit(state.copyWith(ticksStatus: CubitStatus.success , tick: tick));
        }else if (result["trick"] == null){
          noMarket = 'This market is presently closed.';
          emit(state.copyWith(ticksStatus: CubitStatus.failure));

        }
      });
    } catch (error) {}
  }

  getAsset() async {
    emit(state.copyWith(ticksStatus: CubitStatus.loading));
    try {

      webService.channel.sink
          .add(json.encode({"ticks": symbol, "subscribe": 1}));
    } catch (error) {
      print(error.toString());
    }
  }
}
