<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" import="database.*"   import="java.util.*" %><!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Course Entry</title>
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
                    	
                       	String[] requirements = request.getParameterValues("prerequisites_id");
           				String dep = request.getParameter("department");
           				String courseNum = request.getParameter("course_num");
           				String option = request.getParameter("grade_option");
           				
           				boolean isLab = Boolean.parseBoolean(request.getParameter("requires_lab"));
           				boolean isConsent = Boolean.parseBoolean(request.getParameter("requires_consent"));
           				
           				int max = Integer.parseInt(request.getParameter("max_units"));
           				int min = Integer.parseInt(request.getParameter("max_units"));
           				String query1 =  "INSERT INTO Course(department, course_num, min_units, max_units, " +
                                "grade_option, requires_lab, requires_consent) VALUES ('"+dep+"','"+courseNum+"',' "+max+"',' "+min+"','"+option+"',' "+isLab+"',' "+ isConsent+"');";
           			 
                        conn.setAutoCommit(false);
           				stmt.execute(query1);
   
                        if(requirements != null) {
                        
						  for(String req : requirements) {
	                        	String query2 ="INSERT INTO Prerequisite (target_id, prerequisite_id) VALUES " +
	    	                            "((SELECT id FROM Course WHERE department = '"+ dep +"' AND course_num='" + courseNum + "'), '" + req+"');";
	                        	stmt.execute(query2);
	                        }
                        }
                        conn.commit();
                        conn.setAutoCommit(true);
                    }
                
                   
%>
<div class="container">
<table  class="table table-bordered">
        			<tr>
          
              
                        <th>Department</th>
                        <th>Course Number</th>
                        <th>Grade Option</th>
                        <th>Min Units</th>
                        <th>Max Units</th>
                      	<th>requirements</th>
                        <th>Need Consent</th>
                        <th width = "50%">Has Lab</th>
                        <th>Action</th>
                    </tr>
                    <tbody>
                    <tr>
                        <form action="courseEntryFrom.jsp" method="post">	
                        	<%String t = "true";
                        	 String f = "false";
                        	 String letterGrade = "letter";
                        	 String passnopass = "S/U";
                        	 String together = "BOTH";
                        	
                           	 out.print("<input id = 'action' name = 'action' value = 'insert' type='hidden'>");
                             out.print("<td><input id = 'department' name = 'department' value = '' required></td>");
                             out.print("<td><input id = 'course_num' name = 'course_num' value = '' required></td>");
                             out.print("<td><select id = 'grade_option' name = 'department' value = '' required>");
                            %>

                              <option value = <%=letterGrade %> selected>Letter</option>
                              <option value = <%=passnopass %>>Pass/NoPass</option>
                              <option value = <%=together %>>BOTH</option>
                            </select></td>
                            
                            <td><input  width = "20"  size = "4" value=""  id = "min_units" name="min_units"  required></td>
                            <td><input width = "20"  size = "4" value=""  id = "max_units" name="max_units"  required></td>
                            <td><select width = "20"  multiple id = "requires_consent" name="prerequisites_id">
                             
                            <option value = "null">Select course(s)</option>
<%
                            
                            Statement stmt1 = conn.createStatement();
							String query2 ="SELECT department, course_num, id FROM Course ORDER BY department, course_num ASC";
                            ResultSet rs = stmt1.executeQuery(query2);
                            
                            while (rs.next()) {
                                String dep = rs.getString(1);
                                String course_num = rs.getString(2);
                                int cid = rs.getInt(3);
                                out.print(" <option value=" + cid + "> " + dep + " " + course_num + "</option>");
                              
                            } 
							out.print(" </select></td>");
							out.print(" <td><select id = 'requires_consent' name='requires_consent'>");
							out.print("<option  value=" + f  +" selected> NO</option>");
							out.print("<option  value=" + t  +" > YES</option></select></td>");
							
							out.print(" </select></td>");
							out.print(" <td><select id = 'requires_lab' name='requires_lab'>");
							out.print("<option  value=" + f  +" selected> NO</option>");
							out.print("<option  value=" + t  +" > YES</option></select></td>");
%>						
                            
                            
                            <td><input width = "20"  type="submit" id = "Insert" value="Insert"></td>
                        </form>
                    </tr>

            <%
                    rs.close();
            		String query3 = "SELECT * FROM Course ORDER BY department, course_num ASC";
		            rs = stmt1.executeQuery(query3);
		            
                    while ( rs.next() ) {
                    
                 	   String dep = rs.getString("department");
                 	   String course=   rs.getString("course_num");
                 	   String gradeOp = rs.getString("grade_option");
                 	   int min = rs.getInt("min_units");
                 	   int max = rs.getInt("max_units");
                 	   boolean isLab = rs.getBoolean("requires_lab");
                 	   boolean isConsent = rs.getBoolean("requires_consent");
                 	  int getid = rs.getInt("id"); 
                 	
            %>		
                    <tr>
                        <form action="courseEntryFrom.jsp" method="post">

                            <input type="hidden" value="update" name="action">
                            
                            <input type="hidden" value="<%= getid %>" name="id">
                            <td><input value="<%= dep %>" id = "department" name="department" > </td>
                            <td><input value="<%= course %>" id = "course_num" name="course_num" ></td>
                            <td><input value = "<%=gradeOp %>" id = "grade_option" name="grade_option"></td>
                            <td><input value="<%= min %>" id = "min_units" name="min_units"></td>
                            <td><input value="<%= max %>"  id = "max_units" name="max_units"  ></td>
                            
                            <td><select size = "3" multiple id = "requires_consent" name="prerequisites_id">
<%
                            
                            Statement stmt3 = conn.createStatement();
							String query4 ="select  c.department, c.course_num from Prerequisite p, course c where p.prerequisite_id = c.id and p.target_id = " + getid +  ";";
						    ResultSet rs1 = stmt3.executeQuery(query4);
                            
                            while (rs1.next()) {
                                String dep1 = rs1.getString(1);
                                String course_num1 = rs1.getString(2);
                       
                                out.print(" <option>" + dep1 + " " + course_num1 + "</option>");
                              
                            } 
                            //rs1.close();
                            %>
                            
                            
                            <td><input value = "<%=isLab %>" id = "requires_lab" name="requires_lab"></td>
                            <td><input value = "<%=isConsent %>" id = "requires_consent" name="requires_consent"></td>
                       
                            
                            
                            
                            </select>
                            </td>
                        </form>


                    </tr>
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