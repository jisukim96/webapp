<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- 필요한 라이브러리 import -->
<%@ page import = "java.sql.*,java.util.*,java.text.*" %>

<!-- DB include -->
<%@ include file = "conn_oracle.jsp" %>

<!--  form에서 넘어오는 값의 한글 처리 -->
<% request.setCharacterEncoding("UTF-8"); %>

<!-- form에서 넘어오는 데이터는 모두 String으로 넘어온다. 
	Integer.parseInt()
	Double.parseDouble()
-->

<!-- form에서 넘기는 변수의 값을 받아서 새로운 변수에 할당 -->
<%
	String na = request.getParameter("name");
	String em = request.getParameter("email");
	String sub = request.getParameter("subject");
	String cont = request.getParameter("content");
	String pw = request.getParameter("password");

	int id = 1;		//id에 처음 값을 할당할 때 기본 값으로 1을 할당.
					//다음부터는 테이블의 id컬럼에서 max값을 가져와 +1 처리
					
	//날짜 처리 (클래스 선언자 변수 = new 클래스 선언자) 임포트가 안되어있으면 직접 입력해도 됨
	java.util.Date yymmdd = new java.util.Date();
//	out.println(yymmdd);	Thu Jan 12 11:16:33 KST 
	SimpleDateFormat myformat = new SimpleDateFormat("yy-MM-d h:m a"); //내가 원하는 타입으로 출력 
	String ymd = myformat.format(yymmdd);			//23-01-12 11:14 오전
//	out.println(ymd);

	//DB에 값을 처리할 변수 선언 : Connection (conn) <== Include되어 있음.
	String sql = null;
	Statement stmt = null;
	ResultSet rs = null;		//id 컬럼의 최대값을 select | select는 무조건 resultSet

	try{
	//DB에서 값 처리
	stmt = conn.createStatement();
	sql = "select max(id) from freeboard";		//id : Primary Key
	
	rs = stmt.executeQuery(sql);		
	
//	rs.next();
	
//	out.println(rs.getInt(1)+"<p/>");
	
//	if(true)return;

 	if(!(rs.next())){ //테이블의 값이 존재하지 않는 경우 | 값이 아무것도 없음 : false !(낫뜨) -> true
		id = 1;
	}else {			  //테이블의 값이 존재하는 경우 | rs.getInt : 방번호로 값을 가져옴
		id = rs.getInt(1)+1;  
	} 

	//테이블의 id 컬럼의 값을 적용 : 최대값을 가져와서 +1
/* 	if(rs.next()){ 		//테이블의 값이 존재하는 경우
		id = rs.getInt(1)+1;
	}else {			  //테이블의 값이 존재하지 않는 경우 : 초기값 
		id = 1;  
	} */
	
	//Statement 객체는 변수값으르 처리하는 것이 복잡하다. PreparedStatement를 사용한다.
	//form에서 넘겨받은 값을 DB에 insert하는 쿼리 (주의 : masterid 컬럼 = id컬럼에 들어오는 값으로 처리해야함. )
	sql = "insert into freeboard (id,name,password,email,subject,content, ";
	sql += "inputdate,masterid,readcount,replaynum,step) ";
	sql += "values("+id+",'"+na+"','"+pw+"','"+em+"','"+sub+"','"+cont+"', ";
	sql += "'"+ymd+"',"+id+","+ "0,0,0)";
	
//	out.println(sql);
//	if(true) return;		//프로그램 중지 시킴 디버깅할 때 사용함.
	
	stmt.executeUpdate(sql);	//DB에 저장 완료, commit을 자동으로 처리
	
	}catch(Exception e) {		//try catch 블락으로 프로그램이 종료되지 않도록 처리 후 객체 제거
		out.println("예상치 못한 오류가 발생했습니다."+"<p/>");
		out.println("고객 센터 : 02-1234-1234 "+"<p/>");
//		e.printStackTrace();		//오류의 자세한 정보 출력 - 디버깅 하기 위한 구문
		
	}finally{
		
		if( conn != null) conn.close();
		if( stmt != null) stmt.close();
		if( rs != null)	  rs.close();
	}
	
%>

<!-- 
	페이지 이동 :
		response.sendRedirect : 클라이언트에서 페이지를 재요청 -> URL주소 바뀐다.
		forward : 서버에서 페이지를 이동 -> URL주소가 바뀌지 않는다.
		
--> 
<% response.sendRedirect("freeboard_list.jsp"); %>

<%-- <jsp:forward page = "freeboard_list.jsp"/> --%> 
<!-- 저장 후 이동할 페이지 -->


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>