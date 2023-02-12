<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>شراء</title>
<link rel="stylesheet" href="css/Buy.css">
<link rel="stylesheet" href="css/accss.css">
</head>
<body>
<div class="main">
	<div class="topbar1"></div>
	<div class="topbar2">
		<div class="container1">
			<div class="logout-btn">
				<a href="Logout.jsp">خروج</a>
			</div>
		</div>
	</div>
	<div class="header">
		<div class="container2">
			<div class="navbar">
				<a href="Homepage.jsp">الرئيسية</a>
				<a href="Buy.jsp">شراء</a>
				<a href="Orders.jsp">الطلبات</a>
			</div>
		</div>
	</div>
</div>
<div class="active">
	<%@ page import="java.sql.*" %>
	<%@ page import="javax.sql.*" %>
	<%
	HttpSession httpSession = request.getSession();
    String uid=(String)httpSession.getAttribute("currentuser");
    %>
    
    <div class="filler"></div>
    
    <%
    int flag=0;
	ResultSet rs=null;
	PreparedStatement ps=null;
	java.sql.Connection conn=null;
	String query="select p.pname,p.pid,p.manufacturer,p.mfg,p.price,i.quantity from product p,inventory i where p.pid=i.pid";
	
	try{
		Class.forName("com.mysql.jdbc.Driver");
		conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/drugdatabase","root","");
		ps=conn.prepareStatement(query);
		rs=ps.executeQuery();
		%><div class="filler2"></div>
				<div class="block">
				<%
		while(rs.next())
		{
			if(flag==4)
				{
				flag=1;
				%></div><div class="filler2"></div><%
				}
			else
			flag++;
		%>
			<div class="row">
 				<div class="column">
    				<div class="card">
    				<img src="images/pills.png" width=180 height=200>
  					<h1><%=rs.getString("pname") %></h1>
  					<p><b>الرقم </b><%=rs.getString("pid") %></p>
					<p><b>الشركة المصنعه </b><%=rs.getString("manufacturer") %></p>
					<p><b>تاريخ الانتاج : </b><%=rs.getDate("mfg") %></p>
					<p><b>المشتريات </b><%=rs.getInt("quantity") %></p>
					<p><b>السعر </b><%=rs.getInt("price") %></p>
					<%if (rs.getInt("quantity")>0) 
					{
					%>
  					<form action="PlaceOrder.jsp" method="post">
  					<input type="number" name="orderquantity" onkeypress="return event.charCode>= 48 && event.charCode<= 57" placeholder="الكمية" max="<%=rs.getInt("quantity") %>" required >
  					<input type="hidden" name="pid" value="<%=rs.getString("pid") %>">
  					<p></p>
                                         <button >اشتري</button>
                                        <button id="list">ادفع</button></form></div>
  					<%
  					}
  					else	
  						{
  						%>
  					
  					<button>Out Of Stock</button></div>
  					<% 
  						} 
  					%>
  				</div>
  				<%
  				}
				%>
			</div>
		<%
	}
	catch(Exception e)
	{
		out.println("error: "+e);
	}
	finally {
	    try { if (rs != null) rs.close(); } catch (Exception e) {};
	    try { if (ps != null) ps.close(); } catch (Exception e) {};
	    try { if (conn != null) conn.close(); } catch (Exception e) {};
}
	%>
        
        
        
        
    
                            <div class="popup">


                              <div class="popup-content" dir="rtl">
                          <img src="images/close.PNG"   id="closes" alt=" اغلاق" class="close">
<form action=">">
  <br><br>
  <div class="select">
    <select  name="utype" required>
      <option value="" selected disabled>اختر نوع الحساب </option>
      <option value="2">ماستر كارد </option>
    
      <option value="1">  فيزا كارد </option>
    </select>
  </div>
  <br>
  <lable >
ادخل رقم الحساب او البطاقة 
  </lable>
  &nbsp; &nbsp;
  <input type="number ">
  <br><br>
  <lable>
    ادخل المبلغ المراد خصمة     
      </lable> &nbsp; &nbsp; &nbsp; &nbsp;
      <input type="number ">
      <br><br><br>
      <button class="send" type="submit" value="ارسال">  ارسال </button>
     
</form>
                              </div>
                            </div>
        
        

    <script>
       var gg= document.getElementById("list");
        gg.addEventListener("click",function(){
        document.querySelector(".popup").style.display="flex";})
           
        document.querySelector(".close").addEventListener("click",function(){
        document.querySelector(".popup").style.display ="none";})  

        document.querySelector(".send").addEventListener("click",function(){
        document.querySelector(".popup").style.display ="none";})  
       
            </script>
</body>
</html>
