<%@page import="java.util.ArrayList"%>
<%@page import="kr.co.acorn.dao.HelpMeDao"%>
<%@page import="kr.co.acorn.util.ConnLocator"%>
<%@page import="kr.co.acorn.dto.HelpMeDto"%>
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

MemberDao da = MemberDao.getInstance();
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
    <div class="alert alert-primary" role="alert">
                  A simple primary alert—check it out!
                </div>
                <div class="alert alert-secondary" role="alert">
                  A simple secondary alert—check it out!
                </div>
        
        <dl class="row">
                  <dt class="col-sm-3">Description lists</dt>
                  <dd class="col-sm-9">A description list is perfect for defining terms.</dd>
                
                  <dt class="col-sm-3">Euismod</dt>
                  <dd class="col-sm-9">
                    <p>Vestibulum id ligula porta felis euismod semper eget lacinia odio sem nec elit.</p>
                    <p>Donec id elit non mi porta gravida at eget metus.</p>
                  </dd>
                
                  <dt class="col-sm-3">Malesuada porta</dt>
                  <dd class="col-sm-9">Etiam porta sem malesuada magna mollis euismod.</dd>
                
                  <dt class="col-sm-3 text-truncate">Truncated term is truncated</dt>
                  <dd class="col-sm-9">Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.</dd>
                
                  <dt class="col-sm-3">Nesting</dt>
                  <dd class="col-sm-9">
                    <dl class="row">
                      <dt class="col-sm-4">Nested definition list</dt>
                      <dd class="col-sm-8">Aenean posuere, tortor sed cursus feugiat, nunc augue blandit nunc.</dd>
                    </dl>
                  </dd>
                </dl>
    
    <!-- main end -->
<%@ include file="../inc/footer.jsp" %>