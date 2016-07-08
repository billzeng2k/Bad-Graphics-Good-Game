using UnityEngine;
using System.Collections;

public class GameVariables : MonoBehaviour {
	public static int kills = 0;
	public static int deaths = 0;
	public static bool characterAlive = true;
	public static KeyCode right = KeyCode.RightArrow;
	public static KeyCode left = KeyCode.LeftArrow;
	public static KeyCode up = KeyCode.UpArrow;
	public static KeyCode att = KeyCode.Z;
	public static KeyCode evade = KeyCode.X;
	public static KeyCode changeWeapon = KeyCode.C;
	public static KeyCode useItem = KeyCode.V;
	public static KeyCode showHP = KeyCode.Tab;
	public static KeyCode inv = KeyCode.I;
	public void FixedUpdate(){
		if (Input.GetKeyDown (KeyCode.S)) {
			Debug.Log ("Current Kills : " + kills + " Deaths : " + deaths);
		}
		if (!characterAlive && Random.Range (0, 300) == 0) {
			GameObject character = (GameObject)Instantiate (Resources.Load ("Prefabs/Character"), new Vector3(0, 0, 0), Quaternion.identity);
			character.name = "Character";
			character = null;
			characterAlive = true;
		}
	}
}
