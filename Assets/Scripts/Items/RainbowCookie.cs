using UnityEngine;
using System.Collections;

public class RainbowCookie : Consumables {
	public RainbowCookie(Sprite itemIcon, string name, string info) :base(itemIcon, name, info){

	}

	public override IEnumerator use(PlayerVariables p){
		for (int i = 0; i < 5; i++) {
			p.health.gainHealth (p.health.getBaseHealth() * 0.01f);
			yield return new WaitForSeconds (1f);
		}
	}
}
