using UnityEngine;
using System.Collections;

public class Weapon : Item {
	//0 melee, 1 Ranged, 2 Spell
	int weaponType;
	Color weaponColor;
	public Sprite[] weaponSprites;

	public Weapon(int weaponType, Sprite[] weaponSprites, Sprite itemIcon, string name, string info){
		this.weaponType = weaponType;
		this.weaponSprites = weaponSprites;
		this.itemIcon = itemIcon;
		weaponColor = Color.white;
		this.name = name;
		this.info = info;
	}

	public Weapon(int weaponType, Sprite[] weaponSprites, Sprite itemIcon, Color color, string name, string info){
		this.weaponType = weaponType;
		this.weaponSprites = weaponSprites;
		this.itemIcon = itemIcon;
		this.weaponColor = color;
		this.name = name;
		this.info = info;
	}

	public override int getType(){
		return weaponType;
	}

	public Color getColor(){
		return weaponColor;
	}
}
