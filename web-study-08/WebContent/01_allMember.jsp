<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "java.sql.Statement" %>
<%@ page import = "java.sql.Connection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%! //선언부는 첫 방문자에 의해서 단 한번 수행합니다.
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;

String url = "jdbc:oracle:thin:@localhost:1521:orcl";
String uid = "scott";
String pass = "tiger";
String sql = "select * from member";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JDBC 연동</title>
</head>
<body>
<table width='800' border='1'>
<tr>
	<th>이름</th><th>아이디</th><th>암호</th><th>이메일</th>
	<th>전화번호</th><th>권한(1:관리자, 0:일반회원)</th>
</tr>
<%
try{
	Class.forName("oracle.jdbc.driver.OracleDriver"); // 1단계로 JDBC 드라이버를 로드합니다.
	conn = DriverManager.getConnection(url, uid, pass); // 2단계로 데이터베이스 연결 객체인 Connection을 생성합니다. 
	stmt = conn.createStatement(); // Connection 객체로부터 Statement 객체를 얻어옵니다.
	rs=stmt.executeQuery(sql); // Statement 객체로 exectuteQuery()를 실행한 후 결과값을 얻어와서 ResultSet 객체에 저장합니다. 
	while(rs.next()){
		out.println("<tr>");
		out.println("<td>"+rs.getString("name")+"</td>");
		out.println("<td>"+rs.getString("userid")+"</td>");
		out.println("<td>"+rs.getString("pwd")+"</td>");
		out.println("<td>"+rs.getString("email")+"</td>");
		out.println("<td>"+rs.getString("phone")+"</td>");
		out.println("<td>"+rs.getInt("admin")+"</td>"); // admin 컬럼은 데이터베이스에 NUMBER로 선언된 컬럼이므로 이 값을 저장하는 필드가 int로 선언되어 있습니다.
		out.println("</tr>");
	} // while의 끝
}catch(Exception e) {
	e.printStackTrace();
}finally {
	try{
		if(rs != null) rs.close();
		if(stmt != null) stmt.close();
		if(conn != null) conn.close();
	}catch(Exception e) {
		e.printStackTrace();
	}
} // finally의 끝
%>
</table>
</body>
</html>