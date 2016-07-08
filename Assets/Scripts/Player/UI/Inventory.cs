using UnityEngine;
using System.Collections;
using UnityEngine.UI;
public class Inventory : MonoBehaviour {
	public AllSprites gm;
	public GameObject inventory;
	public ItemSlots[] itemsSlots = new ItemSlots[5];
	public ItemSlots[] spellSlots = new ItemSlots[5];
	public ItemSlots[] invSlots = new ItemSlots[10];
	public bool[] spells = new bool[5];
	// Use this for initialization
	void Start () {
		itemsSlots [0].setItem (gm.bow);
		itemsSlots [1].setItem (gm.sword);
		invSlots [0].setItem (gm.rainbowCookie);
		invSlots [1].setItem (gm.rainbowCookie);
		invSlots [2].setItem (gm.rainbowCookie);
		activateSpell (0);
	}
	
	// Update is called once per frame
	void Update () {
		if (Input.GetKeyDown (GameVariables.inv)) {
			inventory.SetActive (!inventory.activeSelf);
			if (Time.timeScale == 0)
				Time.timeScale = 1;
			else
				Time.timeScale = 0;
		}
	}

	public void fillIn(){
		if (itemsSlots [4].getItem () == null) {
			for (int i = 0; i < 10; i++) {
				if (invSlots [i].getItem() != null) {
					itemsSlots [4].setItem (invSlots [i].getItem ());
					invSlots [i].setItem (null);
					break;
				}
			}
		}
	}

	void activateSpell(int key){
		switch (key) {
		case 0:
			spellSlots [0].setItem (gm.firebolt);
			break;
		case 1:
			break;
		case 2:
			break;
		case 3:
			break;
		case 4:
			break;
		}
	}
}
