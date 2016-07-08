using UnityEngine;
using System.Collections;

public class Goblin : Enemy {
	bool attack = false;
	private int direction = 1;
	// Use this for initialization

	void Start () {
		OutlineEffect Outline = GameObject.FindGameObjectWithTag ("MainCamera").GetComponent<OutlineEffect> ();
		if (Outline != null) {
			Outline.outlineRenderers.Add (enemyRenderer);
			Outline.outlineRendererColors.Add (0);
		}
		player = GameObject.FindGameObjectWithTag ("Character");
		playerTransform = player.transform;
		int scale = Random.Range (14, 20);
		enemyTransform.localScale = new Vector3 (scale, scale, 1);
		health.setBaseHealth (Random.Range (6, 11) * 25);
		health.setHealth (health.getBaseHealth());
		damage = Random.Range (25, 50);
		speed = Random.Range (7, 10);
		jumpForce = Random.Range (600, 700);
	}

	void FixedUpdate(){
		if (health.getHealth() <= 0) {
			Color color = new Color(30f/255f, 199f/255f, 12f/255f, 1f);
			createDeathParticles (color);
			color = new Color(155f/255f, 93f/255f, 12f/255f, 1f);
			createDeathParticles (color);
			color = new Color(143f/255f, 143f/255f, 143f/255f, 1f);
			createDeathParticles (color);
			Destroy (this.gameObject);
		}
		if(player == null || player.name.Contains("Clone")){
			Destroy(player);
			player = GameObject.FindGameObjectWithTag ("Character");
			if(player != null) playerTransform = player.transform;
		}
		if (player != null) {
			grounded = Physics2D.OverlapCircle (groundCheck.position, groundCheckRadius, whatIsGround);
			walled = Physics2D.OverlapCircle (wallCheck.position, wallCheckRadius, whatIsGround);
			if (walled && grounded) {
				enemyBody.AddForce (Vector2.up * jumpForce * localTimeScale);
			}
			if (!grounded && enemyBody.velocity.magnitude > 0 && enemyBody.gravityScale < 5) {
				enemyBody.gravityScale += 0.05f;
			} else {						
				enemyBody.gravityScale = 1;
			}
			if (!attack)
				enemyTransform.localScale = new Vector3 (Mathf.Abs (enemyTransform.localScale.x) * direction, enemyTransform.localScale.y, enemyTransform.localScale.z);
			if (attack)
				anim.SetInteger ("Action", 1);
			else
				anim.SetInteger ("Action", -1);
			if (playerTransform.position.x > enemyTransform.position.x)
				direction = 1;
			else
				direction = -1;
			move ();
		}
	}

	void OnTriggerEnter2D(Collider2D collider) {
		if (collider.gameObject.tag == "PlayerHitBox") {
			health.loseHealth(collider.gameObject.GetComponent<Damage> ().getDamage ());
			StartCoroutine (getHit (0.2f));
		}
	}

	void move(){
		float distance = Vector3.Distance(playerTransform.position, enemyTransform.position);
		if (distance <= 0.32 * enemyTransform.localScale.y && !attack) {
			attack = true;
			anim.SetInteger ("Action", 1);
			StartCoroutine (attackReset (1f));
		} else if(distance < 50f && !attack && !walled){
			anim.SetInteger ("Action", 0);
			enemyTransform.transform.Translate (Vector3.right * speed * direction * Time.deltaTime * localTimeScale);
		}
	}

	IEnumerator attackReset(float time){
		yield return new WaitForSeconds (time);
		attack = false;
	}

	IEnumerator getHit(float time){
		enemyRenderer.color = new Color (1f, 0.5f, 0.5f, 1f);
		yield return new WaitForSeconds (time);
		enemyRenderer.color = new Color (1f, 1f, 1f, 1f);
	}
}
