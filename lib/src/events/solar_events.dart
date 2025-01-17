import 'dart:core';

import 'package:lunar_date_time/src/models/enums.dart';
import 'package:lunar_date_time/src/models/solar_event.dart';
import 'package:lunar_date_time/src/models/solar_event_list.dart';

final getSolarEvents = SolarEventList(events: {
  DateTime(0, 1, 1): [
    SolarEvent(
      date: DateTime(0, 1, 1),
      title: 'Tết Dương Lịch',
      description:
          'Đánh dấu ngày đầu tiên của năm mới theo lịch Gregorian, được kỷ niệm trên toàn thế giới.',
      repeat: SolarRepeat.yearly(),
      mode: EventMode.readonly,
    ),
  ],
  DateTime(0, 2, 3): [
    SolarEvent(
      date: DateTime(1930, 2, 3),
      title: 'Ngày thành lập Đảng Cộng sản Việt Nam',
      description:
          'Kỷ niệm ngày thành lập Đảng Cộng sản Việt Nam vào ngày 3 tháng 2 năm 1930, sự kiện quan trọng trong lịch sử cách mạng Việt Nam.',
      repeat: SolarRepeat.yearly(),
      mode: EventMode.readonly,
    ),
  ],
  DateTime(0, 2, 14): [
    SolarEvent(
      date: DateTime(0, 2, 14),
      title: 'Lễ tình nhân (Valentine)',
      description:
          'Ngày lễ dành cho các cặp đôi để bày tỏ tình yêu và tình cảm với nhau.',
      repeat: SolarRepeat.yearly(),
      mode: EventMode.readonly,
    ),
  ],
  DateTime(0, 2, 27): [
    SolarEvent(
      date: DateTime(1955, 2, 27),
      title: 'Ngày thầy thuốc Việt Nam',
      description:
          'Tôn vinh các bác sĩ và nhân viên y tế, ghi nhận những đóng góp của họ cho ngành y tế.',
      repeat: SolarRepeat.yearly(),
      mode: EventMode.readonly,
    ),
  ],
  DateTime(0, 3, 8): [
    SolarEvent(
      date: DateTime(1977, 3, 8),
      title: 'Ngày Quốc tế Phụ nữ',
      description:
          'Kỷ niệm các thành tựu của phụ nữ và thúc đẩy bình đẳng giới trên toàn cầu.',
      repeat: SolarRepeat.yearly(),
      mode: EventMode.readonly,
    ),
  ],
  DateTime(0, 3, 23): [
    SolarEvent(
      date: DateTime(1946, 3, 23),
      title: 'Ngày Quốc tế Hạnh phúc',
      description:
          'Nhấn mạnh tầm quan trọng của hạnh phúc trong cuộc sống của mỗi người và cộng đồng.',
      repeat: SolarRepeat.yearly(),
      mode: EventMode.readonly,
    ),
  ],
  DateTime(0, 3, 26): [
    SolarEvent(
      date: DateTime(1931, 3, 26),
      title: 'Ngày thành lập Đoàn TNCS Hồ Chí Minh',
      description:
          'Kỷ niệm ngày thành lập Đoàn Thanh niên Cộng sản Hồ Chí Minh, tổ chức vận động thanh niên Việt Nam.',
      repeat: SolarRepeat.yearly(),
      mode: EventMode.readonly,
    ),
  ],
  DateTime(0, 4, 1): [
    SolarEvent(
      date: DateTime(0, 4, 1),
      title: 'Ngày Cá tháng Tư',
      description:
          'Ngày nổi tiếng với các trò đùa và câu chuyện giả mạo, mọi người thường chọc phá nhau bằng những trò đùa vui vẻ.',
      repeat: SolarRepeat.yearly(),
      mode: EventMode.readonly,
    ),
  ],
  DateTime(0, 4, 22): [
    SolarEvent(
      date: DateTime(1970, 4, 22),
      title: 'Ngày Trái Đất',
      description:
          'Ngày nâng cao nhận thức về môi trường và bảo vệ hành tinh của chúng ta.',
      repeat: SolarRepeat.yearly(),
      mode: EventMode.readonly,
    ),
  ],
  DateTime(0, 4, 30): [
    SolarEvent(
      date: DateTime(1975, 4, 30),
      title: 'Ngày Giải phóng miền Nam, thống nhất đất nước',
      description:
          'Đánh dấu sự kết thúc của chiến tranh Việt Nam và sự thống nhất đất nước.',
      repeat: SolarRepeat.yearly(),
      mode: EventMode.readonly,
    ),
  ],
  DateTime(0, 5, 1): [
    SolarEvent(
      date: DateTime(1886, 5, 1),
      title: 'Ngày Quốc tế Lao động',
      description:
          'Kỷ niệm quyền và thành tựu của người lao động trên toàn thế giới.',
      repeat: SolarRepeat.yearly(),
      mode: EventMode.readonly,
    ),
  ],
  DateTime(0, 5, 7): [
    SolarEvent(
      date: DateTime(1954, 5, 7),
      title: 'Ngày chiến thắng Điện Biên Phủ',
      description:
          'Kỷ niệm chiến thắng lịch sử của quân đội Việt Nam trước quân đội Pháp tại Điện Biên Phủ năm 1954.',
      repeat: SolarRepeat.yearly(),
      mode: EventMode.readonly,
    ),
  ],
  DateTime(0, 5, 13): [
    SolarEvent(
      date: DateTime(1929, 5, 13),
      title: 'Ngày thành lập Công đoàn Việt Nam',
      description:
          'Tôn vinh sự đóng góp của công đoàn trong việc thúc đẩy các phong trào đấu tranh bảo vệ quyền lợi của người lao động, nâng cao đời sống của họ, và phát triển nền kinh tế quốc dân.',
      repeat: SolarRepeat.yearly(),
      mode: EventMode.readonly,
    ),
  ],
  DateTime(0, 5, 15): [
    SolarEvent(
      date: DateTime(1941, 5, 15),
      title: 'Ngày thành lập Đội Thiếu niên Tiền phong Hồ Chí Minh',
      description:
          'Kỷ niệm ngày thành lập tổ chức Đội Thiếu niên Tiền phong Hồ Chí Minh, tổ chức dành cho thanh thiếu niên Việt Nam.',
      repeat: SolarRepeat.yearly(),
      mode: EventMode.readonly,
    ),
  ],
  DateTime(0, 5, 19): [
    SolarEvent(
      date: DateTime(1890, 5, 19),
      title: 'Ngày sinh của Chủ tịch Hồ Chí Minh',
      description:
          'Tưởng niệm ngày sinh của Chủ tịch Hồ Chí Minh, người sáng lập và là lãnh tụ vĩ đại của Việt Nam.',
      repeat: SolarRepeat.yearly(),
      mode: EventMode.readonly,
    ),
  ],
  DateTime(0, 6, 1): [
    SolarEvent(
      date: DateTime(1954, 6, 1),
      title: 'Ngày Quốc tế thiếu nhi',
      description:
          'Ngày dành để nâng cao nhận thức và cải thiện phúc lợi của trẻ em trên toàn thế giới.',
      repeat: SolarRepeat.yearly(),
      mode: EventMode.readonly,
    ),
  ],
  DateTime(0, 6, 5): [
    SolarEvent(
      date: DateTime(1972, 6, 5),
      title: 'Ngày Môi trường Thế giới',
      description:
          'Ngày nâng cao nhận thức về môi trường trên toàn thế giới và thúc đẩy hành động bảo vệ môi trường.',
      repeat: SolarRepeat.yearly(),
      mode: EventMode.readonly,
    ),
  ],
  DateTime(0, 6, 17): [
    SolarEvent(
      date: DateTime(0, 6, 17),
      title: 'Ngày Môi trường Thế giới',
      description:
          'Kêu gọi các hành động toàn cầu để bảo vệ đất đai, ngừng tình trạng sa mạc hóa và khắc phục các vấn đề môi trường do con người gây ra, cũng như để duy trì môi trường sống bền vững cho thế hệ tương lai.',
      repeat: SolarRepeat.yearly(),
      mode: EventMode.readonly,
    ),
  ],
  DateTime(0, 6, 21): [
    SolarEvent(
      date: DateTime(1925, 6, 21),
      title: 'Ngày Báo chí Cách mạng Việt Nam',
      description:
          'Kỷ niệm ngày Báo chí Cách mạng Việt Nam, tôn vinh những đóng góp của báo chí và nhà báo.',
      repeat: SolarRepeat.yearly(),
      mode: EventMode.readonly,
    ),
  ],
  DateTime(0, 6, 28): [
    SolarEvent(
      date: DateTime(2000, 6, 28),
      title: 'Ngày Gia đình Việt Nam',
      description:
          'Nhấn mạnh tầm quan trọng của gia đình, thúc đẩy sự gắn kết và yêu thương giữa các thành viên.',
      repeat: SolarRepeat.yearly(),
      mode: EventMode.readonly,
    ),
  ],
  DateTime(0, 7, 11): [
    SolarEvent(
      date: DateTime(1989, 7, 11),
      title: 'Ngày dân số thế giới',
      description:
          'Nâng cao nhận thức về các vấn đề dân số và sức khỏe sinh sản trên toàn cầu.',
      repeat: SolarRepeat.yearly(),
      mode: EventMode.readonly,
    ),
  ],
  DateTime(0, 7, 20): [
    SolarEvent(
      date: DateTime(1954, 7, 20),
      title: 'Ngày ký Hiệp định Genève',
      description:
          'Hiệp định này đánh dấu sự kết thúc của thực dân Pháp tại Đông Dương, nhưng cũng tạo ra một sự chia cắt chính trị lớn trong lịch sử Việt Nam, dẫn đến nhiều sự kiện tiếp theo trong cuộc chiến tranh Việt Nam.',
      repeat: SolarRepeat.yearly(),
      mode: EventMode.readonly,
    ),
  ],
  DateTime(0, 7, 21): [
    SolarEvent(
      date: DateTime(1982, 7, 21),
      title: 'Ngày Quốc tế Hòa bình',
      description:
          'Ngày tôn vinh hòa bình toàn cầu, khuyến khích chấm dứt chiến tranh và xung đột.',
      repeat: SolarRepeat.yearly(),
      mode: EventMode.readonly,
    ),
  ],
  DateTime(0, 7, 27): [
    SolarEvent(
      date: DateTime(1947, 7, 27),
      title: 'Ngày Thương binh liệt sĩ',
      description:
          'Tưởng niệm và tri ân những người đã hy sinh và bị thương vì độc lập và tự do của Tổ quốc.',
      repeat: SolarRepeat.yearly(),
      mode: EventMode.readonly,
    ),
  ],
  DateTime(0, 7, 28): [
    SolarEvent(
      date: DateTime(1929, 7, 28),
      title: 'Ngày thành lập Công đoàn Việt Nam',
      description:
          'Kỷ niệm ngày thành lập Công đoàn Việt Nam, tôn vinh vai trò và đóng góp của công đoàn và người lao động.',
      repeat: SolarRepeat.yearly(),
      mode: EventMode.readonly,
    ),
  ],
  DateTime(0, 8, 19): [
    SolarEvent(
      date: DateTime(0, 8, 19),
      title: 'Ngày tổng khởi nghĩa',
      description:
          'Đánh dấu sự kiện tổng khởi nghĩa giành chính quyền trong cả nước năm 1945, mở đầu cho sự nghiệp độc lập tự do.',
      repeat: SolarRepeat.yearly(),
      mode: EventMode.readonly,
    ),
  ],
  DateTime(0, 9, 2): [
    SolarEvent(
      date: DateTime(1945, 9, 2),
      title: 'Ngày Quốc Khánh',
      description:
          'Kỷ niệm ngày Bác Hồ đọc Tuyên ngôn Độc lập tại Quảng trường Ba Đình, khai sinh nước Việt Nam Dân chủ Cộng hòa.',
      repeat: SolarRepeat.yearly(),
      mode: EventMode.readonly,
    ),
  ],
  DateTime(0, 9, 5): [
    SolarEvent(
      date: DateTime(0, 9, 5),
      title: 'Ngày Khai giảng',
      description:
          'Ngày bắt đầu năm học mới tại Việt Nam, đánh dấu một bước tiến mới của học sinh và sinh viên.',
      repeat: SolarRepeat.yearly(),
      mode: EventMode.readonly,
    ),
  ],
  DateTime(0, 9, 10): [
    SolarEvent(
      date: DateTime(1955, 9, 10),
      title: 'Ngày thành lập Mặt trận Tổ quốc Việt Nam',
      description:
          'Kỷ niệm ngày thành lập Mặt trận Tổ quốc Việt Nam, tổ chức chính trị - xã hội rộng lớn của nhân dân.',
      repeat: SolarRepeat.yearly(),
      mode: EventMode.readonly,
    ),
  ],
  DateTime(0, 10, 1): [
    SolarEvent(
      date: DateTime(1990, 10, 1),
      title: 'Ngày Quốc tế Người cao tuổi',
      description:
          'Tôn vinh người cao tuổi, nhấn mạnh vai trò và đóng góp của họ trong xã hội.',
      repeat: SolarRepeat.yearly(),
      mode: EventMode.readonly,
    ),
  ],
  DateTime(0, 10, 10): [
    SolarEvent(
      date: DateTime(1954, 10, 10),
      title: 'Ngày giải phóng thủ đô',
      description:
          'Kỷ niệm ngày giải phóng Thủ đô Hà Nội, một dấu mốc quan trọng trong lịch sử dân tộc.',
      repeat: SolarRepeat.yearly(),
      mode: EventMode.readonly,
    ),
  ],
  DateTime(0, 10, 13): [
    SolarEvent(
      date: DateTime(2004, 10, 13),
      title: 'Ngày doanh nhân Việt Nam',
      description:
          'Kỷ niệm và tôn vinh những đóng góp của cộng đồng doanh nhân đối với sự phát triển kinh tế - xã hội của Việt Nam.',
      repeat: SolarRepeat.yearly(),
      mode: EventMode.readonly,
    ),
  ],
  DateTime(0, 10, 20): [
    SolarEvent(
      date: DateTime(1930, 10, 20),
      title: 'Ngày Phụ nữ Việt Nam',
      description:
          'Tôn vinh phụ nữ Việt Nam, khẳng định vai trò và vị thế của phụ nữ trong gia đình và xã hội.',
      repeat: SolarRepeat.yearly(),
      mode: EventMode.readonly,
    ),
  ],
  DateTime(0, 10, 31): [
    SolarEvent(
      date: DateTime(0, 10, 31),
      title: 'Ngày Halloween',
      description:
          'Lễ hội phương Tây nổi tiếng, với các hoạt động như hóa trang, đi xin kẹo và trang trí nhà cửa.',
      repeat: SolarRepeat.yearly(),
      mode: EventMode.readonly,
    ),
  ],
  DateTime(0, 11, 9): [
    SolarEvent(
      date: DateTime(1946, 11, 9),
      title: 'Ngày pháp luật Việt Nam',
      description:
          'Nâng cao nhận thức pháp luật cho người dân, khuyến khích việc tuân thủ và hiểu biết pháp luật.',
      repeat: SolarRepeat.yearly(),
      mode: EventMode.readonly,
    ),
  ],
  DateTime(0, 11, 17): [
    SolarEvent(
      date: DateTime(1939, 11, 17),
      title: 'Ngày Sinh viên Quốc tế',
      description:
          'Ngày tôn vinh các sinh viên trên toàn thế giới và khuyến khích giáo dục và phát triển cá nhân.',
      repeat: SolarRepeat.yearly(),
      mode: EventMode.readonly,
    ),
  ],
  DateTime(0, 11, 19): [
    SolarEvent(
      date: DateTime(1999, 11, 19),
      title: 'Ngày Quốc tế nam giới',
      description:
          'Nhấn mạnh sự cần thiết của việc chăm sóc sức khỏe nam giới và tôn vinh những đóng góp của họ cho gia đình và xã hội.',
      repeat: SolarRepeat.yearly(),
      mode: EventMode.readonly,
    ),
  ],
  DateTime(0, 11, 20): [
    SolarEvent(
      date: DateTime(1982, 11, 20),
      title: 'Ngày Nhà giáo Việt Nam',
      description:
          'Tôn vinh những đóng góp của các thầy cô giáo đối với sự nghiệp giáo dục và đào tạo.',
      repeat: SolarRepeat.yearly(),
      mode: EventMode.readonly,
    ),
  ],
  DateTime(0, 11, 23): [
    SolarEvent(
      date: DateTime(1946, 11, 23),
      title: 'Ngày thành lập Hội chữ thập đỏ Việt Nam',
      description:
          'Kỷ niệm ngày thành lập Hội Chữ thập đỏ Việt Nam, tổ chức nhân đạo quan trọng trong hệ thống chăm sóc sức khỏe và cứu trợ.',
      repeat: SolarRepeat.yearly(),
      mode: EventMode.readonly,
    ),
  ],
  DateTime(0, 12, 1): [
    SolarEvent(
      date: DateTime(1988, 12, 1),
      title: 'Ngày Thế giới phòng chống AIDS',
      description:
          'Nhấn mạnh tầm quan trọng của việc phòng chống và giáo dục về HIV/AIDS, cũng như hỗ trợ những người sống với HIV.',
      repeat: SolarRepeat.yearly(),
      mode: EventMode.readonly,
    ),
  ],
  DateTime(0, 12, 19): [
    SolarEvent(
      date: DateTime(1946, 12, 19),
      title: 'Ngày Toàn quốc kháng chiến',
      description:
          'Đánh dấu sự kiện khởi đầu cuộc kháng chiến chống lại quân xâm lược Pháp năm 1946, bắt đầu từ cuộc tấn công lớn của Pháp vào Hà Nội.',
      repeat: SolarRepeat.yearly(),
      mode: EventMode.readonly,
    ),
  ],
  DateTime(0, 12, 22): [
    SolarEvent(
      date: DateTime(1944, 12, 22),
      title: 'Ngày thành lập Quân đội nhân dân Việt Nam',
      description:
          'Tôn vinh và kỷ niệm ngày thành lập Quân đội nhân dân Việt Nam, ngày 22 tháng 12 năm 1944, ghi nhận sự hy sinh và công lao của lực lượng vũ trang.',
      repeat: SolarRepeat.yearly(),
      mode: EventMode.readonly,
    ),
  ],
  DateTime(0, 12, 25): [
    SolarEvent(
      date: DateTime(0, 12, 25),
      title: 'Ngày Lễ Giáng sinh',
      description:
          'Lễ kỷ niệm ngày sinh của Jesus Christ, được mọi người trên thế giới kỷ niệm với nhiều hoạt động vui vẻ và ý nghĩa.',
      repeat: SolarRepeat.yearly(),
      mode: EventMode.readonly,
    ),
  ],
});
