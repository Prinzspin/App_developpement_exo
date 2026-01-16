import 'package:dart_application_1/dart_application_1.dart' as dart_application_1;

void main(List<String> arguments) {
  List<int> numbers = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20];
  List<int?> numbers2 = [];
  List<int?> numbers_even = [];


 print(numbers);
  for (int i = 0; i < numbers.length; i++) {
    for (int j = i + 1; j < numbers.length; j++) {

      if (numbers[j] > numbers[i]) {
        int temp = numbers[i];
        numbers[i] = numbers[j];
        numbers[j] = temp;
      }
    }

  }
   print(numbers);
  numbers2 =numbers.map((numbers) => numbers * 2).toList(); 
  print(numbers2);

  numbers_even= numbers.where((numbers) => numbers % 2 == 0).toList();
  print(numbers_even );
  
}