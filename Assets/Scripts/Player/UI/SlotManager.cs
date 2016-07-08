using UnityEngine;
using System.Collections;
using UnityEngine.UI;
public class SlotManager : MonoBehaviour {
	public AllSprites sprites;
	public ItemSlots[] slots = new ItemSlots[4];
	public ItemSlots[] invSlots = new ItemSlots[4];
	public ItemSlots foodSlot;
	public ItemSlots invFoodSlot;
	public changeWeapon weapon;
	public PlayerVariables p;
	public Inventory i;
	int activeSlot = 0;
	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
		for(int i = 0; i < 4; i++)
			slots [i].setItem (invSlots[i].getItem());
		foodSlot.setItem(invFoodSlot.getItem ());
		if (weapon == null) {
			if (this.gameObject.GetComponentInParent<ScaleUI> ().player != null) {
				weapon = this.gameObject.GetComponentInParent<ScaleUI> ().player.GetComponentInChildren<changeWeapon> ();
				p = this.gameObject.GetComponentInParent<ScaleUI> ().player.GetComponent<PlayerVariables> ();
			}
		} else {
			weapon.weapon = (Weapon)slots [activeSlot].getItem ();
			for (int i = 0; i < 4; i++) {
				if (i == activeSlot)
					slots [i].activate ();
				else
					slots [i].deactivate ();
			}
			if (Input.GetKeyDown (GameVariables.changeWeapon)) {
				activeSlot = ++activeSlot % 4;
				weapon.weapon = (Weapon)slots [activeSlot].getItem ();
			}
			if (Input.GetKeyDown (KeyCode.Alpha1)) {
				activeSlot = 0;
				weapon.weapon = (Weapon)slots [activeSlot].getItem ();
			}
			if (Input.GetKeyDown (KeyCode.Alpha2)) {
				activeSlot = 1;
				weapon.weapon = (Weapon)slots [activeSlot].getItem ();
			}
			if (Input.GetKeyDown (KeyCode.Alpha3)) {
				activeSlot = 2;
				weapon.weapon = (Weapon)slots [activeSlot].getItem ();
			}
			if (Input.GetKeyDown (KeyCode.Alpha4)) {
				activeSlot = 3;
				weapon.weapon = (Weapon)slots [activeSlot].getItem ();
			}
			if ((Input.GetKeyDown (KeyCode.Alpha5) || Input.GetKeyDown (GameVariables.useItem)) && foodSlot.getItem() != null) {
				if (typeof(Consumables).IsAssignableFrom(foodSlot.getItem ().GetType ())) {
					StartCoroutine (foodSlot.getItem ().use (p));
					invFoodSlot.setItem (null);
					i.fillIn ();
				}
			}
		}
	}
}
