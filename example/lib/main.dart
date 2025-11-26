import 'package:flutter/material.dart';
import 'package:lunar_date_time/lunar_date_time.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _lunarDateTime = LunarDateTime.fromDateTime(Utc7.now());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Lịch Việt Hôm Nay'),
        ),
        body: Center(
          child: Text(
            'Ngày ${_lunarDateTime.day} tháng ${_lunarDateTime.month} năm ${_lunarDateTime.year} \n'
            '${_lunarDateTime.isLeapMonth ? '(Nhuần)' : ''}',
          ),
        ),
      ),
    );
  }
}
