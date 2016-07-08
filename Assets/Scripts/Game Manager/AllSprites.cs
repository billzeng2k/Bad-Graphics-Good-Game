using UnityEngine;
using System.Collections;

public class AllSprites : MonoBehaviour {
	public Sprite[] Player;
	public Sprite[] Sword;
	public Sprite[] Bow;
	public Sprite[] Spells;
	public Sprite[] ItemIcons;
	public Weapon sword;
	public Weapon bow;
	public Weapon firebolt;
	public RainbowCookie rainbowCookie;

	public Camera playerCamera;
	public Camera wideCamera;
	// Use this for initialization
	void Start () {
		Physics2D.IgnoreLayerCollision (9, 10, true);
		Physics2D.IgnoreLayerCollision (9, 9, true);
		Physics2D.IgnoreLayerCollision (10, 11, true);
		Physics2D.IgnoreLayerCollision (11, 11, true);
		sword = new Weapon (0, Sword, ItemIcons[0], "Sword", "On a scale from one to sword it's pretty sword");
		bow = new Weapon (1, Bow, ItemIcons[1], "Bow", "Don't worry about ammo it takes too long to program anyways\nUp to x5dmg");
		firebolt = new Weapon(2, Spells, ItemIcons[2], new Color(1, 0, 0, 1), "Fireball", "The most mainstream spell\nDeals 1.5 dmg over 5 seconds after hit");
		rainbowCookie = new RainbowCookie (ItemIcons [3], "Rainbow Cookie", "Taste the rainbow!\nHeals 5% of max health over 5 seconds");
	}

	void Update(){
		if (playerCamera == null) {
			wideCamera.enabled = true;
			if(GameObject.FindGameObjectWithTag ("MainCamera") != null) playerCamera = GameObject.FindGameObjectWithTag ("MainCamera").GetComponent<Camera> ();
		}
		else
			wideCamera.enabled = false;
	}
}
