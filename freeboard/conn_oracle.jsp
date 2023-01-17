
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import = "java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Oracle DB Connection</title>
</head>
<body>
	<%	// : JSP블락 내에서 주석
		//변수 초기화		
		Connection conn = null;		//connection : sql안에 있는 객체
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:XE";
		
		try{
			Class.forName(driver);		//"oracle.jdbc.driver.OracleDriver" class가 있는 지 확인 - 없다면 오류(예외)발생 , try~catch / 오라클 드라이버를 로드함
			conn = DriverManager.getConnection (url,"C##HR","1234");
			
		}catch(Exception e){
			e.printStackTrace();
		}

	%>
	
</body>
</html>