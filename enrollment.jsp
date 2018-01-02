<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" import="database.*"   import="java.util.*" %><!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Class Entry</title>
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
                    	
                       	String classname = request.getParameter("class_title");
           				String quarter = request.getParameter("quarter");
           				String year = request.getParameter("class_year");
           				int course_id = Integer.parseInt(request.getParameter("corresponding_course_id"));
           				
           				String query1 = "INSERT INTO Class (class_title, quarter, class_year) VALUES ('" +classname + "', '" +quarter + "', '" +year +"');";
           			 	
           				String query2 ="INSERT INTO ClassInstance(course_id,class_id) VALUES ('" +course_id + "', (Select id from class where class_title = '"+classname +"' and quarter = '"+ quarter+"' and class_year = '"+year+"'));";
                        conn.setAutoCommit(false);
           				stmt.execute(query1);
           				stmt.execute(query2);
                        conn.commit();
                        conn.setAutoCommit(true);
                    }
                
                   
%>
<div class="container">
<table  class="table table-bordered">
        			<tr>
                        <th>Class Title</th>
                        <th>Quarter</th>
                        <th>Academic Year</th>
                        <th>Course</th>
                        <th>Action</th>
                    </tr>
                    <tbody>
                    <tr>
                        <form action="classEntryForm.jsp" method="post">
                        <input type="hidden" value="insert" name="action">	
                        	<%
                        	
                           	 out.print("<input id = 'action' name = 'action' value = 'insert' type='hidden'>");
                             out.print("<td><input id = 'class_title' name = 'class_title' value = '' required></td>");
                             out.print(" <td><select id = 'quarter' name='quarter' required>");
                             out.print(" <option value='FALL'>fall</option><option value='WINTER'>winter</option><option value='SPRING'>spring</option><option value='SUMMER'>summer</option></select></td>");
                             out.print("<td><input id = 'class_year' name = 'class_year' value = '' required></td>");
                            
                            %>
							 <td><select width = "20"  id = "corresponding_course_id" name="corresponding_course_id" required>
							 
                             
                            <option value = null disabled>Select course</option>
                            <%
                            Statement stmt1 = conn.createStatement();
                            String query2 ="select id, department, course_num from course order by department, course_num asc ";
                            
                            ResultSet rs = stmt1.executeQuery(query2);
                            String dep = null;;
                            String course_num = null;
                            int cid=0;
                            while(rs.next()){
                            	cid = rs.getInt(1);
                            	dep = rs.getString(2);
                            	course_num = rs.getString(3);
                            	out.print("<option value = "+ cid +"> "+ dep +" "+ course_num + "</option>");
                            }
                            %>
                            </select></td>
                            <td><input type="submit" value="Insert"></td>

            <%				Statement stmt2 = conn.createStatement();
            				String query3 = "SELECT cl.id AS cl_id, class_title, quarter, class_year, department, course_num FROM Class cl LEFT OUTER JOIN ClassInstance ci ON cl.id = ci.class_id LEFT OUTER JOIN Course co ON ci.course_id = co.id ORDER BY class_year, quarter ASC;";
            				ResultSet rs1 = stmt2.executeQuery(query3);
            				
            				while(rs1.next())
            				{	
            					int cid1 = 0;
            					String classname1 = null;
            					String getQuarter = null;
            					String getYear = null;
            					String getDep = null;
            					String getCourse = null;
            					String CourseName = null;
            					cid1 = rs1.getInt(1);
            					classname1 = rs1.getString(2);
            					getQuarter = rs1.getString(3);
            					getYear = rs1.getString(4);
            					getDep = rs1.getString(5);
            					getCourse = rs1.getString(6);
            					out.print("<tr><form action='classEntryForm.jsp' method='post'>");
            					out.print("<input type='hidden' value='update' name='action'>");
%>
								
								 <input type="hidden" value="<%=cid1 %>" name="id">
								 <td><input value = "<%=classname1 %>" required></td>
								 <td><input value ="<%= getQuarter %>" ></td>
								 <td><input value = "<%=getYear %>"></td>
								 <%
								// System.out.print(getCourse);
								 if(getCourse != null && getDep != null )
								 {
								 	
									 CourseName = getDep + " " + getCourse;
                            	 }
								 %>
                            	<td><input type="text" value="<%=CourseName%>" ></td>
 <%                             	
							
								 
           					
            				}
            				
                    
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