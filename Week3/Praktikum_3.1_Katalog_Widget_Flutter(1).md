# Slide 1

PRAKTIKUM PEMROGRAMAN MOBILE

Praktikum 3.1

Katalog Widget Flutter Berdasarkan Kelompok

FOKUS

Referensi & Pengenalan Widget

MODE

Materi + Eksplorasi Mandiri

TARGET

Mengenal 12 Kelompok Widget

Program Studi Teknik Informatika

---

# Slide 2

PENGANTAR

Apa itu Widget di Flutter?

Di Flutter, hampir semua elemen tampilan adalah widget — mulai dari teks, tombol, layout, hingga aplikasi itu sendiri. Widget disusun bertingkat membentuk widget tree, dan setiap perubahan state akan membangun ulang widget yang relevan.

StatelessWidget

Widget tanpa state internal. Tampilannya hanya bergantung pada konfigurasi dari parent.

StatefulWidget

Widget dengan objek State yang dapat berubah selama lifecycle aplikasi berjalan.

InheritedWidget

Widget yang membagikan data ke seluruh widget di bawahnya dalam tree secara efisien.

Pemrograman Mobile – Flutter  |  Praktikum 3.1: Katalog Widget Berdasarkan Kelompok

2

---

# Slide 3

PETA MATERI

12 Kelompok Widget yang Akan Dibahas

1

Layout

2

Struktural / App

3

Teks & Ikon

4

Tombol (Button)

5

Input & Form

6

Gambar & Media

7

List & Scrolling

8

Navigasi

9

Dialog & Feedback

10

Animasi

11

Async & State

12

Cupertino (iOS)

Pemrograman Mobile – Flutter  |  Praktikum 3.1: Katalog Widget Berdasarkan Kelompok

3

---

# Slide 4

KELOMPOK 1

Layout Widgets

Container

Menggabungkan ukuran, padding, margin, decoration, dan child.

Row

Menyusun widget secara horizontal.

Column

Menyusun widget secara vertikal.

Stack

Menumpuk widget di atas satu sama lain.

Expanded

Mengisi sisa ruang kosong dalam Row/Column.

Flexible

Mengatur proporsi ruang secara fleksibel.

Padding

Memberi jarak dalam (inset) pada child.

SizedBox

Memberi ukuran tetap atau jarak kosong.

Pemrograman Mobile – Flutter  |  Praktikum 3.1: Katalog Widget Berdasarkan Kelompok

4

---

# Slide 5

KELOMPOK 2

Struktural & App Widgets

MaterialApp

Root widget untuk aplikasi bertema Material Design.

Scaffold

Kerangka dasar halaman: AppBar, body, FAB, drawer.

AppBar

Bilah judul di bagian atas halaman.

SafeArea

Menghindari area sistem seperti notch/status bar.

Drawer

Panel navigasi geser dari sisi layar.

BottomSheet

Panel yang muncul dari bawah layar.

Center

Menempatkan child di tengah ruang tersedia.

Align

Menempatkan child pada posisi tertentu.

Pemrograman Mobile – Flutter  |  Praktikum 3.1: Katalog Widget Berdasarkan Kelompok

5

---

# Slide 6

KELOMPOK 3

Teks & Ikon Widgets

Text

Menampilkan teks dengan satu gaya (style).

RichText

Menampilkan teks dengan beberapa gaya berbeda.

Icon

Menampilkan ikon dari IconData bawaan atau custom.

ImageIcon

Menampilkan ikon dari sumber gambar.

TextStyle

Objek pengatur gaya (bukan widget, tapi elemen penting styling teks).

SelectableText

Teks yang dapat dipilih dan disalin pengguna.

Pemrograman Mobile – Flutter  |  Praktikum 3.1: Katalog Widget Berdasarkan Kelompok

6

---

# Slide 7

KELOMPOK 4

Tombol (Button) Widgets

ElevatedButton

Tombol dengan latar terisi & efek elevasi/bayangan.

TextButton

Tombol teks datar tanpa latar atau bayangan.

OutlinedButton

