package com.nhnghia.dao.impl;

import java.util.List;

import org.apache.commons.lang3.StringUtils;

import com.nhnghia.dao.INewsDAO;
import com.nhnghia.mapper.NewsMapper;
import com.nhnghia.model.NewsModel;
import com.nhnghia.paging.IPageble;

public class NewsDAO extends AbstractDAO<NewsModel> implements INewsDAO {

	@Override
	public List<NewsModel> findByCategoryId(Long categoryId) {
		String sql = "SELECT * FROM news WHERE categoryid = ?;";
		
		return query(sql, new NewsMapper(), categoryId);
	}

	@Override
	public Long save(NewsModel newsModel) {
		StringBuilder sql = new StringBuilder("INSERT INTO news (title, thumbnail, shortdescription, ");
		sql.append("content, categoryid, createddate, createdby) ");
		sql.append("VALUES (?, ?, ?, ?, ?, ?, ?);");
		
		return insert(sql.toString(), newsModel.getTitle(), newsModel.getThumbnail(), newsModel.getShortDescription(),
				newsModel.getContent(), newsModel.getCategoryId(), newsModel.getCreatedDate(),
				newsModel.getCreatedBy());
	}

	@Override
	public NewsModel findOne(Long id) {
		String sql = "SELECT * FROM news WHERE id = ?";
		// query return a list, but we just need one. So we have List<NewsModel>, this
		// List just have one element index[0]
		List<NewsModel> news = query(sql, new NewsMapper(), id);

		// if news isEmpty -> null else news exist -> get index 0
		return news.isEmpty() ? null : news.get(0);
	}

	@Override
	public void update(NewsModel updateNewsModel) {
		StringBuilder sql = new StringBuilder("UPDATE news SET title = ?, thumbnail = ?, ");
		sql.append("shortdescription = ?, content = ?, categoryid = ?, ");
		sql.append("createddate = ?, createdby = ?, modifieddate = ?, modifiedby = ? WHERE id = ?;");
		update(sql.toString(), updateNewsModel.getTitle(), updateNewsModel.getThumbnail(),
				updateNewsModel.getShortDescription(), updateNewsModel.getContent(), updateNewsModel.getCategoryId(),
				updateNewsModel.getCreatedDate(), updateNewsModel.getCreatedBy(), updateNewsModel.getModifiedDate(),
				updateNewsModel.getModifiedBy(), updateNewsModel.getId());
	}

	@Override
	public void delete(long id) {
		String sql = "DELETE FROM news WHERE id = ?;";
		update(sql, id);
	}

	@Override
	public List<NewsModel> findAll(IPageble pageble) {
		StringBuilder sql = new StringBuilder("SELECT * FROM news");
		// StringUtils trong common-lang check sorter null và empty
		if (pageble.getSorter() != null && StringUtils.isNotBlank(pageble.getSorter().getSortName())
				&& StringUtils.isNotBlank(pageble.getSorter().getSortBy())) {
			sql.append(" ORDER BY " + pageble.getSorter().getSortName() + " " + pageble.getSorter().getSortBy() + "");
		}
		// check offset, limit avoid setParameter die
		if (pageble.getOffset() != null && pageble.getLimit() != null) {
			sql.append(" LIMIT " + pageble.getOffset() + ", " + pageble.getLimit() + "");
		}
		
		return query(sql.toString(), new NewsMapper());
	}

	@Override
	public int getTotalItems() {
		String sql = "SELECT count(*) FROM news;";
		
		return count(sql);
	}

}
