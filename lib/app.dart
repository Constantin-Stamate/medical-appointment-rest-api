import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/constants/app_colors.dart';

import 'package:http/http.dart' as http;

import 'data/datasources/app_remote_data_source.dart';
import 'data/repositories/app_repository_impl.dart';
import 'domain/usecases/load_app_data.dart';
import 'presentation/state/app_cubit.dart';
import 'presentation/screens/home/home_screen.dart';

class DoctorApp extends StatefulWidget {
  const DoctorApp({super.key});

  @override
  State<DoctorApp> createState() => _DoctorAppState();
}

class _DoctorAppState extends State<DoctorApp> {
  final client = http.Client();

  @override
  void dispose() {
    client.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) =>
        AppCubit(LoadAppData(AppRepositoryImpl(AppRemoteDataSource(client))))
          ..load(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Doctor App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const HomeScreen(),
    ),
  );
}