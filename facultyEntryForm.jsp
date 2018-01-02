<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" import="database.*"   import="java.util.*" %><!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Faculty Entry</title>
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

                String action = request.getParameter("action");
                try{
                    if (action != null && action.equals("insert")) {
                    	
                       	String fname = request.getParameter("faculty_name");
           				String dep = request.getParameter("department");
           				String ftitle = request.getParameter("title");
           				
           				String query1 =  "INSERT INTO Faculty (faculty_name, title, department) VALUES ('"+fname +"', '" + ftitle + "', '"+dep +"')";
                        conn.setAutoCommit(false);
           				stmt.execute(query1);
   
                        conn.commit();
                        conn.setAutoCommit(true);
                    }
                
                   
%>
<div class="container">
<table  class="table table-bordered">
        			<tr>
                        <th>Faculty</th>
                        <th>Title</th>
                        <th>Department</th>
                        <th>Action</th>
                    </tr>
                    <tbody>
                    <tr>
                        <form action="facultyEntryForm.jsp" method="post">	
                        	<%
                        	
                           	 out.print("<input id = 'action' name = 'action' value = 'insert' type='hidden'>");
                             out.print("<td><input id = 'faculty_name' name = 'faculty_name' value = '' required></td>");
                             out.print("<td><input id = 'title' name = 'title' value = '' required></td>");
                             out.print("<td><input id = 'department' name = 'department' value = '' required></td>");
                             out.print("<td><input type='submit' value='Insert'></td></form></tr>");
                             Statement stmt1 = conn.createStatement();
                             String query1 =  "SELECT * FROM Faculty ORDER BY faculty_name ASC";
                             ResultSet rs1 = stmt1.executeQuery(query1);
                             while (rs1.next()) {
                            	 int fid = rs1.getInt("id");
                            	 String title = rs1.getString("title");
                            	 String fname = rs1.getString("faculty_name");
                            	 String dep = rs1.getString("department");
                            	 out.print(" <tr><form action='facultyEntryForm.jsp' method='post'>");
                            	 out.print("<input type='hidden' value='update' name='action'>");
                            	 out.print("<input type='hidden' value= '"+ fid +"' name='id'>");
                            	 out.print("<td><input value= '"+ fname +"' name='faculty_name'></td>");
                            	 out.print("<td><input  value= '"+ title +"' name='title'></td>");
                            	 out.print("<td><input  value= '"+ dep +"' name='department'></td></form>");
               					  }
                            %>
                        </form>
            <%   
                }
                catch(Exception e)
                {
                	out.print(e);
                }
            %>
               
            </td>
        </tr>
        </tbody>
    </table>
    </div>

    
</body>




</html>