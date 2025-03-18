import 'package:flutter/material.dart';

import 'package:converter/models/binary.dart';
import 'package:converter/models/decimal.dart';
import 'package:converter/models/hexadecimal.dart';
import 'package:converter/models/octal.dart';

class ConverterWidget extends StatefulWidget {
  const ConverterWidget({super.key});

  @override
  State<ConverterWidget> createState() => _ConverterWidgetState();
}

class _ConverterWidgetState extends State<ConverterWidget> {
  List<String> list = const <String>[
    'Decimal',
    'Binary',
    'Hexadecimal',
    'Octal',
  ];
  String dropdownValueFrom = "Decimal";
  String dropdownValueTo = "Binary";

  final TextEditingController _controller = TextEditingController();
  String? _convertedValue;
  String _conversionExplanation = '';
  bool _isNumericKeyboard = true;

//Decimal to Binary
  String decimalToBinaryWithExplanation(int decimal) {
    if (decimal == 0) return "0";

    StringBuffer binary = StringBuffer();
    StringBuffer explanation =
        StringBuffer("Proses konversi $decimal ke biner:\n");

    while (decimal > 0) {
      int remainder = decimal % 2;
      binary.write(remainder);
      explanation.write("$decimal / 2 = ${decimal ~/ 2} sisa $remainder\n");
      decimal = decimal ~/ 2;
    }

    String binaryResult = binary.toString().split('').reversed.join('');
    explanation.write("Hasil akhirnya: $binaryResult\n");
    return explanation.toString();
  }

//Decimal to Octal
  String decimalToOctalWithExplanation(int decimal) {
    if (decimal == 0) return "0";

    StringBuffer octal = StringBuffer();
    StringBuffer explanation =
        StringBuffer("Proses konversi $decimal ke oktal:\n");

    while (decimal > 0) {
      int remainder = decimal % 8;
      octal.write(remainder);
      explanation.write("$decimal / 8 = ${decimal ~/ 8} sisa $remainder\n");
      decimal = decimal ~/ 8;
    }

    String octalResult = octal.toString().split('').reversed.join('');
    explanation.write("Hasil akhirnya: $octalResult\n");
    return explanation.toString();
  }

//Decimal to Hexadecimal
  String decimalToHexWithExplanation(int decimal) {
    if (decimal == 0) return "0";

    const String hexChars = "0123456789ABCDEF";
    StringBuffer hex = StringBuffer();
    StringBuffer explanation =
        StringBuffer("Proses konversi $decimal ke heksadesimal:\n");

    while (decimal > 0) {
      int remainder = decimal % 16;
      hex.write(hexChars[remainder]);
      explanation.write(
          "$decimal / 16 = ${decimal ~/ 16} sisa ${hexChars[remainder]}\n");
      decimal = decimal ~/ 16;
    }

    String hexResult = hex.toString().split('').reversed.join('');
    explanation.write("Hasil akhirnya: $hexResult\n");
    return explanation.toString();
  }

//Binary to Decimal
  String binaryToDecimalWithExplanation(String binary) {
    int decimal = 0;
    StringBuffer explanation =
        StringBuffer("Proses konversi $binary ke desimal:\n");

    for (int i = 0; i < binary.length; i++) {
      int bit = int.parse(binary[binary.length - 1 - i]);
      decimal += bit * (1 << i);
      explanation.write("$bit × 2^$i = ${bit * (1 << i)}\n");
    }

    explanation.write("Hasil akhirnya: $decimal\n");
    return explanation.toString();
  }

//Binary to Hexadecimal
  String binaryToHexadecimalWithExplanation(String binary) {
    StringBuffer explanation =
        StringBuffer("Proses konversi $binary (biner) ke heksadesimal:\n");

    explanation
        .write("1. Kelompokkan biner menjadi 4-bit (dari kanan ke kiri):\n");

    //menambahkan 0 jika panjang biner kurang dari
    int paddingLength = (4 - (binary.length % 4)) % 4;
    binary = binary.padLeft(binary.length + paddingLength, '0');
    explanation.write(
        "   Menambahkan 0 di depan jika panjang kurang dari 4\n   Biner setelah padding: $binary\n");

    explanation.write("2. Konversi setiap kelompok 4-bit ke heksadesimal:\n");
    StringBuffer hexadecimal = StringBuffer();
    for (int i = 0; i < binary.length; i += 4) {
      String binaryGroup = binary.substring(i, i + 4);
      int decimalValue = int.parse(binaryGroup, radix: 2);
      String hexDigit = decimalValue.toRadixString(16).toUpperCase();
      hexadecimal.write(hexDigit);
      explanation.write("   $binaryGroup (biner) = $hexDigit (heksadesimal)\n");
    }
    String hexadecimalResult = hexadecimal.toString();
    explanation.write("   Hasil akhir (heksadesimal): $hexadecimalResult\n");

    return explanation.toString();
  }

//Binary to Octal
  String binaryToOctalWithExplanation(String binary) {
    StringBuffer explanation =
        StringBuffer("Proses konversi $binary (biner) ke oktal:\n");

    explanation
        .write("1. Kelompokkan biner menjadi 3-bit (dari kanan ke kiri):\n");

    int paddingLength = (3 - (binary.length % 3)) % 3;
    binary = binary.padLeft(binary.length + paddingLength, '0');
    explanation.write(
        "   Menambahkan 0 di depan jika panjang kurang dari 3\n   Biner setelah padding: $binary\n");

    explanation.write("2. Konversi setiap kelompok 3-bit ke oktal:\n");
    StringBuffer octal = StringBuffer();
    for (int i = 0; i < binary.length; i += 3) {
      String binaryGroup = binary.substring(i, i + 3);
      int decimalValue = int.parse(binaryGroup, radix: 2);
      String octalDigit = decimalValue.toRadixString(8);
      octal.write(octalDigit);
      explanation.write("   $binaryGroup (biner) = $octalDigit (oktal)\n");
    }
    String octalResult = octal.toString();
    explanation.write("   Hasil akhir (oktal): $octalResult\n");

    return explanation.toString();
  }

//Hexadecimal to Decimal
  String hexadecimalToDecimalWithExplanation(String hex) {
    const String hexChars = "0123456789ABCDEF";
    int decimal = 0;
    StringBuffer explanation =
        StringBuffer("Proses konversi $hex ke desimal:\n");

    for (int i = 0; i < hex.length; i++) {
      int value = hexChars.indexOf(hex[hex.length - 1 - i].toUpperCase());
      decimal += value * (1 << (4 * i));
      explanation.write("$value × 16^$i = ${value * (1 << (4 * i))}\n");
    }

    explanation.write("Hasil akhirnya: $decimal\n");
    return explanation.toString();
  }

//Hexadecimal to Binary
  String hexadecimalToBinaryWithExplanation(String hexadecimal) {
    StringBuffer explanation =
        StringBuffer("Proses konversi $hexadecimal (heksadesimal) ke biner:\n");

    explanation
        .write("1. Konversi setiap digit heksadesimal ke biner (4-bit):\n");
    StringBuffer binary = StringBuffer();
    for (int i = 0; i < hexadecimal.length; i++) {
      String hexDigit = hexadecimal[i];
      int decimalValue = int.parse(hexDigit, radix: 16);
      String binaryDigit =
          decimalValue.toRadixString(2).padLeft(4, '0'); // Pastikan 4-bit
      binary.write(binaryDigit);
      explanation.write("   $hexDigit (heksadesimal) = $binaryDigit (biner)\n");
    }
    String binaryResult = binary.toString();
    explanation.write("   Hasil akhir (biner): $binaryResult\n");

    return explanation.toString();
  }

//Hexadecimal to Octal
  String hexadecimalToOctalWithExplanation(String hexadecimal) {
    StringBuffer explanation =
        StringBuffer("Proses konversi $hexadecimal (heksadesimal) ke oktal:\n");

    // 1. Konversi setiap digit heksadesimal ke biner (4-bit)
    explanation
        .write("1. Konversi setiap digit heksadesimal ke biner (4-bit):\n");
    StringBuffer binary = StringBuffer();
    for (int i = 0; i < hexadecimal.length; i++) {
      String hexDigit = hexadecimal[i];
      int decimalValue = int.parse(hexDigit, radix: 16);
      String binaryDigit =
          decimalValue.toRadixString(2).padLeft(4, '0'); // Pastikan 4-bit
      binary.write(binaryDigit);
      explanation.write("   $hexDigit (heksadesimal) = $binaryDigit (biner)\n");
    }
    String binaryResult = binary.toString();
    explanation.write("   Hasil sementara (biner): $binaryResult\n\n");

    // 2. Kelompokkan biner menjadi 3-bit (dari kanan ke kiri)
    explanation
        .write("2. Kelompokkan biner menjadi 3-bit (dari kanan ke kiri):\n");
    // Tambahkan leading zeros jika panjang biner tidak kelipatan 3
    int paddingLength = (3 - (binaryResult.length % 3)) % 3;
    binaryResult =
        binaryResult.padLeft(binaryResult.length + paddingLength, '0');
    explanation.write("   Biner setelah padding: $binaryResult\n");

    // 3. Konversi setiap kelompok 3-bit ke oktal
    explanation.write("3. Konversi setiap kelompok 3-bit ke oktal:\n");
    StringBuffer octal = StringBuffer();
    for (int i = 0; i < binaryResult.length; i += 3) {
      String binaryGroup = binaryResult.substring(i, i + 3);
      int decimalValue = int.parse(binaryGroup, radix: 2);
      String octalDigit = decimalValue.toRadixString(8);
      octal.write(octalDigit);
      explanation.write("   $binaryGroup (biner) = $octalDigit (oktal)\n");
    }
    String octalResult = octal.toString();
    explanation.write("   Hasil akhir (oktal): $octalResult\n");

    return explanation.toString();
  }

//Octal to Decimal
  String octalToDecimalWithExplanation(String octal) {
    int decimal = 0;
    StringBuffer explanation = StringBuffer(
        "Proses konversi $octal ke desimal:\n Dimulai digit paling kanan dikalikan 8^n \n");

    for (int i = 0; i < octal.length; i++) {
      int digit = int.parse(octal[octal.length - 1 - i]);
      decimal += digit * (1 << (3 * i));
      explanation.write("$digit × 8^$i = ${digit * (1 << (3 * i))}\n");
    }

    explanation.write("Hasil akhirnya: $decimal\n");
    return explanation.toString();
  }

//Octal to binary
  String octalToBinaryWithExplanation(String octal) {
    StringBuffer explanation =
        StringBuffer("Proses konversi $octal (oktal) ke biner:\n");

    explanation.write("1. Konversi setiap digit oktal ke biner (3-bit):\n");
    StringBuffer binary = StringBuffer();
    for (int i = 0; i < octal.length; i++) {
      String octalDigit = octal[i];
      int decimalValue = int.parse(octalDigit, radix: 8);
      String binaryDigit =
          decimalValue.toRadixString(2).padLeft(3, '0'); // Pastikan 3-bit
      binary.write(binaryDigit);
      explanation.write("   $octalDigit (oktal) = $binaryDigit (biner)\n");
    }
    String binaryResult = binary.toString();
    explanation.write("   Hasil akhir (biner): $binaryResult\n");

    return explanation.toString();
  }

//Ocatal to Hexadecimal
  String octalToHexadecimalWithExplanation(String octal) {
    int decimal = 0;
    StringBuffer explanation =
        StringBuffer("Proses konversi $octal ke heksadesimal:\n");
    explanation.write("1. Konversi oktal ke desimal:\n");

    for (int i = 0; i < octal.length; i++) {
      int digit = int.parse(octal[octal.length - 1 - i]);
      decimal += digit * (1 << (3 * i)); // 1 << 3 = 8, 1 << 6 = 64, dst.
      explanation.write("   $digit × 8^$i = ${digit * (1 << (3 * i))}\n");
    }
    explanation.write("   Hasil sementara (desimal): $decimal\n\n");

    StringBuffer hexadecimal = StringBuffer();
    explanation.write(
        "2. Konversi desimal ke heksadesimal:\n $decimal di Modulo dengan 16\n");
    int tempDecimal = decimal;
    while (tempDecimal > 0) {
      int remainder = tempDecimal % 16;
      String hexDigit = remainder < 10
          ? remainder.toString()
          : String.fromCharCode(65 + (remainder - 10));
      hexadecimal.write(hexDigit);
      explanation.write(
          "   $tempDecimal ÷ 16 = ${tempDecimal ~/ 16} sisa $remainder ($hexDigit)\n");
      tempDecimal = tempDecimal ~/ 16;
    }

    String hexadecimalResult =
        hexadecimal.toString().split('').reversed.join('');
    explanation.write("   Hasil akhir (heksadesimal): $hexadecimalResult\n");

    return explanation.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(
          'Converter App',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
        ),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isWideScreen = constraints.maxWidth > 600;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _controller,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              filled: true,
                              fillColor: Colors.grey[200],
                              hintText: 'Enter a number',
                              labelText: 'Input',
                              prefixIcon: const Icon(Icons.input),
                            ),
                            keyboardType: _isNumericKeyboard
                                ? TextInputType.number
                                : TextInputType.text,
                            onChanged: _convertNumber,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                              _isNumericKeyboard
                                  ? Icons.keyboard
                                  : Icons.numbers,
                              color: Colors.blueAccent),
                          onPressed: () {
                            setState(() {
                              _isNumericKeyboard = !_isNumericKeyboard;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    isWideScreen
                        ? buildWideScreenDropdowns()
                        : buildCompactDropdowns(),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        border: Border.all(
                          color: Colors.blueAccent,
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Text(
                        _convertedValue ?? 'Converted number will appear here.',
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold,
                                ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.red[50],
                        border: Border.all(
                          color: Colors.redAccent,
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Text(
                        _conversionExplanation,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.black,
                              fontStyle: FontStyle.italic,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildWideScreenDropdowns() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Convert From:',
                  style: Theme.of(context).textTheme.bodyMedium),
              DropdownButton<String>(
                value: dropdownValueFrom,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
                underline: Container(
                  height: 2,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onChanged: (String? value) {
                  setState(() {
                    dropdownValueFrom = value!;
                    _convertNumber(_controller.text);
                  });
                },
                items: list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Convert To:',
                  style: Theme.of(context).textTheme.bodyMedium),
              DropdownButton<String>(
                value: dropdownValueTo,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
                underline: Container(
                  height: 2,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onChanged: (String? value) {
                  setState(() {
                    dropdownValueTo = value!;
                    _convertNumber(_controller.text);
                  });
                },
                items: list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildCompactDropdowns() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Convert From:', style: Theme.of(context).textTheme.bodyMedium),
        DropdownButton<String>(
          value: dropdownValueFrom,
          icon: const Icon(Icons.arrow_downward),
          elevation: 16,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
          underline: Container(
            height: 2,
            color: Theme.of(context).colorScheme.primary,
          ),
          onChanged: (String? value) {
            setState(() {
              dropdownValueFrom = value!;
              _convertNumber(_controller.text);
            });
          },
          items: list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
        Text('Convert To:', style: Theme.of(context).textTheme.bodyMedium),
        DropdownButton<String>(
          value: dropdownValueTo,
          icon: const Icon(Icons.arrow_downward),
          elevation: 16,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
          underline: Container(
            height: 2,
            color: Theme.of(context).colorScheme.primary,
          ),
          onChanged: (String? value) {
            setState(() {
              dropdownValueTo = value!;
              _convertNumber(_controller.text);
            });
          },
          items: list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }

  void _convertNumber(String input) {
    if (input.isEmpty) {
      setState(() {
        _convertedValue = 'Enter a valid number';
        _conversionExplanation = '';
      });
      return;
    }

    String result;
    String explanation = '';
    try {
      switch (dropdownValueFrom) {
        case 'Decimal':
          switch (dropdownValueTo) {
            case 'Decimal':
              result = input;
              explanation = '-';
              break;
            case 'Binary':
              result = Decimal.toBinary(input);
              explanation = decimalToBinaryWithExplanation(int.parse(input));
              break;
            case 'Hexadecimal':
              result = Decimal.toHexadecimal(input);
              explanation = decimalToHexWithExplanation(int.parse(input));
              break;
            case 'Octal':
              result = Decimal.toOctal(input);
              explanation = decimalToOctalWithExplanation(int.parse(input));
              break;
            default:
              result = 'Unknown conversion';
              explanation = 'Conversion not supported.';
          }
          break;
        case 'Binary':
          switch (dropdownValueTo) {
            case 'Decimal':
              result = Binary.toDecimal(input);
              explanation = binaryToDecimalWithExplanation(input);
              break;
            case 'Binary':
              result = input;
              explanation = '-';
              break;
            case 'Hexadecimal':
              result = Binary.toHexadecimal(input);
              explanation = binaryToHexadecimalWithExplanation(input);
              break;
            case 'Octal':
              result = Binary.toOctal(input);
              explanation = binaryToOctalWithExplanation(input);
              break;
            default:
              result = 'Unknown conversion';
              explanation = 'Conversion not supported.';
          }
          break;
        case 'Octal':
          switch (dropdownValueTo) {
            case 'Decimal':
              result = Octal.toDecimal(input);
              explanation = octalToDecimalWithExplanation(input);
              break;
            case 'Binary':
              result = Octal.toBinary(input);
              explanation = octalToBinaryWithExplanation(input);
              break;
            case 'Octal':
              result = input;
              explanation = '-';
              break;
            case 'Hexadecimal':
              result = Octal.toHexadecimal(input);
              explanation = octalToHexadecimalWithExplanation(input);
              break;
            default:
              result = 'Unknown conversion';
              explanation = 'Conversion not supported.';
          }
          break;
        case 'Hexadecimal':
          switch (dropdownValueTo) {
            case 'Decimal':
              result = Hexadecimal.toDecimal(input);
              explanation = hexadecimalToDecimalWithExplanation(input);
              break;
            case 'Binary':
              result = Hexadecimal.toBinary(input);
              explanation = hexadecimalToBinaryWithExplanation(input);
              break;
            case 'Octal':
              result = Hexadecimal.toOctal(input);
              explanation = hexadecimalToOctalWithExplanation(input);
              break;
            case 'Hexadecimal':
              result = input;
              explanation = '-';
              break;
            default:
              result = 'Unknown conversion';
              explanation = 'Conversion not supported.';
          }
          break;
        default:
          result = 'Unknown conversion';
          explanation = 'Conversion not supported.';
      }
    } catch (e) {
      result = 'Invalid input';
      explanation = 'Please enter a valid number for the selected conversion.';
    }

    setState(() {
      _convertedValue = result;
      _conversionExplanation = explanation;
    });
  }
}
