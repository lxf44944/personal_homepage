    <%@ page language="java" pageEncoding="gbk"%>
    <%@ page import="java.io.*"%>
    <%@ page import="java.net.*"%>
    <%@ page import="java.util.*"%>
    <%@ page import="ueditor.Uploader" %>
    <%
    	request.setCharacterEncoding("gbk");
    	response.setCharacterEncoding("gbk");
    	String url = request.getParameter("upfile");
    	String state = "Զ��ͼƬץȡ�ɹ���";
    	
    	String filePath = "upload";
    	String[] arr = url.split("ue_separate_ue");
    	String[] outSrc = new String[arr.length];
    	for(int i=0;i<arr.length;i++){

    		//�����ļ�·��
    		String str = application.getRealPath(request.getServletPath());
			File f = new File(str);
			String savePath = f.getParent() + "/"+filePath;
    		//��ʽ��֤
    		String type = getFileType(arr[i]);
			if(type.equals("")){
				state = "ͼƬ���Ͳ���ȷ��";
				continue;
			}
    		String saveName = Long.toString(new Date().getTime())+type;
    		//��С��֤
    		HttpURLConnection.setFollowRedirects(false); 
		    HttpURLConnection   conn   = (HttpURLConnection) new URL(arr[i]).openConnection(); 
		    if(conn.getContentType().indexOf("image")==-1){
		    	state = "�����ַͷ����ȷ";
		    	continue;
		    }
		    if(conn.getResponseCode() != 200){
		    	state = "�����ַ�����ڣ�";
		    	continue;
		    }
            File dir = new File(savePath);
			if (!dir.exists()) {
				dir.mkdirs();
			}
    		File savetoFile = new File(savePath +"/"+ saveName);
    		outSrc[i]=filePath +"/"+ saveName;
    		try {
    			InputStream is = conn.getInputStream();
    			OutputStream os = new FileOutputStream(savetoFile);
    			int b;
    			while ((b = is.read()) != -1) {
    				os.write(b);
    			}
    			os.close();
    			is.close();
    			// ���ﴦ�� inputStream
    		} catch (Exception e) {
    			e.printStackTrace();
    			System.err.println("ҳ���޷�����");
    		}
    	}
   	String outstr = "";
   	for(int i=0;i<outSrc.length;i++){
   		outstr+=outSrc[i]+"ue_separate_ue";
   	}
   	outstr = outstr.substring(0,outstr.lastIndexOf("ue_separate_ue"));
   	response.getWriter().print("{'url':'" + outstr + "','tip':'"+state+"','srcUrl':'" + url + "'}" );

    %>
    <%!
    public String getFileType(String fileName){
    	String[] fileType = {".gif" , ".png" , ".jpg" , ".jpeg" , ".bmp"};
    	Iterator<String> type = Arrays.asList(fileType).iterator();
    	while(type.hasNext()){
    		String t = type.next();
    		if(fileName.endsWith(t)){
    			return t;
    		}
    	}
    	return "";
    }
    %>
