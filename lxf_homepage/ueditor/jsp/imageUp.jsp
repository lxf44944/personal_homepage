    <%@ page language="java" contentType="text/html; charset=gbk"
        pageEncoding="gbk"%>
    <%@ page import="ueditor.Uploader" %>

    <%
    request.setCharacterEncoding("gbk");
	response.setCharacterEncoding("gbk");
    Uploader up = new Uploader(request);
    up.setSavePath("upload");
    String[] fileType = {".gif" , ".png" , ".jpg" , ".jpeg" , ".bmp"};
    up.setAllowFiles(fileType);
    up.setMaxSize(10000); //µ¥Î»KB
    up.upload();
    response.getWriter().print("{'original':'"+up.getOriginalName()+"','url':'"+up.getUrl()+"','title':'"+up.getTitle()+"','state':'"+up.getState()+"'}");
    %>
