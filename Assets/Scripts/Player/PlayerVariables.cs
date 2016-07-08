using UnityEngine;
using System.Collections;

public class PlayerVariables : Entity {
	public GameObject player;
	public GameObject hand;
	public SpriteRenderer characterRenderer;
	public changeWeapon weapon;
	public Transform playerTransform;
	public Transform groundCheck;
	public float groundCheckRadius;
	public Transform wallCheck;
	public float wallCheckRadius;
	public LayerMask whatIsGround;
	public Animator anim;
	public Rigidbody2D playerBody;
	public StoreHealth health;
	public ParticleSystem spellCast;
	private float movementSpeed = 10f;
	private int direction = 1;
	private bool grounded = true;
	private bool walled = false;
	private float jumpForce = 600f;
	public bool stop = false;
	private int action = -1;
	public float baseDamage = 10f;
	public float manaPool;
	public float mana;
	GameObject projectile;
	public override void setColor (Color color){
		characterRenderer.color = color;
	}
	public override void loseHealth(float health){
		this.health.setHealth (this.health.getHealth () - health);
	}
	public override void gainHealth(float health){
		this.health.setHealth (this.health.getHealth () + health);
	}
	public override float getHealth(){
		return health.getHealth ();
	}
	public override float getDamage(){
		return baseDamage;
	}
	// Use this for initialization
	void Start () {
		grounded = Physics2D.OverlapCircle (groundCheck.position, groundCheckRadius, whatIsGround);
		health.setBaseHealth(600);
		health.setHealth(600);
		baseDamage = 10f;
		manaPool = 100;
		mana = manaPool;
	}

	// Update is called once per frame
	void FixedUpdate () {
		if (health.getHealth () <= 0) {
			Color color = new Color(252f/255f, 255f/255f, 26f/255f, 1f);
			createDeathParticles (color);
			color = new Color(249f/255f, 43f/255f, 43f/255f, 1f);
			createDeathParticles (color);
			color = new Color(255f/255f, 212f/255f, 137f/255f, 1f);
			createDeathParticles (color);
			GameVariables.characterAlive = false;
			GameVariables.deaths++;
			Destroy (this.gameObject);
		}
		grounded = Physics2D.OverlapCircle (groundCheck.position, groundCheckRadius, whatIsGround);
		walled = Physics2D.OverlapCircle (wallCheck.position, wallCheckRadius, whatIsGround);
		anim.SetBool ("Grounded", grounded);
		anim.SetBool ("Walled", walled);
		if(!grounded && action == 1) action = 2;
		anim.SetInteger ("Action", action);
		if(action != 2 && action != 3) playerTransform.localScale = new Vector3 (Mathf.Abs (playerTransform.localScale.x) * direction, playerTransform.localScale.y, playerTransform.localScale.z);
		if (walled && !grounded && action == -1 && playerBody.velocity.y <= 0) {
			playerBody.gravityScale = 0.5f;
		}
		else if (!grounded && playerBody.velocity.magnitude > 0 && playerBody.gravityScale < 5) {
			playerBody.gravityScale += 0.05f;
			anim.SetFloat ("AirSpeed", playerBody.velocity.y);
		} else {						
			playerBody.gravityScale = 1;
		}
		if (mana < manaPool)
			mana += 0.05f;
		else if (mana > 100)
			mana = 100;
	}

	public void setSpeed(float movementSpeed){
		this.movementSpeed = movementSpeed;
	}

	public float getSpeed(){
		return movementSpeed;
	}

