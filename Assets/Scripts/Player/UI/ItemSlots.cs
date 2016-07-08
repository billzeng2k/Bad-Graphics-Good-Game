using UnityEngine;
using System.Collections;
using UnityEngine.UI;
public class ItemSlots : MonoBehaviour {
	Item item;
	public Image imageIcon;
	public Image slot;
	void Update(){
		if (item == null) {
			imageIcon.sprite = null;
			imageIcon.color = new Color (1, 1, 1, 0);
		} else {
			imageIcon.sprite = item.itemIcon;
			imageIcon.color = Color.white;
		}
	}

	public void setItem(Item item){
		this.item = item;
	}

	public Item getItem(){
		return item;
	}

	public void activate(){
		slot.color = new Color (200f / 255f, 200f / 255f, 200f / 255f, 1);
	}

	public void deactivate(){
		slot.color = new Color (114f / 255f, 114f / 255f, 114f / 255f, 1);
	}
}
