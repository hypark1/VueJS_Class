<%@ page language="java" contentType="application/json; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*"%>
<%
	response.addHeader("Access-Control-Allow-Origin", "*");
	response.setHeader("Access-Control-Allow-Headers", "origin, x-requested-with, content-type, accept");
	
	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");
	
	System.out.println(id+"/"+pwd);
	Class.forName("oracle.jdbc.driver.OracleDriver");
	String url="jdbc:oracle:thin:@localhost:1521:XE";
	String user="scott", dbpwd="tiger";
	Connection con=DriverManager.getConnection(url,user,dbpwd);
	String sql="select idx,name,id from vue_user where id=? and pwd=?";
	PreparedStatement ps=con.prepareStatement(sql);
	ps.setString(1,id);
	ps.setString(2,pwd);
	ResultSet rs=ps.executeQuery();
	boolean isExist=rs.next();
	String idx="", name="", userid="";
	if(isExist){
		idx=rs.getString("idx");
		name=rs.getString("name");
		userid=rs.getString("id");
		//아이디와 비밀번호가 맞다면 세션에 저장
		session.setAttribute("uname",name);
		session.setAttribute("uid",userid);
		session.setAttribute("uidx",idx);
	}
	
	rs.close();
	ps.close();
	con.close();
%>
{
  "data":{
  	"idx":"<%=idx%>",
	"name":"<%=name%>",
	"id":"<%=userid%>"
	}
}
