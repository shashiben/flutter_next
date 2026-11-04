import 'package:dev_utils/dev_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('getFileSize uses 1000-based units', () {
    expect(FileUtils.getFileSize(0), '0 B');
    expect(FileUtils.getFileSize(999), '999 B');
    expect(FileUtils.getFileSize(1000), '1.00 KB');
    expect(FileUtils.getFileSize(1000000, 0), '1 MB');
  });

  test('validators accept common inputs', () {
    expect(NextValidations.isValidEmail('user@example.com'), isTrue);
    expect(NextValidations.isValidEmail('not-an-email'), isFalse);
    expect(NextValidations.isValidPhoneNumber('+1234567890'), isTrue);
    expect(NextValidations.isValidPhoneNumber('0123'), isFalse);
    expect(NextValidations.isValidCreditCard('4111111111111111'), isTrue);
    expect(NextValidations.isValidCreditCard('0000000000000'), isFalse);
    expect(NextValidations.isValidCreditCard('4111111111111112'), isFalse);
  });

  testWidgets('isMobile follows width', (tester) async {
    late bool narrow;
    late bool wide;
    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(size: Size(400, 800)),
        child: Builder(
          builder: (context) {
            narrow = context.isMobile;
            return const SizedBox();
          },
        ),
      ),
    );
    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(size: Size(800, 800)),
        child: Builder(
          builder: (context) {
            wide = context.isMobile;
            return const SizedBox();
          },
        ),
      ),
    );
    expect(narrow, isTrue);
    expect(wide, isFalse);
  });
}