	public void move(){
		if ((!stop || action == 2) && !walled) {
			anim.SetFloat ("Speed", movementSpeed);
			if (Mathf.Abs(playerBody.velocity.x) > 0) playerBody.velocity = new Vector3 (Mathf.Abs(playerBody.velocity.x)/playerBody.velocity.x*(Mathf.Abs(playerBody.velocity.x) - 0.5f), playerBody.velocity.y);
			if (Mathf.Abs(playerBody.velocity.x) > 0 && Mathf.Abs(playerBody.velocity.x) < 5) {
//				playerBody.velocity = new Vector3 (0, playerBody.velocity.y);
				playerBody.velocity = new Vector3 (0, playerBody.velocity.y);
			}
			if(Mathf.Abs(playerBody.velocity.x) == 0) 
				playerTransform.transform.Translate (Vector3.right * direction * movementSpeed * Time.deltaTime * localTimeScale);
		}
	}

	public void idle(){
		anim.SetFloat ("Speed", 0);
	}

	public void jump(){
		if (!stop && action == -1 && grounded && playerBody.velocity.y <= 0) {
			playerBody.AddForce (Vector2.up * jumpForce * localTimeScale);
		} else if (!stop && action == -1 && walled && playerBody.velocity.y <= 0) {
			playerBody.velocity = Vector2.zero;
			playerBody.AddForce (new Vector2(-1f * direction, 1f) * jumpForce * localTimeScale);
			walled = false;
		}

	}

	public void evade(){
		if (!stop && grounded) {
			action = 0;
			stop = true;
			StartCoroutine (resetAction (11f / 60f));
		}
	}

	public void attack(){
		if (weapon.getWeaponType () == 2 && !stop) {
			if (mana >= 10) {
				mana -= 10;
				action = 7;
				stop = true;
				anim.SetBool ("Stop", stop);
//				spellCast.startColor = weapon.weapon.getColor ();
//				spellCast.Play ();
				StartCoroutine (resetAction (4f / 15f));
			} else {
				idle ();
			}
		} else if (weapon.getWeaponType () == 1 && (!stop || (action >= 4 && action <= 6))) {
			if (projectile == null) {
				projectile = (GameObject)Instantiate (Resources.Load ("Prefabs/Arrow"), hand.transform.position, Quaternion.identity);
				projectile.GetComponent<ArrowShoot> ().setDamage (baseDamage);
			} else {
				projectile.transform.position = hand.transform.position;
				projectile.transform.localScale = new Vector3 (Mathf.Abs (projectile.transform.localScale.x) * direction, projectile.transform.localScale.y, projectile.transform.localScale.z); 
			}
			if (Input.GetKey (KeyCode.UpArrow) && (Input.GetKey (KeyCode.RightArrow) || Input.GetKey (KeyCode.LeftArrow))) {
				stop = true;
				anim.SetBool ("Stop", stop);
				action = 5;
				projectile.transform.rotation = Quaternion.Euler (0, 0, 45 * direction);
			} else if (Input.GetKey (KeyCode.UpArrow)) {
				stop = true;
				anim.SetBool ("Stop", stop);
				action = 6;
				projectile.transform.rotation = Quaternion.Euler (0, 0, 90 * direction);
			} else {
				stop = true;
				anim.SetBool ("Stop", stop);
				action = 4;
				projectile.transform.rotation = Quaternion.Euler (0, 0, 0);
			}
			if (Input.GetKeyDown (KeyCode.X)) {
				evade ();
			}
		} else if (weapon.getWeaponType () == 0) {
			if (!stop && grounded && movementSpeed == 20) {
				stop = true;
				action = 3;
				anim.SetBool ("Stop", stop);
				StartCoroutine (resetAction (1f / 3f));
			} else if (!stop && grounded) {
				stop = true;
				action = 1;
				anim.SetBool ("Stop", stop);
				StartCoroutine (resetAction (25f / 60f));
			} else if (!stop) {
				stop = true;
				action = 2;
				anim.SetBool ("Stop", stop);
				StartCoroutine (resetAction (2f / 3f));
			} 
		}
	}

	public void setDirection(int direction){
		if(!stop || action == 2 || (action >= 4 && action <= 6))
			this.direction = direction;
	}

	public bool getGrounded(){
		return grounded;
	}

