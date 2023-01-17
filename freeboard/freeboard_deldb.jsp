<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.sql.*"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<%@ include file="conn_oracle.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 삭제를 처리하는 페이지</title>
</head>
<body>

[<a href = "freeboard_list03.jsp?go=<%= request.getParameter("page") %>">게시판으로 이동</a>]


	<%
	//DB 접속하는 객체 선언
	String sql = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	int id = Integer.parseInt(request.getParameter("id"));
	int page1 = Integer.parseInt(request.getParameter("page"));
	String pw = request.getParameter("password"); //폼에서 넘겨받은 password 

	/* out.println(id + "<p/>");
	out.println(page1 + "<p/>");
	out.println(pw + "<p/>");

	if(true) return;	//프로그램 종료
	 */
	 
	 try{		//DB에 쿼리를 보내는 블락 : DB에 오류 발생 시 프로그램이 종료되지 않도록 처리
		 	//실무에서는 모든 쿼리 명시하여 적는 게 효율성 높이는 방법임.
		sql = "select * from freeboard where id = ?";
	 	pstmt = conn.prepareStatement(sql);
	 	pstmt.setInt(1,id);
	 	rs = pstmt.executeQuery();
	 	
	 	if(!(rs.next())){ //rs의 값이 비어있을 때
	 		out.println("해당 값이 존재하지 않습니다.");
	 	}else{	//rs의 값이 존재할 때
	 		//rs의 password 컬럼의 값을 가져와서 폼에서 인풋받은 값(pw)와 같으면 삭제
	 				//pwd : DB에서 가져온 컬럼의 값
	 				//pw : 사용자가 폼에서 넘긴 값
	 			String pwd = rs.getString("password");
	 			
	 		if(pwd.equals(pw)){	//DB의 password와 폼의 값이 같을 때
	 			//delete 쿼리를 적용
	 			sql = "delete freeboard where id = ?";
	 			pstmt = conn.prepareStatement(sql);
	 			pstmt.setInt(1, id);
	 			pstmt.executeQuery();
	 			
	 			//위 쿼리가 성공적으로 작동되면 아래 코드가 실행됨
	 			out.println("해당 게시물이 삭제되었습니다.");
	 			
	 			
	 		}else { //다를 때
	 			out.println("패스워드가 일치하지 않습니다.");
	 		}
	 	}
		 
	 }catch(Exception e){
		 out.println("DB 오류로 인해서 삭제를 실패하였습니다.");
//		 e.printStackTrace();		//오류 발생시 자세한 내역 출력 (디버깅)
	 }finally{
		 if(conn != null){ conn.close();}
		 if(pstmt != null){ pstmt.close();}
		 if(rs != null){ rs.close();}
	 }
	 
	 
	 
	%>
	
	
	
	
	
</body>
</html>