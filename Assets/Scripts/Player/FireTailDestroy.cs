using UnityEngine;
using System.Collections;

public class FireTailDestroy : MonoBehaviour {
	public Transform myTransform;
	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
		myTransform.localScale = new Vector3 (myTransform.localScale.x - 0.07f, myTransform.localScale.x - 0.07f, 1);
		if (myTransform.localScale.x <= 0.5) {
			Destroy (this.gameObject);
		}
	}
}