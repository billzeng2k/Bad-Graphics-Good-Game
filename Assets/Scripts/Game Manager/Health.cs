using UnityEngine;
using System.Collections;

public class Health : MonoBehaviour {
	public StoreHealth script;
	public GameObject redBar;
	public float health;
	public float baseHealth; 
	// Use this for initialization
	void Start () {
		script = this.gameObject.GetComponentInParent<StoreHealth> ();
		baseHealth = script.getBaseHealth ();
		health = script.getHealth ();
		this.gameObject.GetComponent<SpriteRenderer> ().enabled = false;
		redBar.GetComponent<SpriteRenderer> ().enabled = false;
	}
	
	// Update is called once per frame
	void Update () {
		if(script == null) script = this.gameObject.GetComponentInParent<StoreHealth> ();
		baseHealth = script.getBaseHealth ();
		if (health != script.getHealth ()) {
			health = script.getHealth ();
			this.gameObject.GetComponent<SpriteRenderer> ().enabled = true;
			redBar.GetComponent<SpriteRenderer> ().enabled = true;
			StopAllCoroutines ();
			StartCoroutine (showBar (3f));
		}
		this.gameObject.transform.localScale = new Vector3 (-health / baseHealth, this.gameObject.transform.localScale.y, this.gameObject.transform.localScale.z);
		this.gameObject.transform.position = new Vector3(redBar.transform.position.x + (redBar.GetComponent<SpriteRenderer> ().bounds.size.x - this.gameObject.GetComponent<SpriteRenderer> ().bounds.size.x)/2 , redBar.transform.position.y, redBar.transform.position.z);
	}

	IEnumerator showBar(float waitTime){
		yield return new WaitForSeconds (waitTime);
		this.gameObject.GetComponent<SpriteRenderer> ().enabled = false;
		redBar.GetComponent<SpriteRenderer> ().enabled = false;
	}
}
