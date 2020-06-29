import 'package:e_coupon/business/abstract_wallet_repo.dart';
import 'package:e_coupon/business/get_wallet.dart';
import 'package:e_coupon/data/wallet_repo.dart';
import 'package:e_coupon/ui/screens/wallet_screens/wallet_model.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final serviceLocator = GetIt.instance; // service locator

Future<void> initServiceLocator() async {
  // sl() = sl.call(): will inject the needed dependencies as soon as they are created.

  //! Features
  // VM
  serviceLocator.registerLazySingleton(
      () => WalletViewModel(getWallet: serviceLocator()));

  // Use cases
  serviceLocator
      .registerLazySingleton(() => GetWallet(repository: serviceLocator()));

  // Repository
  serviceLocator.registerLazySingleton<IWalletRepo>(
    () => WalletRepo(),
  );

  // Data sources

  //! Core

  //! External
}

// Future<void> init() async {
//   //! Features - Number Trivia
//   // Bloc
//   sl.registerFactory(
//     () => NumberTriviaBloc(
//       concrete: sl(), // sl() = sl.call() which will use the later in this code created instance for this
//       inputConverter: sl(),
//       random: sl(),
//     ),
//   );

//   // Use cases
//   sl.registerLazySingleton(() => GetConcreteNumberTrivia(sl()));
//   sl.registerLazySingleton(() => GetRandomNumberTrivia(sl()));

//   // Repository
//   sl.registerLazySingleton<NumberTriviaRepository>(
//     () => NumberTriviaRepositoryImpl(
//       localDataSource: sl(),
//       networkInfo: sl(),
//       remoteDataSource: sl(),
//     ),
//   );

//   // Data sources
//   sl.registerLazySingleton<NumberTriviaRemoteDataSource>(
//     () => NumberTriviaRemoteDataSourceImpl(client: sl()),
//   );

//   sl.registerLazySingleton<NumberTriviaLocalDataSource>(
//     () => NumberTriviaLocalDataSourceImpl(sharedPreferences: sl()),
//   );

//   //! Core
//   sl.registerLazySingleton(() => InputConverter());
//   sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

//   //! External
//   final sharedPreferences = await SharedPreferences.getInstance();
//   sl.registerLazySingleton(() => sharedPreferences);
//   sl.registerLazySingleton(() => http.Client());
//   sl.registerLazySingleton(() => DataConnectionChecker());
// }
