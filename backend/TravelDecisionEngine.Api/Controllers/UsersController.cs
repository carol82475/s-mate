using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using TravelDecisionEngine.Application.DTOs.Users;
using TravelDecisionEngine.Application.Interfaces;

namespace TravelDecisionEngine.Api.Controllers;

[Authorize]
[Route("api/users")]
public class UsersController : ApiControllerBase
{
    private readonly IUsersService _users;

    public UsersController(IUsersService users)
    {
        _users = users;
    }

    [HttpGet("me")]
    public async Task<IActionResult> GetMe(CancellationToken cancellationToken)
        => Ok(new { success = true, message = "Profile loaded", data = await _users.GetMeAsync(GetUserIdOrThrow(), cancellationToken) });

    [HttpPut("me")]
    public async Task<IActionResult> UpdateMe([FromBody] UpdateUserProfileRequest request, CancellationToken cancellationToken)
        => Ok(new { success = true, message = "Profile updated", data = await _users.UpdateMeAsync(GetUserIdOrThrow(), request, cancellationToken) });

    [HttpPut("me/preferences")]
    public async Task<IActionResult> UpdatePreferences([FromBody] UpdatePreferencesRequest request, CancellationToken cancellationToken)
        => Ok(new { success = true, message = "Preferences updated", data = await _users.UpdatePreferencesAsync(GetUserIdOrThrow(), request, cancellationToken) });

    [HttpPut("me/language")]
    public async Task<IActionResult> UpdateLanguage([FromBody] UpdateLanguageRequest request, CancellationToken cancellationToken)
        => Ok(new { success = true, message = "Language updated", data = await _users.UpdateLanguageAsync(GetUserIdOrThrow(), request, cancellationToken) });

    [HttpPut("me/privacy")]
    public async Task<IActionResult> UpdatePrivacy([FromBody] UpdatePrivacyRequest request, CancellationToken cancellationToken)
    {
        await _users.UpdatePrivacyAsync(GetUserIdOrThrow(), request, cancellationToken);
        return Ok(new { success = true, message = "Privacy updated", data = new { } });
    }
}
