<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="gbk"%>
<%@ page import="ueditor.Uploader" %>


<%
    request.setCharacterEncoding("gbk");
    response.setCharacterEncoding("gbk");

    Uploader up = new Uploader(request);
    up.setSavePath("upload"); //����·��
    String[] fileType = {".rar" , ".doc" , ".docx" , ".zip" , ".pdf" , ".txt" , ".swf", ".wmv"};  //������ļ�����
    up.setAllowFiles(fileType);
    up.setMaxSize(10000);        //������ļ����ߴ磬��λKB
    up.upload();
    response.getWriter().print("{'url':'"+up.getUrl()+"','fileType':'"+up.getType()+"','state':'"+up.getState()+"','original':'"+up.getOriginalName()+"'}");

%>
