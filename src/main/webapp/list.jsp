<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
<script src="https://cdn.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js"></script>
<!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js"></script>
<title>妖怪列表页</title>
<script type="text/javascript">
	$(function(){
		
		$(".delteId").click(function(){
			
			var $url=this.href;
			
			//通过表单拿到数据
			$("#deleteForm").attr("action",$url);
			
			//提交表单
			$("#deleteForm").submit();
			
			return false;
		});
	});
</script>
</head>
<body>
	<div class="container">
		<h1 align="center">妖怪管理系统----妖怪列表页</h1>
		<br><br>
			<table class="table table-bordered table-hover table-striped">
			<tr>
				<th>妖怪编号</th>
				<th>妖怪姓名</th>
				<th>妖怪邮箱</th>
				<th>妖怪生日</th>
				<th>入职时间</th>
				<th>门派名称</th>
				<th>点击删除</th>
				<th>点击修改</th>
			</tr>

			<c:forEach items="${pb.beanList }" var="m">
			<tr>
				<td>${m.monsterId }</td>
				<td>${m.monstername }</td>
				<td>${m.email }</td>
				<td>
				<fmt:formatDate value="${m.birthday }" pattern="yyyy-MM-dd"/>
				</td>
				<td>
				<fmt:formatDate value="${m.entryday }" pattern="yyyy-MM-dd"/>
				</td>
				<td>${m.school.name}</td>
				<td><a href="monster/${m.monsterId }" class="delteId btn btn-primary">删除</a></td>
				<td><a href="monster/${m.monsterId }" class="btn btn-danger">修改</a></td>
			</tr>
			</c:forEach>
			</table>
			<!-- 准备一个隐藏表单 -->
			<form action="" method="post" id="deleteForm">
				<input type="hidden" name="_method" value="DELETE"/>
			</form>
	</div>
	<hr>
		<center>
		<p>第${pb.pageNow }页/共${pb.pages }页
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<ul class="pagination">
				<li><a href="monsters?pageNow=1">首页</a></li>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<c:if test="${pb.pageNow>1 }">
					<li><a href="monsters?pageNow=${pb.pageNow-1 }">上一页</a></li>
				</c:if>
				<!-- 分两种情况		 
		   1.如果页数小于10
		   2.如果页数大于10 
		-->
				<c:choose>
					<c:when test="${pb.pages<=10 }">
						<c:set var="begin" value="1"></c:set>
						<c:set var="end" value="${pb.pages }"></c:set>
					</c:when>
					<c:otherwise>
						<c:set var="begin" value="${pb.pageNow-5 }"></c:set>
						<c:set var="end" value="${pb.pageNow+4 }"></c:set>
						<c:if test="${begin<=1 }">
							<c:set var="begin" value="1"></c:set>
							<c:set var="end" value="10"></c:set>
						</c:if>
						<c:if test="${end>=pb.pages }">
							<c:set var="begin" value="${pb.pageNow-9 }"></c:set>
							<c:set var="end" value="${pb.pages }"></c:set>
						</c:if>
					</c:otherwise>
				</c:choose>
				<!-- 循环十个数 -->
				<c:forEach begin="${begin }" end="${end }" var="i">
					<c:choose>
						<c:when test="${pb.pageNow==i }">
							<li class="active"><span>${i }</span></li>
						</c:when>
						<c:otherwise>
							<li><a href="monsters?pageNow=${i }">${i }</a></li>
						</c:otherwise>
					</c:choose>
				</c:forEach>

				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<c:if test="${pb.pageNow<pb.pages }">
					<li><a href="monsters?pageNow=${pb.pageNow+1 }">下一页</a></li>
				</c:if>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<li><a href="monsters?pageNow=${pb.pages }">尾页</a></li>
			</ul>

		</center>
		<hr>
	<div align="center"><a href="index.jsp" class="btn btn-primary">首页</a></div>
</body>
</html>