	IEnumerator resetAction(float time){
		if (action == 0) {
			for (int i = 0; i < 8; i++) {
				yield return new WaitForSeconds (time / 8);
				playerTransform.transform.Translate (Vector3.left * 30f * direction * Time.deltaTime * localTimeScale);
			}
		} else if (action == 1) {
			yield return new WaitForSeconds (time / 3);
			playerTransform.transform.Translate (Vector3.right * 10 * direction * Time.deltaTime * localTimeScale);
			yield return new WaitForSeconds (time / 3);
			playerTransform.transform.Translate (Vector3.right * 5 * direction * Time.deltaTime * localTimeScale);
			yield return new WaitForSeconds (time / 3);
			playerTransform.transform.Translate (Vector3.right * 15 * direction * Time.deltaTime * localTimeScale);
		} else if (action == 2) {
			yield return new WaitForSeconds (time);
		} else if (action == 3) {
			for (int i = 0; i < 10; i++) {
				yield return new WaitForSeconds (time / 10);
				playerTransform.transform.Translate (Vector3.right * (40 - i * 2)* direction * Time.deltaTime * localTimeScale);
			}
		} else if(action == 7){
			yield return new WaitForSeconds (time/2);
			projectile = (GameObject)Instantiate (Resources.Load ("Prefabs/Fireball"), new Vector3(hand.transform.position.x + characterRenderer.bounds.size.x*direction, hand.transform.position.y, 0), Quaternion.identity);
			projectile.GetComponent<Rigidbody2D> ().AddForce (new Vector2(1 * direction, 0.1f * Random.Range (0, 6) - 0.2f) * 1000f * localTimeScale);
			projectile.GetComponent<Damage> ().setDamage (baseDamage);
			projectile = null;
			yield return new WaitForSeconds (time/2);
		} else {
			yield return new WaitForSeconds (time);
		}
		stop = false;
		anim.SetBool ("Stop", stop);
		action = -1;
		// Code to execute after the delay
	}

	public int getAction(){
		return action;
	}

	public void OnTriggerEnter2D(Collider2D collider) {
		if (collider.gameObject.tag == "EnemyHitBox") {
			StartCoroutine (getHit (0.2f));
			if (action == 0)
				health.loseHealth (0.25f * collider.gameObject.GetComponentInParent<Enemy> ().getDamage ());
			else
				health.loseHealth (collider.gameObject.GetComponentInParent<Enemy> ().getDamage ());
		}
	}

	IEnumerator getHit(float time){
		characterRenderer.color = new Color (1f, 0.5f, 0.5f, 1f);
		yield return new WaitForSeconds (time);
		characterRenderer.color = new Color (1f, 1f, 1f, 1f);
	}

	public void shoot(float waitTime){
		action = -1;
		if (projectile != null) {
			Vector2 d;
			if (characterRenderer.sprite.name == "shoot3" || characterRenderer.sprite.name == "Jshoot3") {
				d = Vector2.up * localTimeScale;
			} else if (characterRenderer.sprite.name == "shoot2" || characterRenderer.sprite.name == "Jshoot2") {
				d = new Vector2 (1 * direction * localTimeScale, 1 * localTimeScale);
			} else {
				d = Vector2.right * direction * localTimeScale;
			}
			projectile.GetComponent<Rigidbody2D> ().isKinematic = false;
			projectile.GetComponent<ArrowShoot> ().release (d);
			projectile.GetComponent<BoxCollider2D> ().enabled = true;
			projectile = null;
		}
		StartCoroutine (resetAction (waitTime));
	}

	public bool getWalled(){
		return walled;
	}

	public void createDeathParticles(Color color){
		GameObject particles = (GameObject)Resources.Load ("Prefabs/Death_Particles");
		particles.GetComponent<ParticleSystem>().startColor = color;
		Instantiate (particles, playerTransform.position, Quaternion.identity);
	}
}
