<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" import="database.*"   import="java.util.*" %><!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Student Entry</title>
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
                       	String pid = request.getParameter("student_num");
           				String ssn = request.getParameter("ssn");
           				String firstname = request.getParameter("first_name");
           				String middlename = request.getParameter("middle_name");
           				String lastname = request.getParameter("last_name");
           				String resident = request.getParameter("residency");
           				String stuType = request.getParameter("student_type");
           				String college = request.getParameter("college");
           				String major = request.getParameter("major");
           				String minor = request.getParameter("minor");
           				String dep = request.getParameter("department");
           				
           				String query1 =  "INSERT INTO student(student_num, ssn, first_name, middle_name, last_name, residency, student_type) Values ('"+pid+"','"+ssn+"',' "+firstname+"',' "+middlename+"','"+lastname+"',' "+resident+"',' "+ stuType+"') ";
                        String query2 = "INSERT INTO Undergraduate(undergraduate_num, college, major, minor) VALUES ('"+ pid+"', '"+ college+ " ','" + major + "','" +minor + "')";
                        String query3 = "INSERT INTO MSUndergraduate(msundergraduate_num, department) VALUES ('" +pid+ "','" + dep+"')";
           				conn.setAutoCommit(false);
           				stmt.execute(query1);
           				stmt.execute(query2);
           				stmt.execute(query3);
                        conn.commit();
                        conn.setAutoCommit(true);
                        
                    }
                
                   
%>
<div class="container">
<table  class="table table-bordered">
					<%
					Statement stmt1 = conn.createStatement();
					String query4 = "SELECT s.id AS sid, student_num, ssn, first_name, middle_name, last_name, residency, student_type, u.id AS uid, college, major, minor, msu.id AS msuid, department FROM Student s, Undergraduate u, MSUndergraduate msu WHERE student_num = undergraduate_num AND undergraduate_num = msundergraduate_num ORDER BY student_num ASC";
					ResultSet rs1 = stmt1.executeQuery(query4);
					
					%>
        			<tr>
                        <th>Student ID</th>
                        <th>SSN</th>
                        <th>First Name</th>
                        <th>Middle Name</th>
                        <th>Last Name</th>
                        <th>resident</th>
                        <th>College</th>
                        <th>Major</th>
                        <th>Minor</th>
                        <th>Department</th>
                        <th>Action</th>
                    </tr>
                    <tbody>
                    <tr>
                        <form action="studentEntryForm.jsp" method="post">
                        <input type="hidden" value="insert" name="action">	
                        	<%
                        	
                           	 out.print("<input id = 'action' name = 'action' value = 'insert' type='hidden'>");
                        	 out.print("<input  name = 'student_type' value = 'undergraduate' type='hidden'>");
                             out.print("<td><input id = 'student_num' name = 'student_num' value = '' required></td>");
                             out.print("<td><input id = 'ssn' name = 'ssn' value = '' required></td>");
                             out.print("<td><input id = 'first_name' name = 'first_name' value = '' required></td>");
                             out.print("<td><input id = 'middle_name' name = 'middle_name' value = '' ></td>");
                             out.print("<td><input id = 'last_name' name = 'last_name' value = '' required></td>");
                             out.print("<td><select id = 'residency' name = 'residency'  required>");
                             out.print(" <option value='foreign'> Not in United States </option>"); 
                             out.print(" <option value='non_ca_resident'>Not California Resident </option> ");
                             out.print(" <option selected value='ca_resident'>California Resident </option>  </select></td>");
                            %>
                            <td><select name="college" required>
                              <option value="ROOSEVELT">ROOSEVELT</option>
                              <option value="MARSHALL">MARSHALL</option>
                              <option selected value="REVELLE">REVELLE</option>
                              <option value="SIXTH">SIXTH</option>
                              <option value="MUIR">MUIR</option>
                              <option value="WARREN">WARREN</option>
                            </select></td>
                            
                            <%
                            
                            out.print("<td><input id = 'major' name = 'major' value = '' required></td>");
                            out.print("<td><input id = 'minor' name = 'minor' value = '' ></td>");
                            out.print("<td><input id = 'department' name = 'department' value = '' ></td>");
                            out.print("<td><input type = 'submit' value = 'Insert'></td></form></tr>");
                            

                           while(rs1.next()){
                        	   int sid = rs1.getInt("sid");
                        	   int uid = rs1.getInt("uid");
                        	   int msuid = rs1.getInt("msuid");
                        	   String pid = rs1.getString("student_num");
                        	   
                        	   String ssn = rs1.getString("ssn");
                        	   String firstname = rs1.getString("first_name");
                        	   String middlename = rs1.getString("middle_name");
                        	   String lastname = rs1.getString("last_name");
                        	   
                        	   String residency = rs1.getString("residency");
                        	   String college = rs1.getString("college");
                        	   String major =  rs1.getString("major");
                        	   String minor = rs1.getString("minor");
                        	   String dep = rs1.getString("department");
                        	   
                        	   out.print("<tr><form action = 'studentEntryForm.jsp' method='post'>");
                        	   out.print("<input type = 'hidden' value = 'update' name= 'action' >");
                        	   out.print("<input type='hidden' value='undergraduate' name='student_type'>");
                        	  %>
                        	  <input type="hidden" value="<%=sid%>" name="sid">
	                          <input type="hidden" value="<%= uid %>" name="uid">
	                          <input type="hidden" value="<%=msuid %>" name = "msuid">
	                          
	                          <td><input value="<%=pid%>" name="student_num"  required> </td>
	                          <td><input value="<%=ssn%>" name="ssn"  required> </td>
	                          <td><input value="<%=firstname%>" name="first_name"  required> </td>
                        	  <td><input value="<%=middlename%>" name="middle_name"  > </td>
                        	  <td><input value="<%=lastname%>" name="last_name"  required> </td>
                        	  <td><input value="<%=residency%>" name="residency"  required> </td>
                        	  <td><input value="<%=college%>" name="college"  required> </td>
                        	  <td><input value="<%=major%>" name="major"  required> </td>
                        	  <td><input value="<%=minor%>" name="minor"  > </td>
                        	  <td><input value="<%=dep%>" name="department"  required> </td>
                        	  
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