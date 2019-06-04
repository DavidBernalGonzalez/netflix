package com.everis.d4i.tutorial.entities;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "ACTORSCHAPTERS")
public class ActorChapters implements Serializable{

	private static final long serialVersionUID = 5094716131716760965L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long ID;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CHAPTER_ID", nullable = false)
	private Chapter chapter;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "ACTOR_ID", nullable = false)
	private Actor actor;
}
