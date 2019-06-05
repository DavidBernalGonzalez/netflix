package com.everis.d4i.tutorial.services.impl;

import java.util.List;
import java.util.stream.Collectors;

import javax.persistence.EntityNotFoundException;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.everis.d4i.tutorial.exceptions.NetflixException;
import com.everis.d4i.tutorial.exceptions.NotFoundException;
import com.everis.d4i.tutorial.json.ActorRest;
import com.everis.d4i.tutorial.json.TvShowRest;
import com.everis.d4i.tutorial.repositories.ActorRepository;
import com.everis.d4i.tutorial.services.ActorService;

@Service
public class ActorServiceImpl implements ActorService {
	@Autowired
	private ActorRepository actorRepository;

	private ModelMapper modelMapper = new ModelMapper();

	@Override
	public List<ActorRest> getActors() throws NetflixException {
		return actorRepository.findAll().stream().map(actor -> modelMapper.map(actor, ActorRest.class))
				.collect(Collectors.toList());

//		List<Actor> actors = actorRepository.findAll();
//		List<ActorRest> actorsRest = new ArrayList<>();
//		for (Actor actor2 : actors) {
//			actorsRest.add(modelMapper.map(actor2, ActorRest.class));
//		}
//		return actorsRest;
	}

	@Override
	public ActorRest createActor(ActorRest actorRest) throws NetflixException {;
		return null;
	}

	@Override
	public ActorRest getActorById(Long id) throws NetflixException {

		try {
			return modelMapper.map(actorRepository.getOne(id), ActorRest.class);
		} catch (EntityNotFoundException entityNotFoundException) {
			throw new NotFoundException(entityNotFoundException.getMessage());
		}

	}

}
