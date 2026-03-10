import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:perfect_numbers/core/l10n/app_localizations.dart';
import 'package:perfect_numbers/core/theme/app_theme.dart';
import 'package:perfect_numbers/features/perfect_number/presentation/cubit/perfect_number_cubit.dart';

class TestAppWrapper extends StatelessWidget {
  final Widget child;
  final PerfectNumberCubit cubit;

  const TestAppWrapper({super.key, required this.child, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.dark(),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en')],
      home: BlocProvider.value(
        value: cubit,
        child: Scaffold(body: child),
      ),
    );
  }
}
