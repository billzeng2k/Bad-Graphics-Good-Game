using UnityEngine;
using System.Collections;
using UnityEngine.EventSystems;
public class InventorySlot : MonoBehaviour, IDropHandler {
	public int restriction = -1;
	// -1 anything
	// 0 only items
	// > 0 only weapons
	#region IDropHandler implementation
	public void OnDrop (PointerEventData eventData)
	{
		if (DragHandler.itemBeingDragged.GetComponent<InventorySlot> () == null) {
			if (restriction > 0 && DragHandler.itemBeingDragged.GetComponent<ItemSlots> ().getItem ().GetType () == typeof(Weapon) && (GetComponent<ItemSlots> ().getItem () == null || GetComponent<ItemSlots> ().getItem ().getType () == 2)) {
				GetComponent<ItemSlots> ().setItem (DragHandler.itemBeingDragged.GetComponent<ItemSlots> ().getItem ());
			}
		} else if ((restriction == 0 && DragHandler.itemBeingDragged.GetComponent<ItemSlots> ().getItem ().GetType () != typeof(Weapon)) || (DragHandler.itemBeingDragged.GetComponent<InventorySlot> ().restriction == 0 && GetComponent<InventorySlot> ().restriction <= 0 && (GetComponent<ItemSlots> ().getItem () == null || GetComponent<ItemSlots> ().getItem ().GetType () != typeof(Weapon)))) {
			Item temp = GetComponent<ItemSlots> ().getItem ();
			GetComponent<ItemSlots> ().setItem (DragHandler.itemBeingDragged.GetComponent<ItemSlots> ().getItem ());
			DragHandler.itemBeingDragged.GetComponent<ItemSlots> ().setItem (temp);
		} else if (restriction == DragHandler.itemBeingDragged.GetComponent<InventorySlot> ().restriction) {
			Item temp = GetComponent<ItemSlots> ().getItem ();
			GetComponent<ItemSlots> ().setItem (DragHandler.itemBeingDragged.GetComponent<ItemSlots> ().getItem ());
			DragHandler.itemBeingDragged.GetComponent<ItemSlots> ().setItem (temp);
		} else if (restriction == -1 && DragHandler.itemBeingDragged.GetComponent<InventorySlot> ().restriction > 0) {
			if((GetComponent<ItemSlots> ().getItem () == null || GetComponent<ItemSlots> ().getItem ().GetType() == typeof(Weapon)) && DragHandler.itemBeingDragged.GetComponent<ItemSlots> ().getItem ().getType() != 2){
				Item temp = GetComponent<ItemSlots> ().getItem ();
				GetComponent<ItemSlots> ().setItem (DragHandler.itemBeingDragged.GetComponent<ItemSlots> ().getItem ());
				DragHandler.itemBeingDragged.GetComponent<ItemSlots> ().setItem (temp);
			}
		} else if (restriction > 0 && DragHandler.itemBeingDragged.GetComponent<InventorySlot> ().restriction == -1) {
			if (DragHandler.itemBeingDragged.GetComponent<ItemSlots> ().getItem ().getType () >= 0 && (GetComponent<ItemSlots> ().getItem () == null || GetComponent<ItemSlots> ().getItem ().getType () == 2)) {
				GetComponent<ItemSlots> ().setItem (DragHandler.itemBeingDragged.GetComponent<ItemSlots> ().getItem ());
				DragHandler.itemBeingDragged.GetComponent<ItemSlots> ().setItem (null);
			}
			else if((DragHandler.itemBeingDragged.GetComponent<ItemSlots> ().getItem () == null || DragHandler.itemBeingDragged.GetComponent<ItemSlots> ().getItem ().GetType() == typeof(Weapon)) && DragHandler.itemBeingDragged.GetComponent<ItemSlots> ().getItem ().getType() != 2){
				Item temp = GetComponent<ItemSlots> ().getItem ();
				GetComponent<ItemSlots> ().setItem (DragHandler.itemBeingDragged.GetComponent<ItemSlots> ().getItem ());
				DragHandler.itemBeingDragged.GetComponent<ItemSlots> ().setItem (temp);
			} 
		}
	}
	#endregion
}
