using UnityEngine;
using System.Collections;
using UnityEngine.UI;
public class Description : MonoBehaviour {
	public Image icon;
	public Text title;
	public Text desc;
	
	// Update is called once per frame
	void Update () {
		if (DragHandler.itemBeingDragged == null) {
			icon.color = new Color (1, 1, 1, 0);
			icon.sprite = null;
			title.text = "Hover over an item";
			desc.text = "";
		} else if(DragHandler.itemBeingDragged.GetComponent<ItemSlots>().getItem() != null){
			icon.color = new Color (1, 1, 1, 1);
			icon.sprite = DragHandler.itemBeingDragged.GetComponent<ItemSlots>().getItem().itemIcon;
			title.text = DragHandler.itemBeingDragged.GetComponent<ItemSlots>().getItem().name;
			desc.text = DragHandler.itemBeingDragged.GetComponent<ItemSlots> ().getItem().info;
		}
	}
}
