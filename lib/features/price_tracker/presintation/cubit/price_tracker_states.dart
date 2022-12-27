 import '../../../../core/enums/cubit_status.dart';
import '../../data/available_symbol_model.dart';
import '../../data/market_model.dart';

class PriceTrackerStates{
   String errorMessage ;
   CubitStatus activeSymbolsStatus , ticksStatus;
   List<ActiveSymbols>? activeSymbols ,markets , availableSymbol;
   Tick? tick;

   PriceTrackerStates({this.errorMessage='',this.markets,this.tick,this.availableSymbol, this.activeSymbolsStatus = CubitStatus.initial,
     this.ticksStatus = CubitStatus.initial,this.activeSymbols});

   PriceTrackerStates copyWith({
     String? errorMessage,
     CubitStatus? status,
     CubitStatus? ticksStatus,
     List<ActiveSymbols>? activeSymbols ,markets,availableSymbol,
     Tick? tick,
   }) {
     return PriceTrackerStates(
       errorMessage: errorMessage ?? this.errorMessage,
       activeSymbolsStatus: status ?? activeSymbolsStatus,
       ticksStatus: ticksStatus ?? this.ticksStatus,
       activeSymbols: activeSymbols ?? this.activeSymbols,
       availableSymbol: availableSymbol ?? availableSymbol,
       tick: tick ?? tick,
       markets: markets ?? this.markets
     );
   }

}
