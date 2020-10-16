<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>

<c:url var="apiURL" value="/api/admin-news" />
<c:url var="newsURL" value="/admin-news" />

<html>

<head>
    <title>Edit news</title>
</head>

<body>
    <div class="main-content">
        <div class="main-content-inner">
            <div class="breadcrumbs" id="breadcrumbs">
                <script type="text/javascript">
                    try {
                        ace.settings.check('breadcrumbs', 'fixed')
                    } catch (e) {}
                </script>
                <ul class="breadcrumb">
                    <li>
                        <i class="ace-icon fa fa-home home-icon"></i>
                        <a href="#">Home</a>
                    </li>
                    <li class="active">Edit News</li>
                </ul><!-- /.breadcrumb -->
            </div>
            <div class="page-content">
                <div class="row">
                    <div class="col-xs-12">
                    	<c:if test="${not empty messageResponse}">
							<div class="alert alert-${alert}">
  								<strong>${messageResponse}</strong>
							</div>
						</c:if>
                        <form id="formSubmit">
                        	<br/>
	                        <br/>
                        	<div class="form-group">
	                            <label class="col-sm-3 control-label no-padding-right">Category</label>
	                            <div class="col-sm-9">
	                                <select class="form-control" id="categoryCode" name="categoryCode">
	                                <c:if test="${empty model.categoryCode}">
	                                	<option value="">Choose Category</option>
									    <c:forEach var="categoryItem" items="${categories}">
									    	<option value="${categoryItem.code}">${categoryItem.name}</option>
									    </c:forEach>
	                                </c:if>
	                                <c:if test="${not empty model.categoryCode}">
									    <option value="">Choose Category</option>
									    <c:forEach var="categoryItem" items="${categories}">
											<option value="${categoryItem.code}" <c:if test="${categoryItem.code == model.categoryCode}">selected="selected"</c:if>>
												${categoryItem.name}
											</option>   
									    </c:forEach>
	                                </c:if>
									</select>
	                            </div>
	                        </div>
	                        <br/>
	                        <br/>
	                        <div class="form-group">
	                            <label class="col-sm-3 control-label no-padding-right">Title</label>
	                            <div class="col-sm-9">
	                                <input type="text" class="form-control" id="title" name="title" value="${model.title}" />
	                            </div>
	                        </div>
	                        <br/>
	                        <br/>
	                        <div class="form-group">
	                            <label class="col-sm-3 control-label no-padding-right">Thumbnail</label>
	                            <div class="col-sm-9">
	                                <input type="text" class="form-control" id="thumbnail" name="thumbnail" value="" readonly="readonly"/>
	                            </div>
	                        </div>
	                        <br/>
	                        <br/>
	                        <div class="form-group">
	                            <label class="col-sm-3 control-label no-padding-right">Short Description</label>
	                            <div class="col-sm-9">
	                                <input type="text" class="form-control" id="shortDescription" name="shortDescription" value="${model.shortDescription}" />
	                            </div>
	                        </div>
	                        <br/>
	                        <br/>
	                        <div class="form-group">
	                            <label class="col-sm-3 control-label no-padding-right">Content</label>
	                            <div class="col-sm-9">
	                                <textarea rows="" cols="" id="content" name="content" style="width: 955px; height: 250px">${model.content}</textarea>
	                            </div>
	                        </div>
	                        <br/>
	                        <br/>
	                        <div class="form-group">
	                            <div class="col-sm-12">
	                            	<c:if test="${not empty model.id}">
	                            		<input type="button" class="btn btn-white btn-success btn-bold" value="Update News" id="btnAddOrUpdateNew"/>
	                            	</c:if>
	                            	<c:if test="${empty model.id}">
	                            		<input type="button" class="btn btn-white btn-success btn-bold" value="Create News" id="btnAddOrUpdateNew"/>
	                            	</c:if>
	                            </div>
	                        </div>
	                        <input type="hidden" value="${model.id}" id="id" name="id" />
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script>
    	
    	var editor = '';
   		$(document).ready(function(){
   			editor = CKEDITOR.replace('content');
    	});
    
		$('#btnAddOrUpdateNew').click(function (e) {
			// tránh submit nhầm url ở url đang đứng
			e.preventDefault();
			
			/* var categoryCode = $('#categoryCode').val();
			var title = $('#title').val();
			var thumbnail = $('#thumbnail').val();
			var shortDescription = $('#shortDescription').val();
			var content = $('#content').val(); */
			
			// data đang là javascript object
			var data = {};
			// lấy dữ liệu từ input thông qua name, thay cho đoạn code trên
			var formData = $('#formSubmit').serializeArray();
			$.each(formData, function (i, v) {
				data[""+v.name+""] = v.value;
				
			});
			
			// get data từ ckeditor vì serializeArray không get được dữ liệu từ ckeditor
			// "content" mapping với NewsModel
			data["content"] = editor.getData();
			
			var id = $('#id').val();
			if (id == "") {
				addNews(data);
			} else {
				updateNews(data);
			}
		});
		
		function addNews(data) {
			$.ajax({
				url: '${apiURL}',
				type: 'POST',
				// client -> server
				contentType: 'application/json',
				// javascript object -> json
				data: JSON.stringify(data),
				// server -> client
	            dataType: 'json',
	            // result chính là newsmodel trong controller tra ra 
	            success: function (result) {
	            	window.location.href = "${newsURL}?type=edit&id=" + result.id + "&message=insert_success";
	            },
				error: function (error) {
					window.location.href = "${newsURL}?type=list&maxPageItem=5&page=1&message=error_system";
				}
			});
		}
		
		function updateNews(data) {
			$.ajax({
				url: '${apiURL}',
				type: 'PUT',
				contentType: 'application/json',
				data: JSON.stringify(data),
	            dataType: 'json',
	            success: function (result) {
	            	window.location.href = "${newsURL}?type=edit&id=" + result.id + "&message=update_success";
	            },
				error: function (error) {
					window.location.href = "${newsURL}?type=list&maxPageItem=5&page=1&message=error_system";
				}
			});
		}
		
    </script>
    
</body>

</html>