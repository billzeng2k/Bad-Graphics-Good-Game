using UnityEngine;
using System.Collections;

public class StoreHealth : MonoBehaviour {
	float health;
	float baseHealth;
		
	public StoreHealth(float health, float baseHealth){
		this.health = health;
		this.baseHealth = baseHealth;
	}

	public void setHealth (float health){
		this.health = health;
	}

	public float getHealth(){
		return health;
	}

	public void setBaseHealth (float baseHealth){
		this.baseHealth = baseHealth;
	}

	public float getBaseHealth(){
		return baseHealth;
	}

	public void loseHealth(float dmg){
		health -= dmg;
	}

	public void gainHealth(float hp){
		health += hp;
		if (health > baseHealth)
			health = baseHealth;
	}
}
