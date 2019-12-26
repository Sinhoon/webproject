<%@page import="java.util.ArrayList"%>
<%@page import="kr.co.acorn.dao.ListHelpDao"%>
<%@page import="kr.co.acorn.util.ConnLocator"%>
<%@page import="kr.co.acorn.dto.ListHelpDto"%>
<%@page import="kr.co.acorn.dao.MemberDao"%>
<%@ include file="../inc/header.jsp" %>


<%@ page pageEncoding="utf-8"%>

<%
/* HelpMeDao dao = HelpMeDao.getInstance();
ArrayList<HelpMeDto> list =  dao.select(0,1);

for(HelpMeDto dto : list){
	out.print(dto.getTitle());
	out.print(dto.getContent());
	out.print(dto.getAddr()); 
} 

MemberDao dao = MemberDao.getInstance();
ArrayList<MemberDto> list1 =  da.select(0,1);
for(MemberDto dto : list1){
	out.print(dto.getName());	
}  */
%>
 <!-- breadcrumb start-->
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="/index.jsp">HOME</a></li>
          <li class="breadcrumb-item active" aria-current="page">LIBRARY</li>
        </ol>
      </nav>
    <!-- breadcrumb end-->    
    <!-- main start -->
    <div id="carouselExampleIndicators" class="carousel slide w-50 p-3"
   data-ride="carousel">
   <ol class="carousel-indicators">
      <li data-target="#carouselExampleIndicators" data-slide-to="0"
         class="active"></li>
      <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
      <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
   </ol>
   <div class="carousel-inner">
      <div class="carousel-item active">
         <img src="1.jpg" class="d-block w-100 p-3" >
      </div>
      <div class="carousel-item">
         <img src="2.jpg" class="d-block w-100 p-3" >
      </div>
      <div class="carousel-item">
         <img src="3.jpg" class="d-block w-100 p-3" >
      </div>
      <div class="carousel-item">
         <img src="4.png" class="d-block w-100 p-3" >
      </div>
      <div class="carousel-item">
         <img src="5.jpg" class="d-block w-100 p-3" >
      </div>
   </div>
   <a class="carousel-control-prev" href="#carouselExampleIndicators"
      role="button" data-slide="prev"> <span
      class="carousel-control-prev-icon" aria-hidden="true"></span> <span
      class="sr-only">Previous</span>
   </a> <a class="carousel-control-next" href="#carouselExampleIndicators"
      role="button" data-slide="next"> <span
      class="carousel-control-next-icon" aria-hidden="true"></span> <span
      class="sr-only">Next</span>
   </a>
</div>
    
    <!-- main end -->
<%@ include file="../inc/footer.jsp" %>