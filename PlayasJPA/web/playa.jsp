

<%@page import="Entities.Usuario"%>
<%@page import="Entities.Images"%>
<%@page import="java.util.List"%>
<%@page import="Entities.Playa"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="en">
    <%
    Playa playa = (Playa)session.getAttribute("playa");
    Double punto = (Double) session.getAttribute("punto");
    Usuario user = (Usuario) session.getAttribute("user");
    
    
    
    %>
<head>
  <title>Playa</title>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <!-- Bootstrap CSS -->
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
    integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
  <link href="style.css">
</head>

<body>

  <div class="container-fluid">




    <div class="card flex-fill">






      <div class="card-body bg-info">
        <h1 class="card-title grande text-center text-white">
          <%=playa.getNombre() %>
        </h1>
    
       
            <div class="d-flex justify-content-center">
                
         <h2 class="card-title grande text-center text-white">
             <img src="img/ccaa_<%=playa.getMunicipio().getProvincia().getCcaa().getId()%>.png" alt="" style="width: 50px;">
             
             <%=playa.getMunicipio().getNombre() %>(<%=playa.getMunicipio().getProvincia().getNombre() %>)
                 <img src="img/ccaa_<%=playa.getMunicipio().getProvincia().getCcaa().getId()%>.png" alt="" style="width: 50px;">
        </h2>
            </div>
         
        <h3 class="card-title grande text-center text-white"> <%=playa.getDescripcion()%></h3>
      <div class="d-flex justify-content-center">
          <% if (punto != null) {
                  
             
          %>
        <img src="img/ic_<%=punto.intValue() %>.png"  class="justify-content-center" style="width: 50px;"></img>
        <%}%>
       </div>  
       
      </div>
    </div>
    
        <%  
            
                        List<Images> imagesList = playa.getImagesList();
                        Images imagen = imagesList.get(0);
                        
                      
                  %>
     
          
        <%if(imagen != null){%>
         <div id="carouselId" class="carousel slide" data-ride="carousel">
      <ol class="carousel-indicators">
        <li data-target="#carouselId" data-slide-to="0" class="active"></li>
        <li data-target="#carouselId" data-slide-to="1"></li>
        <li data-target="#carouselId" data-slide-to="2"></li>
         <li data-target="#carouselId" data-slide-to="3"></li>
      </ol>
      <div class="carousel-inner" role="listbox">
        <div class="carousel-item active">
           <img class="card-img-top" src="img/<%=playa.getId()  %>_<%= imagen.getId() %>.jpg" alt="" />
        </div>
        <div class="carousel-item">
            <%  
                        if (imagesList != null && imagesList.size() > 1) {
                     imagen = imagesList.get(1);
  // código para trabajar con la imagen aquí
}
                       
                        
                      if(imagen != null){
                  %>
            <img class="card-img-top" src="img/<%=playa.getId()  %>_<%= imagen.getId() %>.jpg" alt=""  />
            <%}%>
        </div>
        <div class="carousel-item">
             <%  
                            if (imagesList != null && imagesList.size() > 2) {
                     imagen = imagesList.get(2);
  // código para trabajar con la imagen aquí
}
                    
                        
                            if(imagen != null){
                  %>
            <img class="card-img-top" src="img/<%=playa.getId()  %>_<%= imagen.getId() %>.jpg" alt=""  />
            <%}%>
        </div><div class="carousel-item">
             <%  
                
                            if (imagesList != null && imagesList.size() > 3) {
                     imagen = imagesList.get(3);
  // código para trabajar con la imagen aquí
}
                     
                 
                 if(imagen != null){
                        
                  %>
            <img class="card-img-top" src="img/<%=playa.getId()  %>_<%= imagen.getId() %>.jpg" alt="" />
            <%}%>
        </div>      </div>
      <a class="carousel-control-prev" href="#carouselId" role="button" data-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
      </a>
      <a class="carousel-control-next" href="#carouselId" role="button" data-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
      </a>
    </div>
    <%}%>
        
        <p class="mt-auto mb-1 text-center">
      <% for (int i = 1; i < 6; i++) { %>
      <a href="Controller?op=vapuntos&playa=<%=playa.getId()%>&user=<%=user.getId() %>&pt=<%=i%>"> <img src="img/ic_<%=i%>.png"   style="width: 50px;"></img</a>
                <%}%>
        </p>


  <!-- Optional JavaScript -->
  <!-- jQuery first, then Popper.js, then Bootstrap JS -->
  <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
    integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
    crossorigin="anonymous"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
    integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
    crossorigin="anonymous"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
    integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
    crossorigin="anonymous"></script>
</body>

</html>
