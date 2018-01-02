<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" import="database.*"   import="java.util.*" %><!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Committees Entry</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<a href= "home.jsp"><button>HOME</button></a>

<body>
    
<%
            	Connection conn;
            	Statement stmt;
            	
		        Class.forName("org.postgresql.Driver");  // MySQL database connection
			    String postAccount = "postgres";
			    String postPassword = "zxcv1234";
			    conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/CSE132B?", postAccount, postPassword);    
			    stmt = conn.createStatement();
			    ResultSet rs = null;
                String action = request.getParameter("action");
              /*   try{     
                	 
                	if (action != null && action.equals("insert")) {
                	    String num = request.getParameter("graduate_num");
                	    String fname =  request.getParameter("faculty_name");
                	    String query1 = "INSERT INTO ThesisCommittee(graduate_num, faculty_name) VALUES ('"+ num+ "', '"+fname+"')";
                	    
                    	conn.setAutoCommit(false);
           				stmt.execute(query1);
   
                        conn.commit();
                        conn.setAutoCommit(true);
                    
                	} */
                   
%>
<div class="container">
<table  class="table table-bordered">
        			<tr>
                     
            
        </tr>
        </tbody>
    </table>
    </div>

    
</body>




</html>