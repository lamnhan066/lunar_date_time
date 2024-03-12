import 'package:lunar_date_time/lunar_date_time.dart';

final getLunarEvents = LunarEventList(events: {
  LunarDateTime(0, 1, 1): [
    LunarEvent(
      date: LunarDateTime(0, 1, 1),
      title: 'Tết Nguyên Đán',
      description:
          'Lễ đón năm mới theo lịch âm, là dịp quan trọng nhất trong các ngày lễ truyền thống của Việt Nam, với nhiều phong tục đặc sắc.',
      repeat: LunarRepeat.yearly(),
      mode: EventMode.readonly,
    ),
  ],
  LunarDateTime(0, 1, 2): [
    LunarEvent(
      date: LunarDateTime(0, 1, 2),
      title: 'Tết Nguyên Đán',
      description:
          'Ngày thứ hai của Tết Nguyên Đán, tiếp tục các hoạt động mừng năm mới và thăm bà con bạn bè.',
      repeat: LunarRepeat.yearly(),
      mode: EventMode.readonly,
    ),
  ],
  LunarDateTime(0, 1, 3): [
    LunarEvent(
      date: LunarDateTime(0, 1, 3),
      title: 'Tết Nguyên Đán',
      description:
          'Ngày thứ ba của Tết Nguyên Đán, kết thúc chuỗi ngày nghỉ lễ với các nghi lễ và phong tục truyền thống.',
      repeat: LunarRepeat.yearly(),
      mode: EventMode.readonly,
    ),
  ],
  LunarDateTime(0, 1, 10): [
    LunarEvent(
      date: LunarDateTime(0, 1, 10),
      title: 'Ngày Vía Thần Tài',
      description:
          'Ngày mọi người cầu mong may mắn và thành công trong kinh doanh, phong tục mua vàng để cầu may mắn.',
      repeat: LunarRepeat.yearly(),
      mode: EventMode.readonly,
    ),
  ],
  LunarDateTime(0, 1, 15): [
    LunarEvent(
      date: LunarDateTime(0, 1, 15),
      title: 'Tết Nguyên Tiêu (Rằm tháng Giêng)',
      description:
          'Ngày Tết Nguyên Tiêu, hay còn gọi là Lễ hội đèn lồng, đánh dấu ngày trăng tròn đầu tiên trong năm âm lịch.',
      repeat: LunarRepeat.yearly(),
      mode: EventMode.readonly,
    ),
  ],
  LunarDateTime(0, 3, 3): [
    LunarEvent(
      date: LunarDateTime(0, 3, 3),
      title: 'Tết Hàn Thực',
      description:
          'Ngày để nhớ tới tổ tiên và thể hiện lòng biết ơn, thường kỷ niệm với việc làm bánh trôi, bánh chay.',
      repeat: LunarRepeat.yearly(),
      mode: EventMode.readonly,
    ),
    LunarEvent(
      date: LunarDateTime(0, 3, 3),
      title: 'Tết Thanh Minh',
      description:
          'Dịp để mọi người đi thăm mộ, tảo mộ, thể hiện sự kính trọng và nhớ ơn đối với tổ tiên.',
      repeat: LunarRepeat.yearly(),
      mode: EventMode.readonly,
    ),
  ],
  LunarDateTime(0, 3, 10): [
    LunarEvent(
      date: LunarDateTime(0, 3, 10),
      title: 'Giỗ Tổ Hùng Vương',
      description:
          'Lễ giỗ tổ Hùng Vương, tổ chức tại Đền Hùng, Phú Thọ, để tưởng nhớ và tri ân các vua Hùng đã có công dựng nước.',
      repeat: LunarRepeat.yearly(),
      mode: EventMode.readonly,
    ),
  ],
  LunarDateTime(0, 4, 15): [
    LunarEvent(
      date: LunarDateTime(0, 4, 15),
      title: 'Lễ Phật Đản',
      description:
          'Kỷ niệm ngày sinh của Đức Phật Thích Ca Mâu Ni, một trong những ngày lễ quan trọng nhất của Phật giáo.',
      repeat: LunarRepeat.yearly(),
      mode: EventMode.readonly,
    ),
  ],
  LunarDateTime(0, 5, 5): [
    LunarEvent(
      date: LunarDateTime(0, 5, 5),
      title: 'Tết Đoan Ngọ',
      description:
          'Ngày mọi người ăn trái cây, uống rượu nếp và thực hiện các nghi lễ để xua đuổi bệnh tật và tà ma.',
      repeat: LunarRepeat.yearly(),
      mode: EventMode.readonly,
    ),
  ],
  LunarDateTime(0, 7, 15): [
    LunarEvent(
      date: LunarDateTime(0, 7, 15),
      title: 'Lễ Vu Lan (Báo Hiếu)',
      description:
          'Dịp để con cái bày tỏ lòng hiếu thảo với cha mẹ, cũng là ngày xá tội vong nhân trong Phật giáo.',
      repeat: LunarRepeat.yearly(),
      mode: EventMode.readonly,
    ),
  ],
  LunarDateTime(0, 8, 15): [
    LunarEvent(
      date: LunarDateTime(0, 8, 15),
      title: 'Tết Trung Thu',
      description:
          'Lễ hội trăng tròn, hay còn gọi là Tết thiếu nhi, với hoạt động rước đèn, ăn bánh trung thu và ngắm trăng.',
      repeat: LunarRepeat.yearly(),
      mode: EventMode.readonly,
    ),
  ],
  LunarDateTime(0, 10, 10): [
    LunarEvent(
      date: LunarDateTime(0, 10, 10),
      title: 'Tết Thường Tân (Tết Cơm Mới)',
      description:
          'Ngày tạ ơn trời đất và tổ tiên, kỷ niệm mùa màng bội thu, thường có nghi lễ cúng cơm mới.',
      repeat: LunarRepeat.yearly(),
      mode: EventMode.readonly,
    ),
  ],
  LunarDateTime(0, 10, 15): [
    LunarEvent(
      date: LunarDateTime(0, 10, 15),
      title: 'Tết Hạ Nguyên',
      description:
          'Ngày để cầu nguyện cho một năm mới an lành, mạnh khỏe, thường có lễ cúng trong gia đình và cộng đồng.',
      repeat: LunarRepeat.yearly(),
      mode: EventMode.readonly,
    ),
  ],
  LunarDateTime(0, 12, 23): [
    LunarEvent(
      date: LunarDateTime(0, 12, 23),
      title: 'Tiễn Táo Quân Về Trời',
      description:
          'Ngày Táo Quân chầu trời báo cáo với Ngọc Hoàng về các sự việc của gia đình trong năm, mọi người thường làm lễ tiễn biệt.',
      repeat: LunarRepeat.yearly(),
      mode: EventMode.readonly,
    ),
  ],
  LunarDateTime(0, 12, 29): [
    LunarEvent(
      date: LunarDateTime(0, 12, 29),
      title: 'Lễ Tất Niên',
      description:
          'Buổi lễ quây quần của gia đình vào ngày cuối cùng của năm âm lịch, để nhìn lại một năm đã qua và chuẩn bị đón năm mới.',
      repeat: LunarRepeat.yearly(),
      mode: EventMode.readonly,
    ),
  ],
  LunarDateTime(0, 12, 30): [
    LunarEvent(
      date: LunarDateTime(0, 12, 30),
      title: 'Lễ Tất Niên',
      description:
          'Tiếp tục của lễ Tất Niên, dành cho những gia đình thực hiện vào ngày cuối cùng của năm âm lịch, một dịp để sum họp và chia sẻ.',
      repeat: LunarRepeat.yearly(),
      mode: EventMode.readonly,
    ),
  ],
});

