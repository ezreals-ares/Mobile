import 'dart:io';
void main(List<String> arguments) {
  print("Masukkan Angka Pertama: ");
  String? input1 = stdin.readLineSync();
  print("Masukkan Angka Kedua: ");
  String? input2 = stdin.readLineSync();

  int num1 = int.parse(input1!);
  int num2 = int.parse(input2!);

 print ("Hasil Penjumlahan: ${num1 + num2}"); 

}