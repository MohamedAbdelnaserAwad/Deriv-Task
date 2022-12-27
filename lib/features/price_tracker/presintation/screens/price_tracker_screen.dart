import 'package:flutter/material.dart';
import 'package:price_tracker/core/enums/log.dart';
import 'package:price_tracker/core/utils/app_color.dart';
import 'package:price_tracker/features/price_tracker/data/market_model.dart';
import 'package:price_tracker/features/price_tracker/presintation/cubit/price_tracker_cubit.dart';
import 'package:price_tracker/features/price_tracker/presintation/cubit/price_tracker_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/dependency_injection/service_locator.dart';

class PriceTrackerScreen extends StatefulWidget {
  const PriceTrackerScreen({Key? key}) : super(key: key);

  @override
  State<PriceTrackerScreen> createState() => _PriceTrackerScreenState();
}

class _PriceTrackerScreenState extends State<PriceTrackerScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<PriceTrackerCubit>(
        create: (context) => PriceTrackerCubit(sl())..getMarkets(),
        child: BlocBuilder<PriceTrackerCubit, PriceTrackerStates>(
            builder: (context, state) {
          var cubit = PriceTrackerCubit.get(context);
          return state.activeSymbolsStatus.isSubmissionLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Scaffold(
                  appBar: AppBar(
                    title: const Text("Price Tracker"),
                    centerTitle: true,
                    backgroundColor: AppColor.priceDefaultTextColor,
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FormField<ActiveSymbols>(
                            builder: (_) {
                              return InputDecorator(
                                decoration: InputDecoration(
                                    errorStyle: const TextStyle(
                                        color: Colors.black12, fontSize: 16.0),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0))),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<ActiveSymbols>(
                                    isDense: true,
                                    hint: Text(
                                      cubit.selectedMarket == ''
                                          ? 'Select a Market'
                                          : cubit.selectedMarket,
                                    ),
                                    onChanged: (ActiveSymbols? newValue) {
                                      setState(() {
                                        cubit.qoute=0;
                                        cubit.oldQoute=0;
                                        cubit.selectedMarket =
                                            newValue!.market.toString();
                                        //cubit.selectedAsset = 'Select a Asset';
                                      });
                                    },
                                    items: state.markets
                                        ?.map((ActiveSymbols value) {
                                      return DropdownMenuItem<ActiveSymbols>(
                                        value: value,
                                        child: Text(value.market ?? ''),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          FormField<ActiveSymbols>(
                            builder: (_) {
                              return InputDecorator(
                                decoration: InputDecoration(
                                    errorStyle: const TextStyle(
                                        color: Colors.black12, fontSize: 16.0),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0))),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<ActiveSymbols>(
                                    isDense: true,
                                    hint: Text(cubit.selectedAsset),
                                    onChanged: (ActiveSymbols? newValue) {
                                      setState(() {
                                        cubit.qoute =0;
                                        cubit.oldQoute=0;
                                        cubit.symbol =
                                            newValue!.symbol.toString();
                                        print("symbol ${cubit.symbol}");
                                        cubit.selectedAsset =
                                            newValue.submarketDisplayName!;
                                        context
                                            .read<PriceTrackerCubit>()
                                            .getAsset();
                                      });
                                    },
                                    items: state.markets
                                        ?.map((ActiveSymbols value) {
                                      return DropdownMenuItem<ActiveSymbols>(
                                        value: value,
                                        child: Text(value.displayName ?? ''),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 50.0,
                          ),
                          state.ticksStatus.isSubmissionLoading?
                              const CircularProgressIndicator()
                          :state.ticksStatus.isSubmissionFailure ?Text(cubit.noMarket)
                          :Text(
                            state.tick?.quote?.toString() ?? '',
                            style: TextStyle(
                                color: cubit.priceColor,
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
        }));
  }
}
