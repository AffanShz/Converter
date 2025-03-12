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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          'Base Converter',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
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
                    TextFormField(
                      controller: _controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.surface,
                        hintText: 'Enter a number',
                        labelText: 'Input',
                        prefixIcon: const Icon(Icons.input),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: _convertNumber,
                    ),
                    const SizedBox(height: 20),
                    isWideScreen
                        ? buildWideScreenDropdowns()
                        : buildCompactDropdowns(),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        _convertedValue ?? 'Converted number will appear here.',
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        _conversionExplanation,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface,
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
              explanation =
                  'No conversion needed. The input is already in Decimal.';
              break;
            case 'Binary':
              result = Decimal.toBinary(input);
              explanation =
                  'To convert Decimal to Binary, divide the number by 2 and record the remainders.';
              break;
            case 'Hexadecimal':
              result = Decimal.toHexadecimal(input);
              explanation =
                  'To convert Decimal to Hexadecimal, divide the number by 16 and record the remainders.';
              break;
            case 'Octal':
              result = Decimal.toOctal(input);
              explanation =
                  'To convert Decimal to Octal, divide the number by 8 and record the remainders.';
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
              explanation =
                  'To convert Binary to Decimal, multiply each bit by 2 raised to its position index and sum the results.';
              break;
            case 'Binary':
              result = input;
              explanation =
                  'No conversion needed. The input is already in Binary.';
              break;
            case 'Hexadecimal':
              result = Binary.toHexadecimal(input);
              explanation =
                  'To convert Binary to Hexadecimal, group the bits into sets of 4 and convert each group to its hexadecimal equivalent.';
              break;
            case 'Octal':
              result = Binary.toOctal(input);
              explanation =
                  'To convert Binary to Octal, group the bits into sets of 3 and convert each group to its octal equivalent.';
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
              explanation =
                  'To convert Octal to Decimal, multiply each digit by 8 raised to its position index and sum the results.';
              break;
            case 'Binary':
              result = Octal.toBinary(input);
              explanation =
                  'To convert Octal to Binary, convert each octal digit to its 3-bit binary equivalent.';
              break;
            case 'Octal':
              result = input;
              explanation =
                  'No conversion needed. The input is already in Octal.';
              break;
            case 'Hexadecimal':
              result = Octal.toHexadecimal(input);
              explanation =
                  'To convert Octal to Hexadecimal, first convert Octal to Binary, then group the bits into sets of 4 and convert each group to its hexadecimal equivalent.';
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
              explanation =
                  'To convert Hexadecimal to Decimal, multiply each digit by 16 raised to its position index and sum the results.';
              break;
            case 'Binary':
              result = Hexadecimal.toBinary(input);
              explanation =
                  'To convert Hexadecimal to Binary, convert each hexadecimal digit to its 4-bit binary equivalent.';
              break;
            case 'Octal':
              result = Hexadecimal.toOctal(input);
              explanation =
                  'To convert Hexadecimal to Octal, first convert Hexadecimal to Binary, then group the bits into sets of 3 and convert each group to its octal equivalent.';
              break;
            case 'Hexadecimal':
              result = input;
              explanation =
                  'No conversion needed. The input is already in Hexadecimal.';
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
