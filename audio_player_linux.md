```
DateTime get nowTime => DateTime.now(); // now
DateTime get today => DateTime(nowTime.year, nowTime.month, nowTime.day); //? today 
DateTime get nextDay => today.add(const Duration(days: 1)); //? nextday
String get thisWeek => '${nowTime.year}${nowTime.weekOfYear}'; //? this week 
DateTime get thisMonth => DateTime(nowTime.year, nowTime.month, 1); //? this month 
DateTime get thisYear => DateTime(nowTime.year, 1, 1); //? this year 
```