import 'package:dartz/dartz.dart';
import 'package:deligo_driver/data/models/common_response.dart';
import 'package:deligo_driver/data/models/wallet_model/wallet_balance_model.dart';
import 'package:deligo_driver/data/models/wallet_model/wallet_transaction_history_model.dart';
import 'package:deligo_driver/data/repositories/interfaces/wallet_repo_interface.dart';
import 'package:deligo_driver/domain/interfaces/wallet_service_interface.dart';
import '../../core/errors/failure.dart';
import '../models/my_card_model/my_card_model.dart';
import 'base_repository.dart';

class WalletsRepoImpl extends BaseRepository implements IWalletsRepo {
  final IWalletService walletService;

  WalletsRepoImpl({required this.walletService});
  @override
  Future<Either<Failure, WalletBalanceModel>> getWallets() async => await safeApiCall(() async {
      final response = await walletService.getWallets();
      return WalletBalanceModel.fromJson(response.data);
    });

  @override
  Future<Either<Failure, WalletTransactionHistoryModel>> getWalletsTransaction({required Map<String, dynamic> param}) async => await safeApiCall(() async {
      final response = await walletService.getWalletsTransaction(param: param);
      return WalletTransactionHistoryModel.fromJson(response.data);
    });

  @override
  Future<Either<Failure, CommonResponse>> withdraw({required Map<String, dynamic> body}) async => await safeApiCall(() async {
      final response = await walletService.withdraw(body: body);
      return CommonResponse.fromJson(response.data);
    });

  @override
  Future<Either<Failure, CommonResponse>> addCard({required Map<String, dynamic> body}) async => await safeApiCall(() async {
      final response = await walletService.addCard(body: body);
      return CommonResponse.fromJson(response.data);
    });

  @override
  Future<Either<Failure, MyCardModel>> myCards() async => await safeApiCall(() async {
      final response = await walletService.myCards();
      return MyCardModel.fromJson(response.data);
    });

  @override
  Future<Either<Failure, CommonResponse>> deleteCard({required String? id}) async => await safeApiCall(() async {
      final response = await walletService.deleteCard(id);
      return CommonResponse.fromJson(response.data);
    });
}
