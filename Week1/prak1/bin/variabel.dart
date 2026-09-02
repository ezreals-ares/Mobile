late int a;
void main(List<String> arguments) {
  int a = 10;
  double b = 3.14;
  String c = "Hello, Dart!";
  bool d = true;

  print(a);
  print(b);
  print(c);
  print(d);

  String e = '12';
  int f = a + int.parse(e);
  print(f);
  List<String> buah = ['apel', 'jeruk', 'pisang'];
  print(buah);
  print("Buah yang ke 1 adalah ${buah[0]}");
  print("jumlah buah yang ada adalah ${buah.length}");
  Map<String, int> umur = {
    'Nawwaff': 21,
    'Ali': 22,
    'Budi': 23,
  };

  print("Umur Nawwaff adalah ${umur['Nawwaff']}");
  dynamic g = 'Hello';
  print(g);

}