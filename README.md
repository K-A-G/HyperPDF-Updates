# HyperPDF Reader

Phần mềm đọc, chú thích và chỉnh sửa PDF — nhẹ, nhanh, giao diện tối giản lấy
cảm hứng từ macOS kết hợp Windows 11 Fluent Design. Xây dựng bằng
**Python 3.12 + PySide6 (Qt6)**, render bằng **PyMuPDF (fitz)**, kiến trúc
**MVC** rõ ràng theo module.

![Light mode](docs/preview_light.png)
![Dark mode](docs/preview_dark.png)
![Xem 2 trang](docs/preview_two_page.png)

## Tính năng

- **Đa tab**: mở nhiều tệp PDF cùng lúc, mỗi tab một tài liệu độc lập.
- **Điều hướng**: nút trang trước/sau, nhập số trang, thanh phân trang nổi.
- **Zoom**: phóng to/thu nhỏ (nút +/-, `Ctrl+ +`/`Ctrl+ -`, hoặc `Ctrl + lăn chuột`), mức zoom định sẵn, Vừa chiều rộng, Vừa trang.
- **Xem 2 trang song song** (menu Khác ▸ Xem 2 trang): hiển thị trang hiện
  tại kèm trang kế bên; điều hướng tự nhảy theo cặp trang.
- **Mục lục & Dấu trang**: hiển thị outline gốc của PDF + cho phép đánh dấu
  trang của riêng bạn (khác với outline, có thể thêm/xoá).
- **Thumbnail**: ảnh thu nhỏ từng trang, render nền không chặn giao diện.
- **Tìm kiếm toàn văn bản**: chạy nền, điều hướng kết quả trước/sau (F3).
- **Chọn văn bản** theo từ, sao chép (Ctrl+C).
- **Rail Công cụ** (góc phải): toàn bộ công cụ bên dưới chỉ hiện icon (không
  chữ, hover để xem tên), icon to hơn, dễ bấm hơn. Ẩn/hiện bất kỳ lúc nào
  bằng nút cố định ở góc phải toolbar hoặc `Ctrl+Shift+T` — nút này luôn ở
  đó kể cả khi rail đang ẩn, giống cách Claude ẩn/hiện sidebar.
- **Chú thích**: Highlight, Underline, Strikeout (áp dụng trên văn bản đã
  chọn), Vẽ tay (Ink), Ghi chú (sticky note), Chèn hình ảnh.
- **Hộp văn bản** ("Thêm văn bản"): kéo khung ngay trên trang, gõ chữ trực
  tiếp với thanh định dạng nổi (Font, **B** *I* U, màu chữ RGB, căn
  trái/giữa/phải — bấm ra ngoài hoặc `Esc` để lưu/huỷ). Dùng công cụ
  "Di chuyển / Sửa văn bản" để kéo đổi vị trí hộp đã thêm, hoặc double-click
  để mở lại sửa chữ. Chuột phải trên văn bản đã chọn (trong trang hoặc
  trong hộp đang gõ) để Sao chép/Cut/Copy/Paste.
  ⚠️ Giới hạn thật của định dạng PDF (không phải thiếu sót có thể sửa
  sau): chỉ 3 font khả dụng (Sans-serif/Serif/Monospace — không phải font
  hệ thống tuỳ ý như Aptos/Arial), và chỉ căn Trái/Giữa/Phải (không có
  Justify thật). Hộp ảnh hiện KHÔNG di chuyển lại được sau khi đã chèn
  xong (dùng Undo rồi chèn lại nếu đặt sai vị trí) — chỉ hộp văn bản mới
  hỗ trợ di chuyển/sửa lại, vì PDF lưu văn bản dạng annotation lưu vết
  được, còn ảnh chèn thẳng vào nội dung trang.
