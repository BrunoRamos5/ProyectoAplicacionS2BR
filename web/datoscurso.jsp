<%@page import="java.sql.*" %>
<%@page import="bd.*" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Datos Estudiante</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
        <%! 
        String consulta;
        Connection cn;
        PreparedStatement pst;
        ResultSet rs;
        String s_accion;
        String s_idcurso;
        String s_codigo;
        String s_nombre;
        String s_horas;
        String s_creditos;
        String s_estado;
        
      
        %>
    </head>
    <body>
          
        <table border="1" cellspacing="0" cellpadding="" align="center" class="table text-center col-7" style="font-size: 12px; margin-top:30px !important">
            
            <thead class="thead-dark">
                <th class="text-center">#</th>
                <th class="text-center">Codigo</th>
                <th class="text-center">Curso</th>
                <th class="text-center">Total Horas</th>
                <th class="text-center">Total Creditos</th>
                <th class="text-center">Estado</th>
                <th class="text-center">Eliminar</th>
                <th class="text-center">Editar</th>
            </thead>   
        <%
            try {
            
                ConectaBd bd = new ConectaBd();
                cn = bd.getConnection();
                s_accion = request.getParameter("f_accion");
                s_idcurso = request.getParameter("f_idcurso");
                
                
                 if (s_accion !=null) {
                    if (s_accion.equals("E")) {
                            consulta =    " delete from curso "
                                        + " where  "
                                        + " idcurso = " + s_idcurso +"; ";
                            //out.print(consulta);
                            pst = cn.prepareStatement(consulta);
                            pst.executeUpdate();
                    
                }}
                
               
                
                consulta = " Select idcurso, codigo, nombre, horas, creditos, estado "
                        + " from curso";
                pst = cn.prepareStatement(consulta);
                rs = pst.executeQuery();
                int num = 0;
                String ide;
               
                while (rs.next()){
                ide = rs.getString(1);
                num++;
        %>         
        <tr>
            <td><%out.print(num);%></td> 
            <td><%out.print(rs.getString(2));%></td> 
            <td><%out.print(rs.getString(3));%></td> 
            <td><%out.print(rs.getString(4));%></td> 
            <td><%out.print(rs.getString(5));%></td> 
            <td><%out.print(rs.getString(6));%></td>
            <td><a href="datoscurso.jsp?f_accion=E&f_idcurso=<%out.print(ide);%>">Eliminar</a></td>
            <td>Editar</td>
           
        </tr>
                    
        <% 
                }
            }catch(Exception e){
                out.print("ERROR SQL");
            }
         %>
    </table>
    </body>
</html>
