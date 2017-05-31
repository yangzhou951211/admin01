<%@page import="com.shsxt.util.ChatUtil"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String info = request.getParameter("info");
	String answer = ChatUtil.getResult(info);
	out.print(answer);
%>
