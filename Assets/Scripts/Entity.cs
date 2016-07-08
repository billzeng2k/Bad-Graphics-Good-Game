using UnityEngine;
using System.Collections;

public abstract class Entity : MonoBehaviour {
	public float localTimeScale = 1;
	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}

	public abstract float getHealth ();
	public abstract void loseHealth (float health);
	public abstract void gainHealth (float health);
	public abstract void setColor (Color color);
	public abstract float getDamage();
	public void setLocalTimeScale(float localTimeScale){
		this.localTimeScale = localTimeScale;
	}
}
