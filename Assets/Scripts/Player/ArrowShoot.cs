using UnityEngine;
using System.Collections;

public class ArrowShoot : MonoBehaviour {
	public Damage damage;
	public Transform arrowTransform;
	public Rigidbody2D arrowBody;
	float trueStartTime;
	float startTime;
	float BaseDamage;
	// Use this for initialization
	void Start () {
		trueStartTime = Time.time;
	}
	
	// Update is called once per frame
	void Update () {
		if (arrowBody.isKinematic)
			startTime = Time.time;
		if (Time.time - startTime >= 15f) {
			selfDestruct ();
		}
		damage.setDamage (BaseDamage * Mathf.Clamp ((startTime - trueStartTime) * 7f/2f, 0.5f, 7f));
		Vector2 v = arrowBody.velocity;
		float angle = Mathf.Atan2(v.y, v.x) * Mathf.Rad2Deg;
		if(!arrowBody.isKinematic) arrowTransform.rotation = Quaternion.AngleAxis(angle, Vector3.forward);
	}

	public void release(Vector2 direction){
		arrowBody.AddForce (direction * Mathf.Clamp((Time.time - trueStartTime) * 5000f/2f,0f, 5000f));
		arrowTransform.localScale = new Vector3 (Mathf.Abs (arrowTransform.localScale.x), arrowTransform.localScale.y, arrowTransform.localScale.z);
	}

	void OnTriggerEnter2D(Collider2D coll) {
		selfDestruct ();
	}

	void selfDestruct(){
		Color color = new Color(120f/255f, 68f/255f, 0f/255f, 1f);
		destroy (color);
		color = new Color(204f/255f, 4f/255f, 4f/255f, 1f);
		destroy (color);
		color = new Color(115f/255f, 115f/255f, 115f/255f, 1f);
		destroy (color);
		Destroy (this.gameObject);
	}

	public void destroy(Color color){
		GameObject particles = (GameObject)Resources.Load ("Prefabs/Death_Particles");
		particles.GetComponent<ParticleSystem>().startColor = color;
		Instantiate (particles, this.gameObject.transform.position, Quaternion.identity);
	}

	public void setDamage(float damage){
		BaseDamage = damage;
	}
}
