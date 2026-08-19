import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data/datasources/home_remote_data_source_impl.dart';
import '../../data/repositories/home_repository_impl.dart';
import '../../domain/repositories/home_repository.dart';

HomeRepo createHomeRepo() {
  final firestore = FirebaseFirestore.instance;

  final homeRemoteDataSource = HomeRemoteDataSourceImpl(
    firestore: firestore,
  );

  return HomeRepoImpl(
    dataSource: homeRemoteDataSource,
  );
}