Tombol dengan garis tepi (border), latar transparan.

IconButton

Tombol berbentuk ikon, sering untuk aksi ringkas.

FloatingActionButton

Tombol bulat mengambang untuk aksi utama halaman.

DropdownButton

Tombol dengan menu pilihan turun ke bawah.

PopupMenuButton

Tombol yang menampilkan menu kontekstual.

ButtonBar

Menata sekumpulan tombol berjajar rapi.

Pemrograman Mobile – Flutter  |  Praktikum 3.1: Katalog Widget Berdasarkan Kelompok

7

---

# Slide 8

KELOMPOK 5

Input & Form Widgets

TextField

Input teks bebas dari pengguna.

TextFormField

TextField terintegrasi dengan validasi Form.

Checkbox

Kotak centang untuk pilihan ya/tidak.

Radio

Pilihan tunggal dari beberapa opsi.

Switch

Sakelar on/off bergaya Material.

Slider

Menggeser nilai dalam rentang tertentu.

Form

Wadah pengelompokan & validasi banyak field.

DatePicker/TimePicker

Dialog memilih tanggal atau waktu.

Pemrograman Mobile – Flutter  |  Praktikum 3.1: Katalog Widget Berdasarkan Kelompok

8

---

# Slide 9

KELOMPOK 6

Gambar & Media Widgets

Image

Menampilkan gambar dari asset, network, atau file.

CircleAvatar

Menampilkan gambar/inisial dalam bentuk lingkaran.

Card

Kontainer bergaya kartu dengan elevasi & sudut membulat.

ClipRRect

Memotong child dengan sudut membulat.

FadeInImage

Menampilkan gambar dengan efek transisi fade.

Hero

Animasi transisi gambar antar halaman.

Pemrograman Mobile – Flutter  |  Praktikum 3.1: Katalog Widget Berdasarkan Kelompok

9

---

# Slide 10

KELOMPOK 7

List & Scrolling Widgets

ListView

Daftar widget yang dapat digulir, satu arah.

GridView

Menyusun widget dalam bentuk grid (baris & kolom).

SingleChildScrollView

Membuat satu child besar dapat digulir.

PageView

Halaman yang dapat digeser secara horizontal/vertikal.

Wrap

Menyusun widget yang otomatis pindah baris jika penuh.

CustomScrollView

Menggabungkan berbagai efek scroll (sliver) custom.

ReorderableListView

Daftar yang urutannya bisa diubah drag & drop.

Scrollbar

Menampilkan indikator scroll pada area yang digulir.

Pemrograman Mobile – Flutter  |  Praktikum 3.1: Katalog Widget Berdasarkan Kelompok

10

---

# Slide 11

KELOMPOK 8

Navigasi Widgets

Navigator

Mengelola stack halaman (push & pop).

BottomNavigationBar

Navigasi antar halaman di bagian bawah layar.

TabBar & TabBarView

Navigasi antar tab dalam satu halaman.

Drawer

Panel navigasi geser dari sisi layar (lihat juga Kelompok 2).

NavigationRail

Navigasi sisi vertikal, cocok untuk layar lebar/tablet.

PageRouteBuilder

Membuat transisi perpindahan halaman custom.

Pemrograman Mobile – Flutter  |  Praktikum 3.1: Katalog Widget Berdasarkan Kelompok

11

---

# Slide 12

KELOMPOK 9

Dialog & Feedback Widgets

AlertDialog

Dialog konfirmasi atau peringatan di tengah layar.

SnackBar

Notifikasi singkat yang muncul di bagian bawah layar.

Tooltip

Keterangan singkat saat widget ditekan lama.

CircularProgressIndicator

Indikator loading berbentuk lingkaran.

LinearProgressIndicator

Indikator loading berbentuk garis.

showModalBottomSheet

Menampilkan panel modal dari bawah layar.

showDialog

Fungsi menampilkan dialog kustom di atas halaman.

Banner

Pita informasi/label di sudut widget.

Pemrograman Mobile – Flutter  |  Praktikum 3.1: Katalog Widget Berdasarkan Kelompok

12

