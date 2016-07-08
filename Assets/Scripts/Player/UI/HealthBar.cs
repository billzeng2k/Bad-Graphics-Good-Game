using UnityEngine;
using System.Collections;

public class HealthBar : MonoBehaviour {
	public StoreHealth health;
	public RectTransform myTransform;
	public RectTransform barTransform;
	float baseHealth;
	float hp;
	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
		if(health == null){
			myTransform.localPosition = new Vector3 (-baseHealth, myTransform.localPosition.y, myTransform.localPosition.z);
			if (this.gameObject.GetComponentInParent<ScaleUI> ().player != null)
				health = this.gameObject.GetComponentInParent<ScaleUI> ().player.GetComponentInParent<StoreHealth> ();
		}
		else {
			baseHealth = health.getBaseHealth ();
			hp = health.getHealth ();
			myTransform.localPosition = new Vector3 (-(baseHealth - hp) * barTransform.rect.width / baseHealth, myTransform.localPosition.y, myTransform.localPosition.z);
		}
	}
}
