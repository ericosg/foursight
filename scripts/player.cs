using System.Collections.Generic;
using Godot;

public partial class player : CharacterBody2D
{
    private Queue<Vector2> steps = new Queue<Vector2>();
    private bool frozen = true;

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
            me.SpeedScale = 0.2f;
            Vector2 direction = Input.GetVector("left", "right", "up", "down");
            if (steps.Count > 0 || direction != Vector2.Zero)
            {
                steps.Enqueue(direction);
            }
        }
        else
        {
            Modulate = Settings.NormalColor;
            me.SpeedScale = 1.0f;
            play(delta, steps.Dequeue());
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

    public void play(double delta, Vector2 direction)
    {
        Vector2 velocity = Velocity;
        if (direction.Y < 0 && IsOnFloor())
        {
            velocity.Y = Settings.JumpVelocity;
        }
        if (direction != Vector2.Zero)
        {
            velocity.X = direction.X * Settings.Speed;
        }
        else
        {
            velocity.X = Mathf.MoveToward(Velocity.X, 0, Settings.Speed);
        }
        Velocity = velocity;
    }
}
