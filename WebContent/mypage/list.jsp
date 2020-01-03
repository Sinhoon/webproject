<%@page import="kr.co.acorn.dao.ListHelpDao"%>
<%@page import="kr.co.acorn.dto.ListHelpDto"%>
<%@page import="java.util.ArrayList"%>
<%@ page pageEncoding="utf-8"%>
<%@ include file="../inc/header.jsp"%>

<style>
	.border-styles > p{
		margin: 2px 0;
		padding: 1px 3px;
		border-width: 2px;
		border-color: #aaa;
	}
</style>
<script src="../js/jquery-3.4.1.js"></script>
<script>

/*--------------------- 카테고리 선택 ------------------------*/ 
$(function(){
	$("#ask").click();
 	playAlert = setInterval(function() {
			$("#ask").click();
			$(".bt").click();
			$(".hbt").click();
		}, 3000); 
	//clearInterval(playAlert);
	
		
	$("#ask").click(function(){
		let email = '<%=memberDto.getEmail()%>';
		let iscom = "미선택"
		let bt = ""
		let hbt = ""
		if ($('.bt').hasClass('able') == true ){
			bt = 'able';	
		}
		if ($('.hbt').hasClass('ables') == true ){
			hbt = 'ables';
		}
		$.ajax({
			type : 'POST',
		    url : 'asklist.jsp',
			data : {"start" :0,"length":5,"email":email},
			dataType : 'json',//xml, html
			error : function(){
				alert('Json Load Error');
			},
			success : function(obj){
				$(".table>tbody").html("");
				if (obj.length !=0){
				for(let i=0; i<obj.length;i++){
					if(obj[i].iscomplete == 1){iscom="진행중"}
					else{iscom="미선택"}
					$(".table>tbody").append("<tr><td>"+obj[i].num+"</td>"
							+"<td><button class='bt "+bt+"' id="+obj[i].num+">"+obj[i].title+"</button></td>"
							+"<td>"+ obj[i].regdate +"</td>" 
							+"<td><button class='hbt "+hbt+"'>"+obj[i].hmax+"명</td>" 
							+"<td>"+ iscom +"</td>" 
							+"<td><button class='sbt'>취소</button></td></tr>");
					}
					
	
				}

			}
		});
	});

	
/*--------------------- 상세보기------------------------*/ 
      $(document).on("click",".bt",function(event){
        // 동적으로 여러 태그가 생성된 경우라면 이런식으로 클릭된 객체를 this 키워드를 이용해서 잡아올 수 있다.
        let bt = $(this);
        let st = $(this).attr('id');
        $.ajax({
			//type : 'GET',
			//url : 'emp_json.jsp?start=0&length=10',
			type : 'POST',
		    url : '../help/showjson.jsp',
			data : {"num" :st},
			dataType : 'json',//xml, html
			error : function(){
				alert('Json Load Error');
			},
			success : function(obj){
				if (obj.length !=0){
					if($("#"+st).parent('td').children('div').text() != ""){
						$("#"+st).parent('td').children('div').remove('div');
						if($(".bt").hasClass("able") === true) {
							bt.removeClass('able');
						}else{
						}

					}else{
						$("#"+st).parent('td').append("<div class='form-group shadow-textarea'><textarea class='form-control z-depth-1' readonly='readonly' id='exampleFormControlTextarea6' rows='3' style='background-color: white;'>"
								+ obj.content +"</textarea></div>")
						if($(".bt").hasClass("able") === true) {
							
						}else{
							bt.addClass('able');
						}
						
						
					}
				}
			}
		});
      });


/*--------------------- 수락자 결정  ------------------------*/ 
      $(document).on("click",".hbt",function(event){
    	let num = $(this).closest('tr').find('button:first').attr('id');
    	let ts = $(this);
    	let text = "선택";
  		$.ajax({
  			//type : 'GET',
  			//url : 'emp_json.jsp?start=0&length=10',
  			type : 'POST',
  		    url : 'helperjson.jsp',
  			data : {"num":num},
  			dataType : 'json',//xml, html
  			error : function(){		
  				alert('Json Load Error');
  			},
  			success : function(obj){
				if (obj.length !=0){
					if(ts.parent('td').children('div').text() != ""){
						//ts.parent('td').children('div').remove('div');
					}else{
						ts.parent('td').append("<div class='table-responsive-lg'><table class='table table-hover'></table></div>")
						for(let i=0; i<obj.length;i++){
							if(obj[i].choice == 1){
								text ="취소";
							}else{
								text ="선택";
							}
							ts.parents('td').find('table').append("<tr><td>"+obj[i].phone+"</td><td>"+obj[i].gender+"</td><td>"
							+obj[i].addr +"</td><td><button class='choice' id="+obj[i].helper_email+">"+text+"</button></td></tr>")
						}
					}
				}
  			}
  		});
  	});

/*--------------------- 취소  ------------------------*/ 
$(document).on("click",".sbt",function(event){
	let num = $(this).closest('tr').find('button:first').attr('id');
		$.ajax({
			type : 'POST',
		    url : 'deletejson.jsp',
			data : {"num":num},
			dataType : 'json',//xml, html
			error : function(){		
				alert('Json Load Error');
			},
			success : function(obj){
				$("#ask").click()
			}
		});
	});

/*--------------------- 수락자 선택  및 취소  ------------------------*/ 
$(document).on("click",".choice",function(event){
	let num = $(this).closest('tr').parents('tr').children('td:first').text();
	let email = $(this).attr('id');
	let choice = $(this).text();
	let ts = $(this).closest('tr').parents('tr').children('td:nth-child(4)').find('button:first');
		$.ajax({
			type : 'POST',
		    url : 'choicejson.jsp',
			data : {"num":num,"email":email,"choice":choice},
			dataType : 'json',//xml, html
			error : function(){		
				alert('Json Load Error');
			},
			success : function(obj){
				//$("#ask").click();
				//document.getElementsByClassName("hbt")[0].click()
			}
		});
	});
	
});
</script>	

<!-- breadcrumb start-->
<nav aria-label="breadcrumb">
	<ol class="breadcrumb">
		<li class="breadcrumb-item"><a href="/index.jsp">HOME</a></li>
		<li class="breadcrumb-item active" aria-current="page">마이페이지</li>
	</ol>	
</nav>
<!-- breadcrumb end-->

<!-- main start -->
<div class="container">
	<div class="row">
		<div class="col-lg-12">
			<h3>
				마이리스트
			</h3>
			<div class="form-group row">
				<div class="col-sm-10">
					<button id="ask"> 요청 </button>
					<button> 수락 </button>
					<div id="categoryMessage"></div>
				</div>
			</div>
			<div class="table-responsive-lg">
				<p id="ct" style='display:none;'></p>
				<h5>
				요청리스트
				</h5>
				<table class="table table-hover" id="tble">
					<colgroup>
						<col width="5%" />
						<col width="20%" />
						<col width="10%" />
						<col width="35%" />
						<col width="7%" />
						<col width="7%" />
					</colgroup>
					<thead>
						<tr>
							<th scope="col">번호</th>
							<th scope="col">제목</th>
							<th scope="col">날짜</th>
							<th scope="col">남은 수락자수</th>
							<th scope="col">진행여부</th>
							<th scope="col">취소</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
		
			</div>
			
		</div>
	</div>
</div>
<!-- main end -->
<%@ include file="../inc/footer.jsp"%>