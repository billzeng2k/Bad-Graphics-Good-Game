using UnityEngine;
using System.Collections;
using UnityEngine.EventSystems;
using UnityEngine.UI;
public class DragHandler : MonoBehaviour, IBeginDragHandler, IDragHandler, IEndDragHandler, IPointerEnterHandler, IPointerExitHandler {
	public static GameObject itemBeingDragged;
	Vector3 startPosition;
	public static bool drag = false;
	#region IBeginDragHandler implementation

	public void OnBeginDrag (PointerEventData eventData)
	{
		itemBeingDragged = gameObject;
		startPosition = transform.position;
		itemBeingDragged.GetComponent<Image> ().raycastTarget = false;
		itemBeingDragged.transform.parent.SetAsLastSibling ();
		drag = true;
	}

	#endregion

	#region IDragHandler implementation

	public void OnDrag (PointerEventData eventData)
	{
		transform.position = Input.mousePosition;
	}

	#endregion

	#region IEndDragHandler implementation

	public void OnEndDrag (PointerEventData eventData)
	{
		itemBeingDragged.GetComponent<Image> ().raycastTarget = true;
		transform.position = startPosition;
		itemBeingDragged = null;
		drag = false;
	}

	#endregion

	#region IPointerEnterHandler implementation

	public void OnPointerEnter (PointerEventData eventData)
	{
		if (itemBeingDragged == null && !drag)
			itemBeingDragged = gameObject;
	}

	#endregion

	#region IPointerExitHandler implementation

	public void OnPointerExit (PointerEventData eventData)
	{
		if (!drag)
			itemBeingDragged = null;
	}

	#endregion


}
