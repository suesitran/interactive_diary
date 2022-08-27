import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

void main() {
  group('Test vertical gap', () {
    testWidgets('When create gap with v20, Then render SizedBox with height 20',
            (WidgetTester tester) async {
          const gapV20 = Gap.v20();

          /// We need to wrap gap with some widget to prevent SizedBox take all available space
          await tester.pumpWidget(MaterialApp(home: Column(children: const [gapV20],),));
          await tester.pumpAndSettle();

          final SizedBox size = tester.widget<SizedBox>(find.byType(SizedBox));

          expect(size.height, 20);
        });

    testWidgets('When create gap with v16, Then render SizedBox with height 16',
            (WidgetTester tester) async {
          const gap = Gap.v16();

          /// We need to wrap gap with some widget to prevent SizedBox take all available space
          await tester.pumpWidget(MaterialApp(home: Column(children: const [gap],),));
          await tester.pumpAndSettle();

          final SizedBox size = tester.widget<SizedBox>(find.byType(SizedBox));

          expect(size.height, 16);
        });

    testWidgets('When create gap with v12, Then render SizedBox with height 12',
            (WidgetTester tester) async {
          const gap = Gap.v12();

          /// We need to wrap gap with some widget to prevent SizedBox take all available space
          await tester.pumpWidget(MaterialApp(home: Column(children: const [gap],),));
          await tester.pumpAndSettle();

          final SizedBox size = tester.widget<SizedBox>(find.byType(SizedBox));

          expect(size.height, 12);
        });

    testWidgets('When create gap with v08, Then render SizedBox with height 08',
            (WidgetTester tester) async {
          const gap = Gap.v08();

          /// We need to wrap gap with some widget to prevent SizedBox take all available space
          await tester.pumpWidget(MaterialApp(home: Column(children: const [gap],),));
          await tester.pumpAndSettle();

          final SizedBox size = tester.widget<SizedBox>(find.byType(SizedBox));

          expect(size.height, 08);
        });

    testWidgets('When create gap with v04, Then render SizedBox with height 04',
            (WidgetTester tester) async {
          const gap = Gap.v04();

          /// We need to wrap gap with some widget to prevent SizedBox take all available space
          await tester.pumpWidget(MaterialApp(home: Column(children: const [gap],),));
          await tester.pumpAndSettle();

          final SizedBox size = tester.widget<SizedBox>(find.byType(SizedBox));

          expect(size.height, 04);
        });
  });

  group('Test horizontal gap', () {
    testWidgets('When create gap with h20, Then render SizedBox with height 20',
            (WidgetTester tester) async {
          const gap = Gap.h20();

          /// We need to wrap gap with some widget to prevent SizedBox take all available space
          await tester.pumpWidget(MaterialApp(home: Column(children: const [gap],),));
          await tester.pumpAndSettle();

          final SizedBox size = tester.widget<SizedBox>(find.byType(SizedBox));

          expect(size.width, 20);
        });

    testWidgets('When create gap with h16, Then render SizedBox with height 16',
            (WidgetTester tester) async {
          const gap = Gap.h16();

          /// We need to wrap gap with some widget to prevent SizedBox take all available space
          await tester.pumpWidget(MaterialApp(home: Column(children: const [gap],),));
          await tester.pumpAndSettle();

          final SizedBox size = tester.widget<SizedBox>(find.byType(SizedBox));

          expect(size.width, 16);
        });

    testWidgets('When create gap with h12, Then render SizedBox with height 12',
            (WidgetTester tester) async {
          const gap = Gap.h12();

          /// We need to wrap gap with some widget to prevent SizedBox take all available space
          await tester.pumpWidget(MaterialApp(home: Column(children: const [gap],),));
          await tester.pumpAndSettle();

          final SizedBox size = tester.widget<SizedBox>(find.byType(SizedBox));

          expect(size.width, 12);
        });

    testWidgets('When create gap with h08, Then render SizedBox with height 08',
            (WidgetTester tester) async {
          const gap = Gap.h08();

          /// We need to wrap gap with some widget to prevent SizedBox take all available space
          await tester.pumpWidget(MaterialApp(home: Column(children: const [gap],),));
          await tester.pumpAndSettle();

          final SizedBox size = tester.widget<SizedBox>(find.byType(SizedBox));

          expect(size.width, 08);
        });

    testWidgets('When create gap with h04, Then render SizedBox with height 04',
            (WidgetTester tester) async {
          const gap = Gap.h04();

          /// We need to wrap gap with some widget to prevent SizedBox take all available space
          await tester.pumpWidget(MaterialApp(home: Column(children: const [gap],),));
          await tester.pumpAndSettle();

          final SizedBox size = tester.widget<SizedBox>(find.byType(SizedBox));

          expect(size.width, 04);
        });
  });
}