- **Chụp vào Clipboard**: kéo chuột vẽ khung vuông/chữ nhật trên trang. Khung
  ở lại màn hình sau khi thả chuột (đổi từ nét đứt sang màu xanh nét liền),
  kèm 8 tay cầm ở góc/cạnh để kéo vào/ra chỉnh lại kích thước, hoặc kéo giữa
  khung để di chuyển — mỗi lần chỉnh xong ảnh mới tự động thay thế ảnh cũ
  trong Clipboard. Nhấn Esc hoặc bấm ra ngoài để bỏ khung. Không đụng vào
  file PDF (không tạo annotation, không đổi dấu "chưa lưu").
- **Tẩy xoá nội dung**: cùng kiểu khung chọn co giãn như Chụp vào Clipboard
  (kéo, rồi chỉnh cạnh/góc/di chuyển), nhưng nhấn **Enter mới thực sự xoá**
  (Esc để huỷ) vì đây là thao tác xoá vĩnh viễn nội dung trong vùng chọn —
  hoạt động đúng cho cả trang scan (xoá đúng phần ảnh trong vùng chọn, phần
  còn lại của ảnh giữ nguyên) và trang có chữ vector thật (xoá hẳn đối
  tượng chữ, không phải vẽ đè hình trắng lên trên — không còn tìm/copy được
  nữa). Có Undo (Ctrl+Z) như mọi chỉnh sửa khác.
- **Chỉnh sửa trang**: xoay trang (lưu vĩnh viễn), xoá trang.
- **Undo / Redo** (Ctrl+Z / Ctrl+Shift+Z hoặc Ctrl+Y) cho mọi thao tác chỉnh
  sửa trang (annotation, vẽ, xoay, xoá trang) — giới hạn 50 bước, riêng cho
  từng tab.
