using UnityEngine;
using System.Collections;

public class Enemy : Entity {
	public float damage;
	public StoreHealth health;
	public float speed;
	public float jumpForce;
	public Transform enemyTransform; 
	public Rigidbody2D enemyBody;
	public GameObject player;
	public SpriteRenderer enemyRenderer;
	public float wallCheckRadius;
	public Transform wallCheck;
	public float groundCheckRadius;
	public Transform groundCheck;
	public LayerMask whatIsGround;
	public Animator anim;
	public Transform playerTransform;
	public bool grounded = true;
	public bool walled = false;

	public override float getDamage(){
		return damage;
	}

	public override float getHealth(){
		return health.getHealth();
	}

	public float getSpeed(){
		return speed * localTimeScale;
	}
	public override void loseHealth(float health){
		this.health.setHealth (this.health.getHealth () - health);
	}
	public override void gainHealth(float health){
		this.health.setHealth (this.health.getHealth () + health);
	}
	public override void setColor (Color color){
		enemyRenderer.color = color;
	}
	public void createDeathParticles(Color color){
		GameObject particles = (GameObject)Resources.Load ("Prefabs/Death_Particles");
		particles.GetComponent<ParticleSystem>().startColor = color;
		Instantiate (particles, enemyTransform.position, Quaternion.identity);
	}

	void OnDestroy() {
		GameVariables.kills++;
	}
}
