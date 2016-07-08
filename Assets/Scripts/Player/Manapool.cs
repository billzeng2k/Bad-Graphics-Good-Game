using UnityEngine;
using System.Collections;

public class Manapool : MonoBehaviour {
	public PlayerVariables mana;
	public RectTransform myTransform;
	public RectTransform barTransform;
	float baseMana;
	float mn;
	// Use this for initialization
	void Start () {

	}

	// Update is called once per frame
	void Update () {
		if(mana == null){
			myTransform.localPosition = new Vector3 (-baseMana, myTransform.localPosition.y, myTransform.localPosition.z);
			if (this.gameObject.GetComponentInParent<ScaleUI> ().player != null)
				mana = this.gameObject.GetComponentInParent<ScaleUI> ().player.GetComponentInParent<PlayerVariables> ();
		}
		if (mana != null) {
			baseMana = mana.manaPool;
			mn = mana.mana;
			myTransform.localPosition = new Vector3 (-(baseMana - mn) * barTransform.rect.width / baseMana, myTransform.localPosition.y, myTransform.localPosition.z);
		} 
	}
}
