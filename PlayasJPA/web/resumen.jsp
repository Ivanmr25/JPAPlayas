<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<% 
    List<String> resumen=(List<String>)session.getAttribute("resumen");
  
    if (resumen.size()==0) {%>
        <h5 class="text-danger">Playa sin puntuacion</h5>
    <%} else {%>
        <table class="table table-striped">
            <%for (String tanteo:resumen){%>
            
                <tr>
                    
                    <td>  <%= tanteo.toString() %> </td>
                    
                </tr>
                
            <%}%>
        </table>
    <%}%>


