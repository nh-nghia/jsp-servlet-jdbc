<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>

<c:url var="apiURL" value="/api/admin-news" />
<c:url var="newsURL" value="/admin-news" />

<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>News list</title>
</head>

<body>
	<div class="main-content">
		<form action="<c:url value='/admin-news'/>" id="formSubmit" method="get">
			<div class="main-content-inner">
				<div class="breadcrumbs ace-save-state" id="breadcrumbs">
					<ul class="breadcrumb">
						<li><i class="ace-icon fa fa-home home-icon"></i><a href="#">Home</a></li>
					</ul>
					<!-- /.breadcrumb -->
				</div>
				<div class="page-content">
					<div class="row">
						<div class="col-xs-12">
							<c:if test="${not empty messageResponse}">
								<div class="alert alert-${alert}">
  									<strong>${messageResponse}</strong>
								</div>
							</c:if>
							<div class="widget-box table-filter">
								<div class="table-btn-controls">
									<div class="pull-right tableTools-container">
										<div class="dt-buttons btn-overlap btn-group">
											<a flag="info"
												class="dt-button buttons-colvis btn btn-white btn-primary btn-bold"
												data-toggle="tooltip" title='Create News'
												href='<c:url value="/admin-news?type=edit"/>'>
												<span>
													<i class="fa fa-plus-circle bigger-110 purple"></i>
												</span>
											</a>
											<button id="btnDelete" type="button"
												class="dt-button buttons-html5 btn btn-white btn-primary btn-bold"
												data-toggle="tooltip" title='Delete News'>
												<span>
													<i class="fa fa-trash-o bigger-110 pink"></i>
												</span>
											</button>
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-12">
									<div class="table-responsive">
										<table class="table table-striped">
											<thead>
												<tr>
													<th><input type="checkbox" id="checkAll"></th>
													<th>Title</th>
													<th>Short Description</th>
													<th>Content</th>
													<th>Created Date</th>
													<th>Modified Date</th>
													<th>Created By</th>
													<th>Modified By</th>
													<th>Action</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach var="newsItem" items="${model.listResult}">
													<tr>
														<td><input type="checkbox" id="checkbox_${newsItem.id}" value="${newsItem.id}"></td>
														<td>${newsItem.title}</td>
														<td>${newsItem.shortDescription}</td>
														<td>${newsItem.content}</td>
														<td>${newsItem.createdDate}</td>
														<td>${newsItem.modifiedDate}</td>
														<td>${newsItem.createdBy}</td>
														<td>${newsItem.modifiedBy}</td>
														<td>
															<c:url var="editURL" value="/admin-news">
																<c:param name="type" value="edit" />
																<c:param name="id" value="${newsItem.id}" />
															</c:url>
															<a class="btn btn-sm btn-primary btn-edit"
																data-toggle="tooltip" title="Update News"
																href='${editURL}'><i class="fa fa-pencil-square-o"
																	aria-hidden="true"></i>
															</a>
														</td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
										<ul class="pagination" id="pagination"></ul>
										<input type="hidden" value="" id="page" name="page" />
										<input type="hidden" value="" id="maxPageItem" name="maxPageItem" />
										<input type="hidden" value="" id="sortName" name="sortName" />
										<input type="hidden" value="" id="sortBy" name="sortBy" />
										<input type="hidden" value="" id="type" name="type" />
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
	<!-- /.main-content -->

	<script>
		var totalPages = ${model.totalPages};
		var currentPage = ${model.page};
		var limit = 5;
		$(function () {
			window.pagObj = $('#pagination').twbsPagination({
				totalPages: totalPages,
				visiblePages: 10,
				startPage: currentPage,
				onPageClick: function (event, page) {
					if (currentPage != page) {
						$('#page').val(page);
						$('#maxPageItem').val(limit);
						$('#sortName').val('title');
						$('#sortBy').val('asc');
						$('#type').val('list');
						$('#formSubmit').submit();
					}
				}
			});
		});
		
		$("#btnDelete").click(function() {
			var data = {};
			// tbody -> kiểm tra element có type là checkbox thì đánh dấu nó -> cái nào được tick get nó đưa vào mảng
			var ids = $('tbody input[type=checkbox]:checked').map(function () {
				return $(this).val();
			}).get();
			
			data['ids'] = ids;
			deleteNews(data);
		});
		
		function deleteNews(data) {
			$.ajax({
				url: '${apiURL}',
				type: 'DELETE',
				contentType: 'application/json',
				data: JSON.stringify(data),
	            success: function (result) {
	            	window.location.href = "${newsURL}?type=list&maxPageItem=5&page=1&sortName=title&sortBy=asc&message=delete_success";
	            },
				error: function (error) {
					window.location.href = "${newsURL}?type=list&maxPageItem=5&page=1&sortName=title&sortBy=asc&message=error_system";
				}
			});
		}
	</script>

</body>

</html>