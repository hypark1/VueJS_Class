<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	String name=request.getParameter("name");
	String nick=request.getParameter("nick");
	String passwd=request.getParameter("pwd");
	String tel=request.getParameter("tel");
	String addr=request.getParameter("addr");
	System.out.println(name+"/"+passwd+"/"+tel+"/"+addr);
	
	Class.forName("oracle.jdbc.driver.OracleDriver");
	String url="jdbc:oracle:thin:@localhost:1521:XE";
	String user="scott", dbpwd="tiger";
	Connection con=DriverManager.getConnection(url,user,dbpwd);
	String sql="insert into vue_member "; 
    sql+=" values(vue_member_seq.nextval, ?,?,?,?,?,sysdate)";
	PreparedStatement ps=con.prepareStatement(sql);
	ps.setString(1,name);
	ps.setString(2,id);
	ps.setString(3,passwd);
	ps.setString(4,tel);
	ps.setString(5,addr);
	int n=ps.executeUpdate();
	ps.close();
	con.close();
	
%>
{"result":"<%=n%>"}