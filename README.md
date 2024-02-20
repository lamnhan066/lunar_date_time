# Viet Date Time

Hỗ trợ trong việc chuyển đổi và tính toán ngày tháng, thời gian và can chi theo lịch Việt Nam.

## Sử Dụng

Khai báo theo ngày tháng cu thê:

``` dart
// Ngày 1 tháng 10 năm 2023 và tháng 10 không phải tháng nhuần
final LunarDateTime = LunarDateTime(2023, 10, 1);

// Ngày 1 tháng 10 năm 2023 và tháng 10 và là tháng nhuần
final LunarDateTime = LunarDateTime.leapMonth(2023, 10, 1);
```

Chuyển đổi từ `DateTime`:

``` dart
final LunarDateTime = LunarDateTime.now();
// Or
final LunarDateTime = LunarDateTime.fromDateTime(DateTime.now());
// Or
final LunarDateTime = DateTime.now().toLunarDateTime;
```

Chuyển từ `LunarDateTime` sang `DateTime`:

``` dart
final dateTime = LunarDateTime.toDateTime();
```

Kiểm tra tháng hiện tại có phải tháng nhuần hay không

``` dart
final isLeapMonth = LunarDateTime.isLeapMonth;
```

Bạn có thể sử dụng các phép tính như `DateTime` và có thể sử dụng thay thế cho `DateTime`

``` dart
LunarDateTime.add(Duration(days: 3));
LunarDateTime.compareTo(LunarDateTime.fromSolar(DateTime.now()));
```

Thông tin các ngày lễ trong năm:

``` dart
// Các ngày lễ theo âm lịch
// Kết quả sẽ là danh sách với thời gian tính theo `LunarDateTime`
LunarDateTime.lunarEvents;

// Các ngày lễ theo dương lịch
// Kết quả sẽ là danh sách với thời gian tính theo `DateTime`
LunarDateTime.solarEvents; 
```