---

# Slide 13

KELOMPOK 10

Animation Widgets

AnimatedContainer

Container yang otomatis animasi saat propertinya berubah.

AnimatedOpacity

Animasi transisi transparansi widget.

AnimatedSwitcher

Animasi transisi saat mengganti satu widget dengan lainnya.

Hero

Animasi elemen berpindah mulus antar halaman.

FadeTransition

Animasi transisi fade berbasis AnimationController.

ScaleTransition

Animasi transisi perubahan ukuran (scale).

Pemrograman Mobile – Flutter  |  Praktikum 3.1: Katalog Widget Berdasarkan Kelompok

13

---

# Slide 14

KELOMPOK 11

Async & State Widgets

StatelessWidget

Widget dasar tanpa state internal.

StatefulWidget

Widget dasar dengan state yang dapat berubah.

FutureBuilder

Membangun UI berdasarkan hasil sebuah Future.

StreamBuilder

Membangun UI berdasarkan aliran data (Stream).

InheritedWidget

Membagikan data ke banyak widget turunan secara efisien.

ValueListenableBuilder

Membangun ulang UI saat sebuah nilai berubah.

Pemrograman Mobile – Flutter  |  Praktikum 3.1: Katalog Widget Berdasarkan Kelompok

14

---

# Slide 15

KELOMPOK 12

Cupertino (iOS-style) Widgets

CupertinoApp

Root widget bertema iOS.

CupertinoButton

Tombol bergaya iOS.

CupertinoSwitch

Sakelar on/off bergaya iOS.

CupertinoNavigationBar

Bilah navigasi bergaya iOS.

CupertinoAlertDialog

Dialog peringatan bergaya iOS.

CupertinoPicker

Roda pemilih nilai bergaya iOS.

CupertinoTextField

Input teks bergaya iOS.

CupertinoActivityIndicator

Indikator loading bergaya iOS.

Pemrograman Mobile – Flutter  |  Praktikum 3.1: Katalog Widget Berdasarkan Kelompok

15

---

# Slide 16

RINGKASAN

Cheat Sheet: Kelompok & Widget Kunci

Layout

Container, Row, Column, Stack, Expanded

Struktural / App

MaterialApp, Scaffold, AppBar, SafeArea

Teks & Ikon

Text, RichText, Icon

Tombol

ElevatedButton, TextButton, IconButton, FAB

Input & Form

TextField, Checkbox, Switch, Slider, Form

Gambar & Media

Image, CircleAvatar, Card

List & Scrolling

ListView, GridView, PageView, Wrap

Navigasi

Navigator, BottomNavigationBar, TabBar

Dialog & Feedback

AlertDialog, SnackBar, ProgressIndicator

Animasi

AnimatedContainer, Hero, FadeTransition

Async & State

StatefulWidget, FutureBuilder, StreamBuilder

Cupertino

CupertinoButton, CupertinoSwitch, CupertinoAlertDialog

Pemrograman Mobile – Flutter  |  Praktikum 3.1: Katalog Widget Berdasarkan Kelompok

16

---

# Slide 17

LATIHAN MANDIRI

Latihan: Identifikasi Kelompok Widget

Tentukan kelompok yang tepat untuk setiap widget berikut, lalu jelaskan alasan singkatnya:

GridView

CupertinoSwitch

AnimatedOpacity

FutureBuilder

SnackBar

Expanded

TabBar

CircleAvatar

Tantangan Tambahan

Buat satu halaman Flutter sederhana yang menggunakan minimal satu widget dari lima kelompok berbeda, lalu jelaskan peran masing-masing widget saat presentasi singkat di depan kelas.

Pemrograman Mobile – Flutter  |  Praktikum 3.1: Katalog Widget Berdasarkan Kelompok

17

---

# Slide 18

LANJUT KE PERTEMUAN 4

Terima Kasih

Simpan katalog ini sebagai referensi cepat saat membangun UI — kenali kelompoknya, dan memilih widget yang tepat akan jauh lebih mudah.

Referensi lengkap: docs.flutter.dev/ui/widgets

---
