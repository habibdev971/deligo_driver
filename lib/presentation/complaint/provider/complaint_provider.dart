import 'package:deligo_driver/data/repositories/complaint_repo_impl.dart';
import 'package:deligo_driver/data/repositories/interfaces/complaint_repo_interface.dart';
import 'package:deligo_driver/data/services/complaint_service.dart';
import 'package:deligo_driver/domain/interfaces/complaint_service_interface.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/provider/auth_providers.dart';
import '../view_model/complaint_notifier.dart';

final complaintServiceProvider = Provider<IComplaintService>((ref) => ComplaintService(dioClient: ref.read(dioClientProvider)));

// Repo Provider
final complaintRepoProvider = Provider<IComplaintRepo>((ref) => ComplaintRepoImpl(service: ref.read(complaintServiceProvider)));

// Notifier Providers
final complaintProvider = StateNotifierProvider<ComplaintNotifier, ComplaintState>(
        (ref) => ComplaintNotifier(repo: ref.read(complaintRepoProvider), ref: ref));