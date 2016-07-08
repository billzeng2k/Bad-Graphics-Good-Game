using UnityEngine;
using System.Collections;
public class Item {
	public Sprite itemIcon;
	public string name;
	public string info;
	public virtual int getType(){
		return -1;
	}
	public virtual IEnumerator use(PlayerVariables p){
		yield return new WaitForSeconds (0);
	}
}
