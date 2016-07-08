using UnityEngine;
using System.Collections;

public class Damage : MonoBehaviour {
	public PlayerVariables pv;
	public float damage;
	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
		if (pv != null) {
			if (pv.getAction () == 1)
				damage = pv.baseDamage * 2f;
			else if (pv.getAction () == 2)
				damage = pv.baseDamage;
			else if (pv.getAction () == 3)
				damage = pv.baseDamage * 1.5f;
		}
	}

	public float getDamage(){
		return damage;
	}

	public void setDamage(float damage){
		this.damage = damage;
	}
}
