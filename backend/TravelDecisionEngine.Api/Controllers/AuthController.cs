using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using TravelDecisionEngine.Application.DTOs.Auth;
using TravelDecisionEngine.Application.Interfaces;

namespace TravelDecisionEngine.Api.Controllers;

[Route("api/auth")]
public class AuthController : ApiControllerBase
{
    private readonly IAuthService _auth;

    public AuthController(IAuthService auth)
    {
        _auth = auth;
    }

    [HttpPost("register")]
    [AllowAnonymous]
    public async Task<IActionResult> Register([FromBody] RegisterRequest request, CancellationToken cancellationToken)
        => Ok(new { success = true, message = "Registered", data = await _auth.RegisterAsync(request, cancellationToken) });

    [HttpPost("login")]
    [AllowAnonymous]
    public async Task<IActionResult> Login([FromBody] LoginRequest request, CancellationToken cancellationToken)
        => Ok(new { success = true, message = "Logged in", data = await _auth.LoginAsync(request, cancellationToken) });

    [HttpPost("social-login")]
    [AllowAnonymous]
    public async Task<IActionResult> SocialLogin([FromBody] SocialLoginRequest request, CancellationToken cancellationToken)
        => Ok(new { success = true, message = "Social login complete", data = await _auth.SocialLoginAsync(request, cancellationToken) });

    [HttpPost("refresh-token")]
    [AllowAnonymous]
    public async Task<IActionResult> RefreshToken([FromBody] RefreshTokenRequest request, CancellationToken cancellationToken)
        => Ok(new { success = true, message = "Token refreshed", data = await _auth.RefreshTokenAsync(request, cancellationToken) });

    [HttpPost("forgot-password")]
    [AllowAnonymous]
    public async Task<IActionResult> ForgotPassword([FromBody] ForgotPasswordRequest request, CancellationToken cancellationToken)
    {
        await _auth.ForgotPasswordAsync(request, cancellationToken);
        return Ok(new { success = true, message = "OTP sent", data = new { } });
    }

    [HttpPost("verify-otp")]
    [AllowAnonymous]
    public async Task<IActionResult> VerifyOtp([FromBody] VerifyOtpRequest request, CancellationToken cancellationToken)
    {
        await _auth.VerifyOtpAsync(request, cancellationToken);
        return Ok(new { success = true, message = "OTP verified", data = new { } });
    }

    [HttpPost("reset-password")]
    [AllowAnonymous]
    public async Task<IActionResult> ResetPassword([FromBody] ResetPasswordRequest request, CancellationToken cancellationToken)
    {
        await _auth.ResetPasswordAsync(request, cancellationToken);
        return Ok(new { success = true, message = "Password reset", data = new { } });
    }

    [Authorize]
    [HttpDelete("delete-account")]
    public async Task<IActionResult> DeleteAccount(CancellationToken cancellationToken)
    {
        await _auth.DeleteAccountAsync(GetUserIdOrThrow(), cancellationToken);
        return Ok(new { success = true, message = "Account deleted", data = new { } });
    }
}
