using System.Collections.Generic;
using Godot;

public partial class player : CharacterBody2D
{
    private Queue<Vector2> steps = new Queue<Vector2>();
    private bool frozen = true;

    /// <summary>
    /// Called every physics frame. Handles player movement and state changes.
    /// </summary>
    public override void _PhysicsProcess(double delta)
    {
        AnimatedSprite2D me = GetNode<AnimatedSprite2D>("me");
        if (!IsOnFloor())
        {
            Velocity += GetGravity() * (float)delta;
        }
        if (frozen)
        {
            if (IsOnFloor())
            {
                Modulate = Settings.FrozenColor;
            }
            me.SpeedScale = Settings.FrozenSpeedScale;
            Vector2 direction = Input.GetVector("left", "right", "up", "down");
            if (steps.Count > 0 || direction != Vector2.Zero)
            {
                steps.Enqueue(direction);
            }
        }
        else
        {
            Modulate = Settings.NormalColor;
            me.SpeedScale = Settings.NormalSpeedScale;
            move(delta, steps.Dequeue());
            if (steps.Count == 0)
            {
                frozen = true;
            }
        }
        if (Input.IsActionJustReleased("start") && steps.Count > 0)
        {
            frozen = false;
        }
        MoveAndSlide();
    }

    /// <summary>
    /// Executes player movement based on the given direction.
    /// </summary>
    /// <param name="delta">The frame time.</param>
    /// <param name="direction">The direction vector for movement.</param>
    public void move(double delta, Vector2 direction)
    {
        Vector2 velocity = Velocity;
        if (direction.Y < 0 && IsOnFloor())
        {
            velocity.Y = Settings.JumpVelocity * (float)delta;
        }
        if (direction != Vector2.Zero)
        {
            velocity.X = direction.X * Settings.Speed * (float)delta;
        }
        else
        {
            velocity.X = Mathf.MoveToward(Velocity.X, 0, Settings.Speed * (float)delta);
        }
        Velocity = velocity;
    }
}
