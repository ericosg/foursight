using Godot;

public static class Settings
{
    private const double delta = 0.016;
    public const float Speed = 100.0f / (float)delta;
    public const float JumpVelocity = -300.0f / (float)delta;
    public static readonly Color FrozenColor = new Color(0.5f, 0.5f, 1.0f);
    public const float FrozenSpeedScale = 0.2f;
    public static readonly Color NormalColor = new Color(1.0f, 1.0f, 1.0f);
    public const float NormalSpeedScale = 1.0f;
}