final getLunarEventsAsList = <LunarEvent>[
  LunarEvent(
    date: LunarDateTime(0, 1, 1),
    title: 'Tết Nguyên Đán',
    description:
        'Lễ đón năm mới theo lịch âm, là dịp quan trọng nhất trong các ngày lễ truyền thống của Việt Nam, với nhiều phong tục đặc sắc.',
    repeat: LunarRepeat.yearly(),
    mode: EventMode.readonly,
  ),
  LunarEvent(
    date: LunarDateTime(0, 1, 2),
    title: 'Tết Nguyên Đán',
    description:
        'Ngày thứ hai của Tết Nguyên Đán, tiếp tục các hoạt động mừng năm mới và thăm bà con bạn bè.',
    repeat: LunarRepeat.yearly(),
    mode: EventMode.readonly,
  ),
  LunarEvent(
    date: LunarDateTime(0, 1, 3),
    title: 'Tết Nguyên Đán',
    description:
        'Ngày thứ ba của Tết Nguyên Đán, kết thúc chuỗi ngày nghỉ lễ với các nghi lễ và phong tục truyền thống.',
    repeat: LunarRepeat.yearly(),
    mode: EventMode.readonly,
  ),
  LunarEvent(
    date: LunarDateTime(0, 1, 10),
    title: 'Ngày Vía Thần Tài',
    description:
        'Ngày mọi người cầu mong may mắn và thành công trong kinh doanh, phong tục mua vàng để cầu may mắn.',
    repeat: LunarRepeat.yearly(),
    mode: EventMode.readonly,
  ),
  LunarEvent(
    date: LunarDateTime(0, 1, 15),
    title: 'Tết Nguyên Tiêu (Rằm tháng Giêng)',
    description:
        'Ngày Tết Nguyên Tiêu, hay còn gọi là Lễ hội đèn lồng, đánh dấu ngày trăng tròn đầu tiên trong năm âm lịch.',
    repeat: LunarRepeat.yearly(),
    mode: EventMode.readonly,
  ),
  LunarEvent(
    date: LunarDateTime(0, 3, 3),
    title: 'Tết Hàn Thực',
    description:
        'Ngày để nhớ tới tổ tiên và thể hiện lòng biết ơn, thường kỷ niệm với việc làm bánh trôi, bánh chay.',
    repeat: LunarRepeat.yearly(),
    mode: EventMode.readonly,
  ),
  LunarEvent(
    date: LunarDateTime(0, 3, 10),
    title: 'Giỗ Tổ Hùng Vương',
    description:
        'Lễ giỗ tổ Hùng Vương, tổ chức tại Đền Hùng, Phú Thọ, để tưởng nhớ và tri ân các vua Hùng đã có công dựng nước.',
    repeat: LunarRepeat.yearly(),
    mode: EventMode.readonly,
  ),
  LunarEvent(
    date: LunarDateTime(0, 4, 15),
    title: 'Lễ Phật Đản',
    description:
        'Kỷ niệm ngày sinh của Đức Phật Thích Ca Mâu Ni, một trong những ngày lễ quan trọng nhất của Phật giáo.',
    repeat: LunarRepeat.yearly(),
    mode: EventMode.readonly,
  ),
  LunarEvent(
    date: LunarDateTime(0, 5, 5),
    title: 'Tết Đoan Ngọ',
    description:
        'Ngày mọi người ăn trái cây, uống rượu nếp và thực hiện các nghi lễ để xua đuổi bệnh tật và tà ma.',
    repeat: LunarRepeat.yearly(),
    mode: EventMode.readonly,
  ),
  LunarEvent(
    date: LunarDateTime(0, 7, 15),
    title: 'Lễ Vu Lan (Báo Hiếu)',
    description:
        'Dịp để con cái bày tỏ lòng hiếu thảo với cha mẹ, cũng là ngày xá tội vong nhân trong Phật giáo.',
    repeat: LunarRepeat.yearly(),
    mode: EventMode.readonly,
  ),
  LunarEvent(
    date: LunarDateTime(0, 8, 15),
    title: 'Tết Trung Thu',
    description:
        'Lễ hội trăng tròn, hay còn gọi là Tết thiếu nhi, với hoạt động rước đèn, ăn bánh trung thu và ngắm trăng.',
    repeat: LunarRepeat.yearly(),
    mode: EventMode.readonly,
  ),
  LunarEvent(
    date: LunarDateTime(0, 10, 10),
    title: 'Tết Thường Tân (Tết Cơm Mới)',
    description:
        'Ngày tạ ơn trời đất và tổ tiên, kỷ niệm mùa màng bội thu, thường có nghi lễ cúng cơm mới.',
    repeat: LunarRepeat.yearly(),
    mode: EventMode.readonly,
  ),
  LunarEvent(
    date: LunarDateTime(0, 10, 15),
    title: 'Tết Hạ Nguyên',
    description:
        'Ngày để cầu nguyện cho một năm mới an lành, mạnh khỏe, thường có lễ cúng trong gia đình và cộng đồng.',
    repeat: LunarRepeat.yearly(),
    mode: EventMode.readonly,
  ),
  LunarEvent(
    date: LunarDateTime(0, 12, 23),
    title: 'Tiễn Táo Quân Về Trời',
    description:
        'Ngày Táo Quân chầu trời báo cáo với Ngọc Hoàng về các sự việc của gia đình trong năm, mọi người thường làm lễ tiễn biệt.',
    repeat: LunarRepeat.yearly(),
    mode: EventMode.readonly,
  ),
  LunarEvent(
    date: LunarDateTime(0, 12, 29),
    title: 'Lễ Tất Niên',
    description:
        'Buổi lễ quây quần của gia đình vào ngày cuối cùng của năm âm lịch, để nhìn lại một năm đã qua và chuẩn bị đón năm mới.',
    repeat: LunarRepeat.yearly(),
    mode: EventMode.readonly,
    isEndOfMonth: true,
  ),
];
