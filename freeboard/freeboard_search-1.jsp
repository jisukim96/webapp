<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java" import="java.sql.*,java.util.*"%>
<%
request.setCharacterEncoding("utf-8");
%>
<%@ include file="conn_oracle.jsp"%>


<HTML>
<HEAD>
<TITLE>게시판(검색모드)</TITLE>
</HEAD>
<BODY>

	<P>
	<P align=center>
		<FONT color=#0000ff face=굴림 size=3> <STRONG>자유
				게시판(검색모드)</STRONG>
		</FONT>
	</P>
	<FORM method=post name=search action="freeboard_search.jsp">
		<TABLE border=0 width=95%>
			<TR>
				<TD align=left width=30% valign=bottom>[<A
					href="freeboard_list03.jsp">자유 게시판(일반모드)</A>]
				</TD>
				<TD align=right width=70% valign=bottom><FONT size=2 face=굴림>
					<SELECT name=stype> <!-- stype에 넘어오는 value값에 따라서 다르게 출력 
						<OPTION value=1>이름</OPTION>
						<OPTION value=2>제목</OPTION>
						<OPTION value=3>내용</OPTION>
						<OPTION value=4>이름+제목</OPTION>
						<OPTION value=5>이름+내용</OPTION>
						<OPTION value=6>제목+내용</OPTION>
						<OPTION value=7>이름+제목+내용</OPTION>
						-->
	
					<%
					 //jsp 코드 블락 : <option> 넘어오는 변수에 따라 해당 내용을 출력
					 String cond = null;		//sql쿼리 저장하는 변수 : stype = 1 
					 int what = 1;				//stype 에 넘어오는 값을 int 타입으로 변환해서 담는 변수
					 							// 2 = 제목 , 3 = 내용 , 4 = 이름 + 제목 , ...
					 String val = null;			//sval 에서 넘어오는 검색어를 담는 변수
					 
					 what = Integer.parseInt(request.getParameter("stype")); //옵션
					 val = request.getParameter("sval");		//검색어
					 
					 if(what == 1){
						 out.println("<OPTION value=1 selected>이름</OPTION>");
						 cond = "where name like '%" + val + "%'";
					 }else{ out.println("<OPTION value=1>이름</OPTION>"); }
					 
					 if(what == 2){
						 out.println("<OPTION value=2 selected>제목</OPTION>");
						 cond = "where subject like '%" + val + "%'";
					 }else{ out.println("<OPTION value=2>제목</OPTION>"); }
					 
					 if(what == 3){
						 out.println("<OPTION value=3 selected>내용</OPTION>");
						 cond = "where content like '%" + val + "%'";
					 }else{ out.println("<OPTION value=3>내용</OPTION>"); }
					 
					 if(what == 4){
						 out.println("<OPTION value=4 selected>이름+제목</OPTION>");
						 cond = "where name like '%" + val + "%' or subject like '%" + val + "%'";
					 }else{ out.println("<OPTION value=4>이름+제목</OPTION>"); }
					 
					 if(what == 5){
						 out.println("<OPTION value=5 selected>이름+내용</OPTION>");
						 cond = "where name like '%" + val + "%' or content like '%" + val + "%'";
					 }else{ out.println("<OPTION value=5>이름+내용</OPTION>"); }
					 
					 if(what == 6){
						 out.println("<OPTION value=6 selected>제목+내용</OPTION>");
						 cond = "where subject like '%" + val + "%' or content like '%" + val + "%'";
					 }else{ out.println("<OPTION value=6>제목+내용</OPTION>"); }
					 
					 if(what == 7){
						 out.println("<OPTION value=7 selected>이름+제목+내용</OPTION>");
						 cond = "where name like '%" + val + "%' or subject like '%" + val + "%' ";
						 cond += "or content like '%" + val + "%'";
					 }else{ out.println("<OPTION value=7>이름+제목+내용</OPTION>"); }
					 
					 %> </SELECT>
				</FONT> <INPUT type=text name="sval" value="<%=request.getParameter("sval")%>"> <INPUT
					type=submit value="검색"></TD> <!-- 검색어를  -->
			</TR>
		</TABLE>
	</FORM>
	<CENTER>
	
	<%
	
/* 					 out.println (what + "<p/>");
					 out.println (val + "<p/>");
					 if(true) return; */
	
	
	
	
	
	%>
	
	
	
	
		<TABLE border=0 width=600 cellpadding=4 cellspacing=0>
			<tr align="center">
				<td colspan="5" height="1" bgcolor="#1F4F8F"></td>
			</tr>
				<tr align="center" bgcolor="#87E8FF">
				<td width="42" bgcolor="#DFEDFF"><font size="2">번호</font></td>
				<td width="340" bgcolor="#DFEDFF"><font size="2">제목</font></td>
				<td width="84" bgcolor="#DFEDFF"><font size="2">등록자</font></td>
				<td width="78" bgcolor="#DFEDFF"><font size="2">날짜</font></td>
				<td width="49" bgcolor="#DFEDFF"><font size="2">조회</font></td>
			</tr>
			<tr align="center">
				<td colspan="5" bgcolor="#1F4F8F" height="1"></td>
			</tr>

		<%			//검색된 내용을 출력하는 블락
		String sql = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		//cond : option 선택자에 따라 다른 쿼리가 변수로 들어옴
		sql = "select * from freeboard " + cond ;
		sql += " order by id desc";
		
		
		out.println(sql);
/* 		if(true) return; */

		//tr을 DB에서 값을 가져와 루프 돌리며 출력
		
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql);	
		
		if (!(rs.next())){
			out.println("해당 내용은 DB에 존재하지 않습니다.");
		} else {	// 검색된 내용이 존재한다면 
			do{
		
		%>
			<tr align="center" bgcolor="#87E8FF">
				<td width="42" bgcolor="#DFEDFF"><font size="2"><%= rs.getInt("id") %></font></td>
				<td width="340" bgcolor="#DFEDFF"><font size="2"><%= rs.getString("subject") %></font></td>
				<td width="84" bgcolor="#DFEDFF"><font size="2"><%= rs.getString("name") %></font></td>
				<td width="78" bgcolor="#DFEDFF"><font size="2"><%= rs.getString("inputdate").substring(0,8) %></font></td>
				<td width="49" bgcolor="#DFEDFF"><font size="2"><%= rs.getString("readcount") %></font></td>
			</tr>

		<%
			} while(rs.next());
				
			
		}
		
		%>
		</TABLE>

</BODY>
</HTML>