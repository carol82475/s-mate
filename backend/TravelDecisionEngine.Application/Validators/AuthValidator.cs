namespace TravelDecisionEngine.Application.Validators;

public static class AuthValidator
{
    public static List<string> ValidateRegister(string email, string password)
    {
        var errors = new List<string>();
        if (string.IsNullOrWhiteSpace(email) || !email.Contains('@')) errors.Add("Email is invalid.");
        if (string.IsNullOrWhiteSpace(password) || password.Length < 8) errors.Add("Password must have at least 8 characters.");
        return errors;
    }
}
