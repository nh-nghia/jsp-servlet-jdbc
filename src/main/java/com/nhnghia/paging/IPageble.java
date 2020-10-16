package com.nhnghia.paging;

import com.nhnghia.sorting.Sorter;

public interface IPageble {
	
	Integer getPage();
	
	Integer getOffset();
	
	Integer getLimit();
	
	Sorter getSorter();

}
