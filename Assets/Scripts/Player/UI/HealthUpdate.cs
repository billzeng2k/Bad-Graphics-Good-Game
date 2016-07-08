using UnityEngine;
using System.Collections;
using UnityEngine.UI;

public class HealthUpdate : MonoBehaviour {
	public StoreHealth health;
	public Text text;
	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
		if (health == null) {
			if (this.gameObject.GetComponentInParent<ScaleUI> ().player != null)
				health = this.gameObject.GetComponentInParent<ScaleUI> ().player.GetComponentInParent<StoreHealth> ();
		} else {
			text.text = health.getHealth () + "/" + health.getBaseHealth ();
			if (Input.GetKey (GameVariables.showHP)) {
				text.enabled = true;
			} else if (Input.GetKeyUp (GameVariables.showHP)) {
				text.enabled = false;
			}
		}
	}
}
