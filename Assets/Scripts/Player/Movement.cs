using UnityEngine;
using System.Collections;

public class Movement : MonoBehaviour {
	public GameObject player;
	PlayerVariables pv; 
	private bool idle = true;
	private KeyCode lastKeyPressed;
	private double timeKeyPressed;
	// Use this for initialization
	void Start () {
		pv = player.GetComponentInParent<PlayerVariables> ();
	}
	
	// Update is called once per frame
	void FixedUpdate () {
		if (Input.GetKey (GameVariables.up) && (pv.getGrounded() || pv.getWalled()) && (pv.getAction() < 4 || pv.getAction() > 7)) {
			pv.jump ();
			idle = false;
			lastKeyPressed = GameVariables.up;
			timeKeyPressed = Time.time;
		} else if (Input.GetKey (GameVariables.att) && ((Time.time - timeKeyPressed > 0.2f || lastKeyPressed != GameVariables.att || pv.weapon.getWeaponType() != 0))) {
			pv.attack ();
			idle = false;
			lastKeyPressed = GameVariables.att;
			timeKeyPressed = Time.time;
		} 
		if (Input.GetKey (GameVariables.evade) && (Time.time - timeKeyPressed > 0.5f || lastKeyPressed != GameVariables.evade) && !pv.stop) {
			idle = false;
			pv.evade ();
			lastKeyPressed = GameVariables.evade;
			timeKeyPressed = Time.time;
		} 

		//Walking Movement
		if (Input.GetKeyDown (GameVariables.right) && lastKeyPressed == GameVariables.right && Time.time - timeKeyPressed > 0) {
			//run
			pv.setDirection (1);
			pv.move ();
			pv.setSpeed (20f);
			idle = false;
		} else if (Input.GetKeyDown (GameVariables.left) && lastKeyPressed == GameVariables.left && Time.time - timeKeyPressed > 0) {
			//run
			pv.setDirection (-1);
			pv.move ();
			pv.setSpeed (20f);
			idle = false;
		} else if (Input.GetKeyDown (GameVariables.right)) {
			//intial press
			pv.setDirection (1);
			pv.move ();
			idle = false;
			lastKeyPressed = GameVariables.right;
			timeKeyPressed = Time.time;
		} else if (Input.GetKeyDown (GameVariables.left)) {
			//intial press
			pv.setDirection (-1);
			pv.move ();
			idle = false;
			lastKeyPressed = GameVariables.left;
			timeKeyPressed = Time.time;
		} else if (Input.GetKey (GameVariables.right) && lastKeyPressed == GameVariables.right) {
			//walk
			pv.setDirection (1);
			pv.move ();
			idle = false;
		} else if (Input.GetKey (GameVariables.left) && lastKeyPressed == GameVariables.left) {
			//walk
			pv.setDirection (-1);
			pv.move ();
			idle = false;
		} else if (Input.GetKey (GameVariables.right)) {
			//default
			pv.setDirection (1);
			pv.move ();
			idle = false;
		} else if (Input.GetKey (GameVariables.left)) {
			//default
			pv.setDirection (-1);
			pv.move ();
			idle = false;
		} else if (pv.getSpeed () == 20f) {
			//stop
			lastKeyPressed = KeyCode.None;
			pv.setSpeed (10f);
		} else if (pv.getSpeed () == 20f) {
			//stop
			lastKeyPressed = KeyCode.None;
			pv.setSpeed (10f);
		} 
		if (Time.time - timeKeyPressed > 1f) {
			lastKeyPressed = KeyCode.None;
		}
		if(idle) {
			pv.idle ();
		}
		idle = true;
		if(!Input.GetKey(GameVariables.att) && pv.getAction() >= 4 && pv.getAction() <= 6){
			pv.shoot (1f/4f);
		}
	}
}

