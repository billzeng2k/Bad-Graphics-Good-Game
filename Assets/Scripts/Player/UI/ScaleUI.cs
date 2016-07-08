using UnityEngine;
using System.Collections;
using UnityEngine.UI;
public class ScaleUI : MonoBehaviour {
	public CanvasScaler canvasSize;
	public GameObject player;
	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
		if(player == null || player.name.Contains("Clone")){
			if(player != null) Destroy(player);
			player = GameObject.FindGameObjectWithTag ("Character");
		}
		canvasSize.scaleFactor = Screen.width/1534f;
	}
}
