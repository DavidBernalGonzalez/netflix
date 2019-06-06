package com.everis.d4i.tutorial.services.impl;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityNotFoundException;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.everis.d4i.tutorial.entities.TvShow;
import com.everis.d4i.tutorial.entities.TvShowCategory;
import com.everis.d4i.tutorial.exceptions.NetflixException;
import com.everis.d4i.tutorial.exceptions.NotFoundException;
import com.everis.d4i.tutorial.json.CategoryRest;
import com.everis.d4i.tutorial.json.TvShowRest;
import com.everis.d4i.tutorial.repositories.TvShowRepository;
import com.everis.d4i.tutorial.services.TvShowService;

@Service
public class TvShowServiceImpl implements TvShowService {

	@Autowired
	private TvShowRepository tvShowRepository;

	private ModelMapper modelMapper = new ModelMapper();

	@Override
	public List<TvShowRest> getTvShowsByCategory(Long categoryId) throws NetflixException {
		try {
			List<TvShow> tvShowList = tvShowRepository.findByTvShowCategoryCategoryId(categoryId);
			List<TvShowRest> tvShowsRestList = new ArrayList<>();
			for (TvShow tvShow : tvShowList) {
				TvShowRest tvShowRest = new TvShowRest();
				tvShowRest.setId(tvShow.getId());
				tvShowRest.setName(tvShow.getName());
				tvShowRest.setShortDescription(tvShow.getShortDescription());
				tvShowRest.setLongDescription(tvShow.getLongDescription());
				tvShowRest.setYear(tvShow.getYear());
				tvShowRest.setRecommendedAge(tvShow.getRecommendedAge());

				List<CategoryRest> categoryRestList = new ArrayList<>();
				List<TvShowCategory> tvShowsCategoriesList = tvShow.getTvShowCategory();
				for (TvShowCategory tvShowsCategories : tvShowsCategoriesList) {
					categoryRestList.add(modelMapper.map(tvShowsCategories.getCategory(), CategoryRest.class));
				}
				tvShowRest.setCategories(categoryRestList);
				tvShowsRestList.add(tvShowRest);
			}
			return tvShowsRestList;
		} catch (EntityNotFoundException entityNotFoundException) {
			throw new NotFoundException(entityNotFoundException.getMessage());
		}
	}

	@Override
	public TvShowRest getTvShowById(Long id) throws NetflixException {
		try {
			TvShow tvShow = tvShowRepository.getOne(id);
			TvShowRest tvShowRest = new TvShowRest();
			tvShowRest.setId(tvShow.getId());
			tvShowRest.setName(tvShow.getName());
			tvShowRest.setShortDescription(tvShow.getShortDescription());
			tvShowRest.setLongDescription(tvShow.getLongDescription());
			tvShowRest.setYear(tvShow.getYear());
			tvShowRest.setRecommendedAge(tvShow.getRecommendedAge());

			List<CategoryRest> categoryRestList = new ArrayList<>();
			List<TvShowCategory> tvShowsCategories2 = tvShow.getTvShowCategory();
			for (TvShowCategory tvShowsCategories : tvShowsCategories2) {
				categoryRestList.add(modelMapper.map(tvShowsCategories.getCategory(), CategoryRest.class));
			}
			tvShowRest.setCategories(categoryRestList);
			return tvShowRest;
		} catch (EntityNotFoundException entityNotFoundException) {
			throw new NotFoundException(entityNotFoundException.getMessage());
		}
	}
}
