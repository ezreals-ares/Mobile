void main(List<String> arguments) {
  // int i = 0;
  // while (i < 5) {
  //   print("Perulangan ke ${i + 1}");
  //   i++;  
  // }

  // do {
  //   print("Perulangan ke ${i + 1}");
  //   i++;
  // } while (i < 5);

  // for (i = 0; i < 5; i++) {
  //   print("Perulangan ke ${i + 1}");
  // }

  // for (;;) {
  //   if (i == 5) {
  //     break;
  //   }
  //   print("Perulangan");
  //   i++;
  // }

  for (int j = 1; j < 10; j++) {
    if (j %  2 == 0) {
      continue;
    }
    print(j); 
  }

  for (int j = 1; j < 10; j++) {
    if (j == 5) {
      break;
    }
    print(j); 
  } 

}