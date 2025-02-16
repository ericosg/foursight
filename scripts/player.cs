using Godot;
using System;
using System.Collections.Generic;
using System.Linq;

public partial class player : CharacterBody2D
{
	public const float Speed = 100.0f;
	public const float JumpVelocity = -300.0f;
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
			Modulate = new Color(1, 0, 0);
			me.SpeedScale = 0.2f;
			Vector2 direction = Input.GetVector("left", "right", "up", "down");
			if (steps.Count > 0 || direction != Vector2.Zero)
			{
				steps.Enqueue(direction);
			}
		}
		else
		{
			Modulate = new Color(1, 1, 1);
			me.SpeedScale = 1.0f;
			play(delta, steps.Dequeue());
			if (steps.Count == 0)
			{
				frozen = true;
			}
		}
		if (Input.IsActionJustReleased("start"))
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
			velocity.Y = JumpVelocity;
		}
		if (direction != Vector2.Zero)
		{
			velocity.X = direction.X * Speed;
		}
		else
		{
			velocity.X = Mathf.MoveToward(Velocity.X, 0, Speed);
		}
		Velocity = velocity;
	}
}
