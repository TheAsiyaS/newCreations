part of 'counter_bloc.dart';

@immutable
sealed class CounterState {
  const CounterState();//constructor
}

final class CounterInitial extends CounterState {
  final int count;

  const CounterInitial({required this.count});
}
//https://www.flipkart.com/plutoprom-solid-pure-cotton-women-faux-turtleneck-neck-cover-scarf-fancy-scarf/p/itm02f93fc953c39?pid=SCFGXK3SHTJEFQXW&lid=LSTSCFGXK3SHTJEFQXWTIFR8X&marketplace=FLIPKART&q=muslim+cap+for+women&store=clo%2Fqvw%2Fmgw&srno=s_1_3&otracker=AS_QueryStore_OrganicAutoSuggest_1_17_na_na_na&otracker1=AS_QueryStore_OrganicAutoSuggest_1_17_na_na_na&fm=search-autosuggest&iid=4443b9f8-538b-4639-b1d7-12d088956efa.SCFGXK3SHTJEFQXW.SEARCH&ppt=sp&ppn=sp&ssid=jz29cxmv680000001747360118080&qH=31b9a67e28bbc702
