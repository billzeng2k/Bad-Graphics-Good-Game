using UnityEngine;
using System.Collections;

public class changeWeapon : MonoBehaviour {
	public Weapon weapon;
	public SpriteRenderer PlayerSR;
	public SpriteRenderer WeaponSR;
	public AllSprites sprites;
	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void FixedUpdate () {
		if(PlayerSR == null){
			if(GameObject.FindGameObjectWithTag ("Character") != null) PlayerSR = GameObject.FindGameObjectWithTag ("Character").GetComponentInParent<SpriteRenderer>();
		}
		if (sprites == null) {
			sprites = GameObject.FindGameObjectWithTag ("GameManager").GetComponent<AllSprites> ();
		}
		if (weapon != null) {
			WeaponSR.color = weapon.getColor ();
			for (int i = 0; i < sprites.Player.Length; i++) {
				if (PlayerSR.sprite == sprites.Player [i]) {
					WeaponSR.sprite = weapon.weaponSprites [i];
				}
			}
		} else {
			WeaponSR.sprite = null;
		}
	}

	public int getWeaponType(){
		if(weapon != null) return weapon.getType ();
		return -1;
	}
}
