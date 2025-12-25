import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/services/token_service.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<String> sendOtp(String phoneNumber);
  Future<UserModel> verifyOtp({
    required String phoneNumber,
    required String otp,
  });
  Future<UserModel> getCurrentUser();
  Future<UserModel> updateProfile({
    String? name,
    String? email,
    DateTime? dateOfBirth,
  });
  Future<UserModel> selectRole(String role);
  Future<void> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient dioClient;
  final TokenService tokenService;

  AuthRemoteDataSourceImpl({
    required this.dioClient,
    required this.tokenService,
  });

  @override
  Future<String> sendOtp(String phoneNumber) async {
    final response = await dioClient.post(
      ApiEndpoints.sendOtp,
      data: {'phone': phoneNumber},
    );
    return response.data['message'] ?? 'OTP sent successfully';
  }

  @override
  Future<UserModel> verifyOtp({
    required String phoneNumber,
    required String otp,
  }) async {
    final response = await dioClient.post(
      ApiEndpoints.verifyOtp,
      data: {
        'phone': phoneNumber,
        'otp': otp,
      },
    );

    // Save tokens
    await tokenService.saveAccessToken(response.data['accessToken']);
    await tokenService.saveRefreshToken(response.data['refreshToken']);

    // Save user ID and role
    final userId = response.data['user']['id'];
    final userRole = response.data['user']['role'];
    await tokenService.saveUserId(userId);
    if (userRole != null) {
      await tokenService.saveUserRole(userRole);
    }

    // Return user
    return UserModel.fromJson(response.data['user']);
  }

  @override
  Future<UserModel> getCurrentUser() async {
    final response = await dioClient.get(ApiEndpoints.getUserProfile);
    return UserModel.fromJson(response.data);
  }

  @override
  Future<UserModel> updateProfile({
    String? name,
    String? email,
    DateTime? dateOfBirth,
  }) async {
    final response = await dioClient.put(
      ApiEndpoints.updateUserProfile,
      data: {
        if (name != null) 'name': name,
        if (email != null) 'email': email,
        if (dateOfBirth != null) 'date_of_birth': dateOfBirth.toIso8601String(),
      },
    );
    return UserModel.fromJson(response.data);
  }

  @override
  Future<UserModel> selectRole(String role) async {
    // Role selection is typically done locally after initial login
    // The backend doesn't have a separate endpoint for this
    // We'll update the local user and save the role
    final currentUser = await getCurrentUser();

    // Save role to secure storage
    await tokenService.saveUserRole(role);

    // Note: In production, you might want to update this on the backend
    // with a PUT /user/profile endpoint including the role
    return currentUser.copyWith(
      role: role,
      isVerified: role == 'owner' ? false : true, // Owners need KYC
    );
  }

  @override
  Future<void> logout() async {
    try {
      // Attempt to notify backend about logout (if endpoint exists)
      await dioClient.post(ApiEndpoints.logout);
    } catch (e) {
      // If backend logout fails, still clear local tokens
      // This ensures user can logout even if backend is unreachable
    } finally {
      await tokenService.clearTokens();
    }
  }
}
