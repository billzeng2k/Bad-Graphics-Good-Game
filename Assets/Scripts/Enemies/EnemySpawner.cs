using UnityEngine;
using System.Collections;

public class EnemySpawner : MonoBehaviour {
	public string enemyPrefab;
	public int spawnChance = 500;
	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
		if(Random.Range(0, spawnChance) == 0 && GameObject.FindGameObjectWithTag ("Character") != null)
			Instantiate (Resources.Load ("Prefabs/" + enemyPrefab), this.gameObject.transform.position, Quaternion.identity);
	}
}
