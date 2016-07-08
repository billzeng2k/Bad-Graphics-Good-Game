using UnityEngine;
using System.Collections;

public class Debuffs : MonoBehaviour {
	public Entity entity;
	// Use this for initialization
	void Start () {
		entity = this.gameObject.GetComponentInParent<Entity> ();
	}
	
	// Update is called once per frame
	void Update () {

	}

	public IEnumerator Burn(float damage, float time){
		for (int i = 0; i < 5; i++) {
			entity.setColor(Color.white);
			yield return new WaitForSeconds (time/10);
			entity.setColor(Color.red);
			entity.loseHealth (damage / 5);
			Color color = new Color(1, 0, 0, 1);
			particles (color);
			color = new Color(1, 0.5f, 0, 1f);
			particles (color);
			color = new Color(1, 1, 0, 1f);
			particles (color);
			yield return new WaitForSeconds (time/10);
		}
		entity.setColor(Color.white);
	}

	public void particles(Color color){
		GameObject particles = (GameObject)Resources.Load ("Prefabs/Death_Particles");
		particles.GetComponent<ParticleSystem>().startColor = color;
		Instantiate (particles, this.gameObject.transform.position, Quaternion.identity);
	}
}
