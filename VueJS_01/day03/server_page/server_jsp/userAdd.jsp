<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<%
response.addHeader("Access-Control-Allow-Origin", "*");
response.setHeader("Access-Control-Allow-Headers", "origin, x-requested-with, content-type, accept");

	request.setCharacterEncoding("UTF-8");
	String name=request.getParameter("name");
	String id=request.getParameter("id");
	String passwd=request.getParameter("pwd");
	String email=request.getParameter("email");
	
	System.out.println(name+"/"+passwd+"/"+email);
	
	Class.forName("oracle.jdbc.driver.OracleDriver");
	String url="jdbc:oracle:thin:@localhost:1521:XE";
	String user="scott", dbpwd="tiger";
	Connection con=DriverManager.getConnection(url,user,dbpwd);
	String sql="insert into vue_user(idx,name,id,pwd,email,indate) "; 
    sql+=" values(vue_user_seq.nextval, ?,?,?,?,sysdate)";
	PreparedStatement ps=con.prepareStatement(sql);
	ps.setString(1,name);
	ps.setString(2,id);
	ps.setString(3,passwd);
	ps.setString(4,email);
	int n=ps.executeUpdate();
	ps.close();
	con.close();
	
%>
{"result":"<%=n%>"}