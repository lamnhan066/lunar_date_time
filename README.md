# 🇻🇳 Lunar Date Time

Thư viện Dart hỗ trợ chuyển đổi và tính toán ngày tháng theo lịch Việt Nam, bao gồm:

- 🌕 **Lịch Âm (LunarDateTime)** với tháng nhuận và can chi
- ☀️ **Lịch Dương (SolarDateTime)** với múi giờ cố định (UTC+7)
- 📅 Chuyển đổi hai chiều giữa `DateTime`, `SolarDateTime`, và `LunarDateTime`
- 🧙 Can chi (Giáp Tý, Ất Sửu,...) cho năm, tháng, ngày, giờ
- 🔮 Tiết khí, giờ hoàng đạo, và danh sách các ngày lễ truyền thống

---

## ✨ Cài đặt

```bash
dart pub add lunar_date_time
```

---

## 📦 Các lớp chính

### `SolarDateTime`

Là lớp bao bọc `DateTime` với múi giờ cố định UTC+7 (giờ Việt Nam), dùng để tính toán chuẩn hơn cho các phép chuyển đổi âm-dương lịch.

### `LunarDateTime`

Là lớp đại diện cho ngày âm lịch, hỗ trợ:

- Chuyển đổi sang/dưới `DateTime`
- Xử lý tháng nhuận
- Lấy thông tin can chi, tiết khí, giờ hoàng đạo
- Danh sách các ngày lễ âm lịch

---

## 🔧 Sử dụng

### Tạo `LunarDateTime` thủ công

```dart
// Ngày 1 tháng 10 năm 2023 (không nhuận)
final lunar = LunarDateTime(2023, 10, 1);

// Ngày 1 tháng 10 năm 2023 (tháng nhuận)
final leapLunar = LunarDateTime.leapMonth(2023, 10, 1);
```

### Tạo từ `DateTime`

```dart
final now = DateTime.now();
final lunar = LunarDateTime.fromDateTime(now);

// hoặc dùng extension
final lunarAlt = now.toLunarDateTime;
```

### Chuyển từ `LunarDateTime` sang `DateTime` hoặc `SolarDateTime`

```dart
final dateTime = lunar.toDateTime();        // Chuẩn UTC
final solar = lunar.toSolar();              // SolarDateTime (UTC+7)
```

### Tạo `SolarDateTime`

```dart
final solar = SolarDateTime(2024, 4, 16);

// Từ DateTime (đảm bảo đúng UTC+7)
final solar2 = SolarDateTime.fromDateTime(DateTime.now());
```

---

## 📆 Tính năng nâng cao

### Can Chi (Thiên Can Địa Chi)

```dart
final canChiYear = lunar.stemBranchOfYear;   // Ví dụ: "Giáp Thìn"
final canChiMonth = lunar.stemBranchOfMonth;
final canChiDay = lunar.stemBranchOfDay;
final canHour = lunar.stemOfHour;
```

### Tiết khí & Giờ hoàng đạo

```dart
final solarTerm = lunar.solarTerms;   // Ví dụ: "Xuân phân"
final luckyHours = lunar.luckyHour;   // Ví dụ: "Tý, Dần, Mão, Ngọ, Dậu, Hợi"
```

### Kiểm tra tháng nhuận

```dart
final isLeap = lunar.isLeapMonth;
final hasLeapMonth = LunarDateTime.checkLeapMonth(2025, 4);
```

---

## 📜 Danh sách ngày lễ

### Âm lịch

```dart
final lunarEventList = LunarDateTime.lunarEvents;
final flatList = LunarDateTime.lunarEventsAsList;
```

### Dương lịch

```dart
final solarEventList = LunarDateTime.solarEvents;
final flatSolarList = LunarDateTime.solarEventsAsList;
```

---

## ⏱ So sánh & tính toán

```dart
final now = DateTime.now();
final lunarNow = LunarDateTime.fromDateTime(now);
final future = lunarNow.toSolar().add(Duration(days: 3)).toLunar();

final isSame = lunarNow.toDateTime() == future.toDateTime();
```

> Lưu ý: `LunarDateTime` không hỗ trợ trực tiếp `add`, `subtract`, `compareTo`. Bạn cần dùng `toSolar()` hoặc `toDateTime()` trước khi thực hiện các thao tác đó.

---

## 📚 Tài liệu nội bộ

### `LunarDateTime`

| Thuộc tính             | Ý nghĩa                            |
| ---------------------- | ---------------------------------- |
| `year`, `month`, `day` | Thời gian âm lịch                  |
| `isLeapMonth`          | Tháng hiện tại có phải tháng nhuận |
| `toSolar()`            | Chuyển sang `SolarDateTime`        |
| `toDateTime()`         | Chuyển sang chuẩn `DateTime`       |
| `stemBranchOfYear`     | Can chi năm                        |
| `solarTerms`           | Tiết khí                           |
| ...                    | và nhiều hơn nữa                   |

### `SolarDateTime`

| Thuộc tính      | Ý nghĩa                            |
| --------------- | ---------------------------------- |
| `_dateTime`     | `DateTime` nội bộ, luôn UTC+7      |
| `toDateTime()`  | Chuyển sang chuẩn UTC `DateTime`   |
| Các getter time | `year`, `month`, `day`, `hour`,... |

---

## 🤝 Đóng góp

Mọi đóng góp đều được hoan nghênh! Bạn có thể:

- Mở [issue](https://github.com/ban-than/viet-date-time/issues) để đề xuất tính năng hoặc báo lỗi
- Gửi Pull Request

---

## 📜 Giấy phép

[MIT](LICENSE)