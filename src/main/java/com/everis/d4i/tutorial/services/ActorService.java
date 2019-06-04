package com.everis.d4i.tutorial.services;

import java.util.List;

import com.everis.d4i.tutorial.exceptions.NetflixException;
import com.everis.d4i.tutorial.json.ActorRest;
import com.everis.d4i.tutorial.json.CategoryRest;

public interface ActorService {
	List<ActorRest> getActors() throws NetflixException;
	ActorRest createActor(ActorRest actorRest) throws NetflixException;
}
