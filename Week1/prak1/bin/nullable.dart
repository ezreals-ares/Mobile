import 'dart:io';
void main(List<String> arguments) {

  // String? name;
  // name = null;
  // print(name);

  // int? a;
  // a = null;
  // print(a);

  print("Masukkan Nama Anda: ");
  String? nama = stdin.readLineSync();
  print('Nama anda adalah: ${nama == null || nama.isEmpty ? 'Tidak diketahui' : nama}');

}