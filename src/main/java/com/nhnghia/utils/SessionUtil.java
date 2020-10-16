package com.nhnghia.utils;

import javax.servlet.http.HttpServletRequest;

public class SessionUtil {

	private static SessionUtil sessionUtil = null;

	// hàm này kiểm tra đối tượng SessionUtil đã tồn tại chưa
	public static SessionUtil getInstance() {
		if (sessionUtil == null) {
			sessionUtil = new SessionUtil();
		}
		
		return sessionUtil;
	}

	public void putValue(HttpServletRequest request, String key, Object value) {
		// đối tượng session được tạo ra từ HttpServletRequest
		request.getSession().setAttribute(key, value);
	}

	// dùng kiểu Object vì chúng ta chưa biết return về kiểu gì?
	public Object getValue(HttpServletRequest request, String key) {
		
		return request.getSession().getAttribute(key);
	}

	public void removeValue(HttpServletRequest request, String key) {
		request.getSession().removeAttribute(key);
	}

}
