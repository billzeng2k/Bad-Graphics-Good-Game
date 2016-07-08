using UnityEngine;
using System.Collections;
using UnityEngine.UI;
public class ManaUpdate : MonoBehaviour {
	public PlayerVariables mana;
	public Text text;
	// Use this for initialization
	void Start () {

	}

	// Update is called once per frame
	void Update () {
		if (mana == null) {
			if (this.gameObject.GetComponentInParent<ScaleUI> ().player != null)
				mana = this.gameObject.GetComponentInParent<ScaleUI> ().player.GetComponentInParent<PlayerVariables> ();
		} else {
			text.text = mana.mana + "/" + mana.manaPool;
			if (Input.GetKey (GameVariables.showHP)) {
				text.enabled = true;
			} else if (Input.GetKeyUp (GameVariables.showHP)) {
				text.enabled = false;
			}
		}
	}
}
