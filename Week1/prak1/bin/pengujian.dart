import 'dart:io';
void main(List<String> arguments) {
  print("Masukkan nama anda: ");
  String? nama = stdin.readLineSync();
  if (nama != null && nama.isNotEmpty) {
    print("Nama anda adalah: $nama");
  } else {
    print("Nama anda tidak diketahui");
  }
  String status = (nama != null && nama.isNotEmpty) ? "Nama anda adalah: $nama" : "Nama anda tidak diketahui";
  print("Nama anda adalah: $status");
}