- **Mở PDF có mật khẩu**: tự động hỏi mật khẩu, cho thử lại nếu nhập sai.
- **Ký số tài liệu** (nút "Ký số" trên top bar): ký PAdES/CMS bằng USB
  Token/thẻ thông minh (PKCS#11), tệp chứng thư .pfx/.p12 (PKCS#12), hoặc
  chứng thư có sẵn trong **Windows Certificate Store (CNG/CryptoAPI)** —
  chọn qua dialog gốc của Windows, không cần biết đường dẫn driver. Chọn
  được định dạng chữ ký PAdES/CAdES (mặc định) hoặc **PKCS#7/CMS** cổ điển
  cho hệ thống thẩm định cũ. Kèm dấu thời gian RFC 3161 tuỳ chọn. Hình
  thức chữ ký hiển thị kiểu VNPT-CA (biểu tượng + Ký bởi/Thời gian/Mã số
  bởi... Signature), vị trí kéo-thả trực tiếp trên xem trước trang. Mọi
  chữ ký được XÁC MINH LẠI tự động ngay sau khi ký, trước khi báo thành
  công. Xem `app/core/signing_engine.py` và mục 0 trong
  `PROJECT_PROGRESS.md` để biết chi tiết kiến trúc.
  > ⚠️ **Phần CNG/CryptoAPI (`app/core/cng_signer.py`) được viết cẩn thận
  > dựa trên tài liệu Microsoft nhưng CHƯA được chạy thử trên Windows thật**
  > (môi trường phát triển là Linux, không có Windows). Hãy tự kiểm tra
  > trên máy Windows thật trước khi dùng cho việc quan trọng — xem mục 0
  > trong `PROJECT_PROGRESS.md` để biết chi tiết và cách báo lỗi hiệu quả
  > nếu gặp sự cố.
- **Đặt mật khẩu / mã hoá PDF** (nút "Đặt mật khẩu" trên top bar, icon
  khoá): mã hoá AES-256, tuỳ chọn độc lập giữa "Yêu cầu mật khẩu khi mở"
  và "Hạn chế chỉnh sửa" (In / Sao chép văn bản / Điền biểu mẫu / Chú
  thích). Xuất ra file mới (không ghi đè), mở lại như tab mới để xác nhận
  ngay mật khẩu hoạt động đúng.
- **In tài liệu** (QPrinter) và **Xuất/Lưu file** (Save / Save As).
- **Xuất ra Word (.docx)** (menu Tệp ▸ Xuất ra Word...): chuyển PDF sang
  .docx hỗ trợ tiếng Việt Unicode đầy đủ (không lỗi dấu), 2 chế độ —
  **Có thể chỉnh sửa** (đoạn văn chảy tự nhiên, dễ định dạng lại) hoặc
  **Giữ nguyên bố cục** (vị trí chữ/bảng/ảnh gần đúng như PDF gốc trên
  từng trang). Tự nhận diện đoạn văn, bảng, hình ảnh, header/footer lặp
  lại (kèm số trang tự động cập nhật); tự dò font PDF và chuyển sang font
  Windows tương thích, kiểm tra thật khả năng hiển thị tiếng Việt của
  font trước khi dùng, tự thay bằng Arial/Noto Sans/font dự phòng khi
  cần. Có thanh tiến trình + nút Huỷ khi đang xuất, báo lỗi/cảnh báo rõ
  ràng (font thiếu, ký tự lạ, trang có thể là bản scan...). Xem
  `PROJECT_PROGRESS.md` mục "Giai đoạn 16" để biết chi tiết kiến trúc.
- **Light / Dark Mode** với bộ icon SVG nét mảnh tự đổi màu theo theme.
- **Đa ngôn ngữ (Tiếng Việt / English)**: đổi ngôn ngữ giao diện ngay lập
  tức trong hộp thoại Cài đặt (không cần khởi động lại), lựa chọn được ghi
  nhớ cho lần mở sau. Xem `app/i18n/` để biết cách thêm chuỗi mới.
- **Toàn màn hình** (F11), hỗ trợ kéo-thả file PDF vào cửa sổ.
- Tối ưu **HiDPI** (Retina/4K) và render bất đồng bộ cho thumbnail/tìm kiếm.

## Cài đặt

```bash
python3 -m venv .venv
source .venv/bin/activate        # Windows: .venv\Scripts\activate
pip install -r requirements.txt
```

> Ghi chú cho tính năng **Ký số**: ký qua USB Token (PKCS#11) cần driver
> cryptoki (.dll/.so) do nhà cung cấp token/CA cấp riêng — không đi kèm gói
> `pip` này. Ký qua tệp .pfx/.p12 và dấu thời gian RFC 3161 không cần cài gì
> thêm.

## Chạy ứng dụng

```bash
python3 main.py                  # mở ứng dụng trống
python3 main.py duong_dan/tai_lieu.pdf   # mở kèm một tệp PDF
```

## Phím tắt chính

| Thao tác            | Phím tắt        |
|---------------------|-----------------|
| Mở file             | `Ctrl+O`        |
| Lưu / Lưu thành      | `Ctrl+S` / `Ctrl+Shift+S` |
| In                  | `Ctrl+P`        |
| Hoàn tác / Làm lại   | `Ctrl+Z` / `Ctrl+Shift+Z` (hoặc `Ctrl+Y`) |
| Tìm kiếm            | `Ctrl+F`        |
| Kết quả sau/trước    | `F3` / `Shift+F3` |
| Phóng to / Thu nhỏ   | `Ctrl+ +` / `Ctrl+ -` hoặc `Ctrl + lăn chuột` |
| Trang sau / trước    | `PgDown` / `PgUp` |
| Toàn màn hình        | `F11`           |
| Xoay trang           | `Ctrl+R`        |
| Ẩn/hiện panel trái   | `Ctrl+B`        |
| Ẩn/hiện panel phải (Công cụ) | `Ctrl+Shift+T` hoặc nút góc phải toolbar |
| Chuyển Light/Dark    | `Ctrl+Shift+D`  |
| Đóng tab            | `Ctrl+W`        |

## Cấu trúc dự án

Xem **PROJECT_PROGRESS.md** để biết chi tiết kiến trúc, sơ đồ module, quyết
định thiết kế và các bước tiếp theo — tài liệu này được cập nhật sau mỗi giai
đoạn phát triển để có thể tiếp tục lập trình mà không cần đọc lại toàn bộ mã
nguồn.

```
app/
  core/         # PDFEngine (PyMuPDF), cache, background workers
  i18n/         # tr(), LanguageManager, từ điển dịch Việt/English
  models/       # DocumentModel, RecentFilesModel (tầng Model)
  views/        # Toàn bộ widget giao diện (tầng View)
  controllers/  # AppController, DocumentController (tầng Controller)
  theming/      # Bảng màu Light/Dark, icon provider, QSS
  resources/    # Icon SVG
  utils/        # Helper, shortcuts, logger
tests/          # Script tạo PDF mẫu + các bài kiểm thử tự động
main.py         # Điểm khởi chạy
```

## Kiểm thử

```bash
python3 tests/make_sample_pdf.py     # sinh tests/sample.pdf (20 trang, có TOC)
python3 tests/functional_test.py     # test chức năng (điều hướng, annot, search, tab...)
python3 tests/edge_case_test.py      # test trường hợp biên (file lỗi, mật khẩu...)
python3 tests/phase2_test.py         # test Undo/Redo, xem 2 trang, mở PDF có mật khẩu
python3 tests/wheel_zoom_test.py     # test Ctrl+lăn chuột để zoom (2 chiều, giới hạn min/max, xem 2 trang)
python3 tests/tools_rail_test.py     # test rail Công cụ icon-only + nút ẩn/hiện trên toolbar
python3 tests/textbox_editor_test.py # test hộp văn bản rich-text + Move tool + menu chuột phải
python3 tests/i18n_smoke_test.py     # chụp ảnh giao diện Việt/English để kiểm tra đa ngôn ngữ
python3 tests/digital_signature_test.py  # test Ký số: PKCS#11 (qua SoftHSM2 nếu có cài), PKCS#12, hình con dấu, toạ độ đặt chữ ký theo góc xoay trang
python3 tests/capture_test.py        # test công cụ Chụp vào Clipboard (kéo, resize, move, zoom, dismiss)
python3 tests/erase_test.py          # test công cụ Tẩy xoá: kéo/resize/Enter-xoá/Esc-huỷ, trên cả trang chữ vector lẫn trang scan tổng hợp, undo/redo
python3 tests/password_protect_test.py  # test Đặt mật khẩu: cả 3 kịch bản (mở/hạn chế/cả hai) xác nhận qua fitz.open() thật, gồm 1 test [SECURITY] riêng
python3 tests/capture_visual_check.py       # chụp ảnh panel + khung đang kéo
python3 tests/capture_resize_visual_check.py  # chụp ảnh khung sau khi resize + đổi zoom
python3 tests/make_docx_sample_pdf.py    # sinh tests/sample_docx_source.pdf (6 trang: bảng, ảnh, header/footer, trang dạng scan)
python3 tests/docx_export_test.py        # test Xuất ra Word: Unicode tiếng Việt, font mapping, paragraph, bảng, ảnh, layout 2 chế độ, OCR interface, lỗi/huỷ/mật khẩu
```

## Yêu cầu hệ thống

- Python 3.10+ (khuyến nghị 3.12)
- Windows 10/11, macOS 12+, hoặc Linux có môi trường đồ hoạ (X11/Wayland)

## Export to Excel

See `docs/EXPORT_EXCEL.md` for PDF table/text extraction to `.xlsx` workbooks.


## EPUB Reader

HyperPDF can also open reflowable EPUB 2/3 books. Use **File → Open EPUB Book** or choose an `.epub` file in **File → Open File**. See [docs/EPUB_READER.md](docs/EPUB_READER.md) for supported features and compatibility notes.


### Windows File Explorer PDF Preview

See [`docs/EXPLORER_PDF_PREVIEW.md`](docs/EXPLORER_PDF_PREVIEW.md) for building and enabling the HyperPDF Preview Pane handler on Windows 10/11 x64.


## Build note: PyMuPDF / MSVC C1002

The one-command Windows build excludes `pymupdf.mupdf` from Nuitka C compilation
(`--nofollow-import-to=pymupdf`) and copies the installed PyMuPDF package,
including its prebuilt native extension, into the standalone distribution. This
avoids asking MSVC to compile the very large generated MuPDF wrapper. The final
standalone application must still be tested on a clean Windows 11 x64 machine.
