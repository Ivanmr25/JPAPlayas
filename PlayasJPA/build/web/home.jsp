<%-- 
    Document   : home
    Created on : 03-feb-2023, 11:43:45
    Author     : diurno
--%>

<%@page import="Entities.Images"%>
<%@page import="Entities.Playa"%>
<%@page import="Entities.Provincia"%>
<%@page import="Entities.Usuario"%>
<%@page import="Entities.Municipio"%>
<%@page import="Entities.Ccaa"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
    <%
        List<Ccaa> comunidades =  (List<Ccaa>)session.getAttribute("comunidades");
     List<Municipio> municipios =  (List<Municipio>)session.getAttribute("municipio");
     List<Provincia> provincias = (List<Provincia>) session.getAttribute("provincia");
     List<Playa> playas = (List<Playa>)session.getAttribute("playas");
    Usuario user = (Usuario) session.getAttribute("user");
    String msg = (String) session.getAttribute("msg");
    session.removeAttribute("msg");
    Playa playita = (Playa) session.getAttribute("playa");
    
    
    %>
    <head >
    <title>Playas</title>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="style.css">
  </head>
  <body> 
    <div class="container">
      <header class="row">
                <div class="col-2">
                    <img class="img-fluid" src="img/logo.png" alt="logo">
                </div>
                <div class="col-10 justify-content-center align-items-center mt-3">
                    <div class="row justify-content-end align-items-center px-2">
                        <% if (user != null) {%>
                        <div class="row align-items-center m-0">
                            <h3>Welcome <%=user.getNick()%>
                            </h3><a href="Controller?op=logout" class="btn btn-danger mx-2">Logout</a>
                        </div>
                        <%} else { %>
                        <div class="p-0">
                            <button class="btn btn-success mr-2" data-toggle="modal"
                                    data-target="#modallogin">Login</button>
                        </div>
                        <%}%>
                    </div>
                    <div class="row">
                        <div class="col-12 col-md-4">
                            <form action="Controller?op=vacomunidad" method="post">
                                <div class="form-group mt-2">
                                    <select class="form-control" name="comunidad" id="" onchange="this.form.submit()">
                                        <option disabled selected>Elija Comunidad</option>
                                        <% for (Ccaa comunidad : comunidades) {%>
                                        <option value="<%=comunidad.getId()%>">
                                            <%=comunidad.getNombre()%>
                                        </option>
                                        <% }%>
                                    </select>
                                </div>
                            </form>
                        </div>
                        <div class="col-12 col-md-4">
                            <form action="Controller?op=vaprovincia" method="post">
                                <div class="form-group mt-2">
                                    <select class="form-control" name="provincia" id="" onchange="this.form.submit()">
                                        <option disabled selected>Elija Provincia</option>
                                        <% if (provincias!=null) {
                                            for (Provincia provincia : provincias) {%>
                                        <option value="<%=provincia.getId()%>">
                                            <%=provincia.getNombre()%>
                                        </option>
                                        <% }}%>
                                    </select>
                                </div>
                            </form>
                        </div>
                        <div class="col-12 col-md-4">
                            <form action="Controller?op=vapueblo" method="post">
                                <div class="form-group mt-2">
                                    <select class="form-control" name="municipio" id="" onchange="this.form.submit()">
                                        <option disabled selected>Elija Municipio</option>
                                        <% if (municipios!=null) {
                                            for (Municipio municipio : municipios) {%>
                                        <option value="<%=municipio.getId()%>">
                                            <%=municipio.getNombre()%>
                                        </option>
                                        <% }}%>
                                    </select>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </header>
        <%if(playas != null){%>
        <div class="row justify-content-center">
            <% for (Playa playa:playas){%>
            
            <div class=" col-lg-6  d-flex mb-3">
                <div class="card flex-fill">
                  <% 
                        
                        Images imagen = playa.getImagesList().get(0);
                        
                       
                  %>
                 
                 <img class="card-img-top" src="img/<%=playa.getId()  %>_<%= imagen.getId() %>.jpg" alt="" />
        
     
                       
                      
                
                   
                    
                    <div class="card-body">
                        <p class="card-title grande"><%=playa.getNombre() %></p>
                        <p><%=playa.getDescripcion()%></p>
                        <%if (user != null) {
                                
                            
                        %>
                        <div class=" float-left">
                            <button class=" p-0 border-0" style="font-size: 2rem;"data-toggle="modal" data-target="#modalresumen" data-partido="<%=playa.getId() %>" data-local="<%=playa.getNombre() %>"><i class="fa fa-info-circle" aria-hidden="true"></i></button>
                        </div>
                        <div class=" float-right">
                            <%Integer play = playa.getId(); Short usera = user.getId(); %>
                            <button class="p-0 border-0 d-flex " style=" font-size: 2rem" onclick="window.location.href='Controller?op=vaplaya&play=<%=play%>&user=<%=usera%>'"><i class="fa fa-star-half" aria-hidden="true"></i></button>
                        </div>
                        <%}%>
                    </div>
                </div>
            </div>
           <%}%>

        </div>
                        <%}%>

    </div>
        
    </div>
      <!-- Button trigger modal -->
      <div class="modal fade" id="modallogin" tabindex="-1" role="dialog" aria-labelledby="modelTitleId" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Login&Register</h5>
                       
                </div>
                 <form action="Controller?op=login" method="post">
                <div class="modal-body">
                   
                     
                        <p><input type="text" name="nick" id="" placeholder="Nick" class="w-100"></p>
                        <p><input type="password" name="password" id="" placeholder="Password"  class="w-100 form-control"></p>
                  
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary"><i class="fa fa-user" aria-hidden="true"></i> Login & Register</button>
                </div>
                      </form>
            </div>
             
        </div>
    </div>
      <div class="modal fade" id="modalresumen" tabindex="-1" role="dialog" aria-labelledby="modelTitleId"
       aria-hidden="true">
       <div class="modal-dialog" role="document">
           <div class="modal-content">
               <div class="modal-header">
               </div>
               
               <h5 class="text-center text-primary"></h5>
               <div class="container text-center" id="resumen"></div>

           </div>
       </div>
   </div>
    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
     <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
        integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
        crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
        integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
        crossorigin="anonymous"></script>
 <script src="myjs.js"></script>
  </body>
</html>