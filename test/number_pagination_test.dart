import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:number_pagination/number_pagination.dart';
import 'package:number_pagination/page_number_provider.dart';

void main() {
  // Testing the rendering and functionality of the NumberPagination widget
  group('NumberPagination', () {
    late int currentPage;
    late NumberPagination numberPagination;

    final pageService = NumberPageService(1);

    setUp(() {
      currentPage = 1;
      numberPagination = NumberPagination(
        pageService: pageService,
        onPageChanged: (page) {
          currentPage = page;
        },
        pageTotal: 100,
        threshold: 11,
        pageInit: currentPage,
      );
    });

    Future<void> pumpNumberPagination(WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: numberPagination,
          ),
        ),
      );
    }

    testWidgets('renders correctly on initial load',
        (WidgetTester tester) async {
      await pumpNumberPagination(tester);

      expect(find.text('1'), findsOneWidget);
      expect(find.text('11'), findsOneWidget);
    });

    testWidgets('updates page correctly on next page button click',
        (WidgetTester tester) async {
      await pumpNumberPagination(tester);

      await tester.tap(find.byIcon(Icons.keyboard_arrow_right));
      await tester.pump();

      expect(currentPage, 2);
    });

    testWidgets('updates page correctly on specific page button click',
        (WidgetTester tester) async {
      await pumpNumberPagination(tester);

      await tester.tap(find.text('10'));
      await tester.pump();

      expect(currentPage, 10);
    });

    testWidgets('displays last page correctly on last page button click',
        (WidgetTester tester) async {
      await pumpNumberPagination(tester);

      await tester.tap(find.byIcon(Icons.last_page));
      await tester.pump();

      expect(find.text('100'), findsOneWidget);
    });
  });
}
