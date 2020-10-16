<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>

<!DOCTYPE html>
<div id="navbar" class="navbar navbar-default ace-save-state">
	<div class="navbar-container ace-save-state" id="navbar-container">
		<div class="navbar-header pull-left">
			<a href="#" class="navbar-brand"> <small> <i class="fa fa-leaf"></i>Management Page
				</small></a>
		</div>
		<div class="navbar-buttons navbar-header pull-right collapse navbar-collapse" role="navigation">
			<ul class="nav ace-nav">
				<li class="light-blue dropdown-modal"><a data-toggle="dropdown" href="#"
						class="dropdown-toggle">Welcome, ${USERMODEL.fullName}</a>
				</li>
				<li class="light-blue dropdown-modal"><a href='<c:url value="/logout?action=logout"/>'> <i
							class="ace-icon fa fa-power-off"></i>Logout</a>
				</li>
			</ul>
		</div>
	</div>
</div>