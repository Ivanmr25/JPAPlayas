/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Entities.Ccaa;

import Entities.Municipio;
import Entities.Playa;

import Entities.Provincia;
import Entities.Punto;
import Entities.Usuario;
import java.io.IOException;
import java.sql.Connection;
import javax.persistence.EntityManager;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;
import Util.JPAUtil;
import java.util.List;
import javax.persistence.EntityTransaction;
import javax.persistence.Query;

/**
 * Servlet implementation class Controller
 */
@WebServlet("/Controller")
public class Controller extends HttpServlet {

    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public Controller() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
     * response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        /*
		 * Crear el singleton con
         */
    
        List<Ccaa> Ccaas;

        EntityManager em = (EntityManager) session.getAttribute("em");
        if (em == null) {
            em = JPAUtil.getEntityManagerFactory().createEntityManager();
            session.setAttribute("em", em);
        }
        Query q;
        String op = request.getParameter("op");
        if (op.equals("inicio")) {
           
            q = em.createNamedQuery("Ccaa.findAll");
           Ccaas = q.getResultList();
        
          
            session.setAttribute("comunidades", Ccaas);
     
            request.getRequestDispatcher("home.jsp").forward(request, response);
        } else if (op.equals("vacomunidad")) {
            String jornadatxt = request.getParameter("comunidad");
            Ccaa ccaa =  em.find( Ccaa.class, Short.parseShort(jornadatxt));
        
                  session.setAttribute("provincia", ccaa.getProvinciaList());
                 session.removeAttribute("municipio");
          session.removeAttribute("playas");
             request.getRequestDispatcher("home.jsp").forward(request, response);
        }
         else if (op.equals("vaprovincia")) {
            String jornadatxt = request.getParameter("provincia");
          Provincia provincia =  em.find(Provincia.class, Short.parseShort(jornadatxt));
        
                  session.setAttribute("municipio",provincia.getMunicipioList());
                 session.removeAttribute("playas");
         
             request.getRequestDispatcher("home.jsp").forward(request, response);
        }
          else if (op.equals("vapueblo")) {
            String jornadatxt = request.getParameter("municipio");
            Municipio municipio =  em.find(Municipio.class, Integer.parseInt(jornadatxt));
        
                  session.setAttribute("playas",municipio.getPlayaList());
            
         
             request.getRequestDispatcher("home.jsp").forward(request, response);
        }
          else if (op.equals("login")) {
           
            String pass = request.getParameter("password");
            String nombre = request.getParameter("nick");
           List<Usuario> users = em
            .createNamedQuery("Usuario.findByNick", Usuario.class)
            .setParameter("nick", nombre)
            .getResultList();
            
            if (users.isEmpty()) {
                Usuario user = new Usuario();
            user.setNick(nombre);
            user.setPass(pass);
                
           
                EntityTransaction t = em.getTransaction();
                   t.begin();
                   em.persist(user);
                   t.commit();
                   session.setAttribute("user", user);
                   request.getRequestDispatcher("home.jsp").forward(request, response);
            }else {
            Usuario user = users.get(0);
            if (user.getPass().equals(pass)) {
              session.setAttribute("user", user);
            }
            
            request.getRequestDispatcher("home.jsp").forward(request, response);
        }
          }
        else if(op.equals("logout")){
                session.removeAttribute("user");
                session.setAttribute("msg", "Logout satisfactorio");
                request.getRequestDispatcher("home.jsp").forward(request, response);
            } else if(op.equals("resumen")){
                 String partido = request.getParameter("partido");
                    String img = "img";
                    String ic_ = "/ic_";
                    String imga = "<img src="+img+ic_+"";
                    String width = "width:50px;";
                    String estilo =  "style="+width+"";
                    String png = ".png  "+estilo+ ">  ";
                   q = em.createQuery("SELECT concat('"+imga+"', p.puntos ,'"+png+"  ','Basado en ' ,count(p.usuario.id),' reseñas') FROM Punto p WHERE p.playa.id="+partido+" GROUP BY p.puntos");
                 List<String> resumen = q.getResultList();

                
   
                 session.setAttribute("resumen", resumen);
               
                    request.getRequestDispatcher("resumen.jsp").forward(request, response);
            }
            else if(op.equals("vaplaya")){
                String playita = request.getParameter("play");
                String usera = request.getParameter("user");
                Playa playa = em.find(Playa.class, Integer.parseInt(playita));
                Usuario user = em.find(Usuario.class, Short.parseShort(usera));
                q = em.createQuery("SELECT  AVG (p.puntos) FROM Punto p WHERE p.playa.id="+playita+"");
                Double resultado = (Double) q.getSingleResult();
                session.setAttribute("playa", playa);
                session.setAttribute("punto", resultado);
                session.setAttribute("user", user);
                request.getRequestDispatcher("playa.jsp").forward(request, response);
            }else if(op.equals("vapuntos")){
                String user = request.getParameter("user");
                String playita = request.getParameter("playa");
                String pt = request.getParameter("pt");
                
                
                Short puntos = Short.parseShort(pt);
            
          
                   Punto punto = new Punto(1);
        Playa playa = em.find(Playa.class, Integer.parseInt(playita));
        Usuario usuario = em.find(Usuario.class, Short.parseShort(user));
        punto.setPuntos(puntos);
        punto.setUsuario(usuario);
        punto.setPlaya(playa);
        EntityTransaction t = em.getTransaction();
        t.begin();
        em.persist(punto);       
        t.commit();
        playa = em.find(Playa.class, playa.getId());
        session.setAttribute("playa",playa);
        

    request.getRequestDispatcher("home.jsp").forward(request, response);
  }
         
          
            }
            
          
            
        
    

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
     * response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
        doGet(request, response);
    }

}

