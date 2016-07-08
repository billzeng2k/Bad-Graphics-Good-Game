using UnityEngine;
using System.Collections;

public abstract class Consumables : Item {
	public Consumables(Sprite itemIcon, string name, string info){
		this.itemIcon = itemIcon;
		this.name = name;
		this.info = info;
	}

	public override abstract IEnumerator use (PlayerVariables p);
}
