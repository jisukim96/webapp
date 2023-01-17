<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import = "java.sql.*" %>
<%@ include file = "conn_oracle.jsp" %>
<% request.setCharacterEncoding("UTF-8"); %>

<%
	int id = Integer.parseInt(request.getParameter("id"));
	String p = request.getParameter("page");
	
	//폼에서 수정되어 넘어오는 변수의 값을 재할당
	
	String na = request.getParameter("name");
	String em = request.getParameter("email");
	String sub = request.getParameter("subject");
	String cont = request.getParameter("content");
	String pw = request.getParameter("password");
			
	
/* 	out.println(id+"<p/>");
	out.println(p+"<p/>");
	
	if(true) return; */
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 수정된 내용을 DB에 저장하는 페이지</title>
</head>
<body>

[<a href = "freeboard_list03.jsp?go=<%= p %>">게시판 목록으로</a>]

<% 
	String sql = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	//DB에서 해당 id에 대한 password를 가져와서 폼에서 전송된 password와 확인
	sql = "select * from freeboard where id = ?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setInt(1,id);
	rs = pstmt.executeQuery();
	
	try{
	
	//rs는 DB에서 password 필드의 값을 가져와서 폼에서 넘겨받은 password와 비교 후 같으면 update
	if (!(rs.next())){	//rs의 값이 존재하지 않을 떄
		out.println("DB에 해당 내용이 존재하지 않습니다.");
	}else{	//rs의 값이 존재할 때
		String pwd = rs.getString("password");
		//pwd : DB의 password
		//pw : Form에서 넘겨받은 password
		out.println("<p/>"+ pwd+"<p/>");
		out.println(pw+"<p/>");
		out.println(pwd.equals(pw));		//DB의 값과 form에서 받은 값이 같으면 true, 다르면 false
		
	/* 	if (true) return; */
		
		if(pwd.equals(pw)){
			//update 진행
			sql = "update freeboard set name =?, email=?,";
			sql += "subject =? , content =? where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, na);
			pstmt.setString(2, em);
			pstmt.setString(3, sub);
			pstmt.setString(4, cont);
			pstmt.setInt(5, id);
			
			pstmt.executeUpdate();
			
			out.println("</p> 내용이 수정되었습니다.");
			
		}else{
			//패스워드가 다릅니다. 출력
			
		}
	}
	
	}catch(Exception e){
		out.println ("DB 저장시 오류가 발생되었습니다.");
		e.printStackTrace();
	}finally {
		if (conn != null) conn.close();
		if (pstmt != null) conn.close();
		if(rs != null) rs.close();
	}
%>

</body>
</html>