using UnityEngine;
using System.Collections;

public class FollowCharacter : MonoBehaviour {
	public Transform myTransform;
	public Transform follow;
	public SpriteRenderer size;
	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
		myTransform.position = new Vector3 (follow.position.x, follow.position.y + size.bounds.size.y/2 + 1f, follow.position.z);
	}
}
