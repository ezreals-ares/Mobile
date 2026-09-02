import 'dart:io';
void main(List<String> arguments) {

  print("Masukkan Nama Anda: ");
  String? nama = stdin.readLineSync();
  switch (nama) {
    case null:
    case '':
      print("Nama anda tidak diketahui");
      break;
    default:
      print("Nama anda adalah: $nama");
  }
}