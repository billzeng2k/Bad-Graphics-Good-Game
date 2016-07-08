using UnityEngine;
using System.Collections;

public class Fireball : MonoBehaviour {
	public SpriteRenderer fireball;
	public Transform myTransform;
	public GameObject tail;
	private float startTime;
	// Use this for initialization
	void Start () {
		fireball.color = new Color (1, 0, 0, 1f);
		tail = (GameObject) Resources.Load ("Prefabs/FireBallTail");
		startTime = Time.time;
	}
	
	// Update is called once per frame
	void FixedUpdate () {
		if (Time.time - startTime >= 10f)
			selfDestruct ();
		myTransform.Rotate(new Vector3(0, 0, 60));
		GameObject flame = (GameObject)Instantiate (tail, new Vector3 (myTransform.position.x - Random.Range (0, fireball.bounds.size.x*50)/100, myTransform.position.y - Random.Range (0, fireball.bounds.size.y*50)/100, 0), myTransform.rotation);
//		flame.transform.rotation = Quaternion.Euler (0, 0, Random.Range (0, 6) * 60f);
		float rand = (Random.Range (0, 20) * 0.1f) + 4f;
		flame.transform.localScale = new Vector3 (rand, rand, 1);
		flame.GetComponent<SpriteRenderer> ().color = new Color (1, Random.Range (0, 3) * 0.5f, 0, 1);
		flame = null;
	}

	void OnTriggerEnter2D(Collider2D coll) {
		if (coll.gameObject.tag == "Enemy") {
			coll.gameObject.GetComponentInParent<Debuffs>().StartCoroutine (coll.gameObject.GetComponentInParent<Debuffs>().Burn (this.gameObject.GetComponentInParent<Damage>().getDamage() * 1.5f, 5f));
		}
		selfDestruct ();
	}

	void selfDestruct(){
		Color color = new Color(1, 0, 0, 1);
		destroy (color);
		color = new Color(1, 0.5f, 0, 1f);
		destroy (color);
		color = new Color(1, 1, 0, 1f);
		destroy (color);
		Destroy (this.gameObject);
	}

	public void destroy(Color color){
		GameObject particles = (GameObject)Resources.Load ("Prefabs/Death_Particles");
		particles.GetComponent<ParticleSystem>().startColor = color;
		Instantiate (particles, this.gameObject.transform.position, Quaternion.identity);
	}
}
