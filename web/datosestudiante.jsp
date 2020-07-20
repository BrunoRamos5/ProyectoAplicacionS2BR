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
        String s_idestudiante;
        String s_nombre;
        String s_apellidos;
        String s_dni;
        String s_codigo;
        String s_estado;

        %>
    </head>
    <body>
        
        <form name="AgregarEstudianteForm" action="datosestudiante.jsp" method="GET">
            <table border="0" align="center">
                <thead>
                    <tr>
                        <th colspan="2">Agregar Estudiante</th>
                        
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Nombres:</td>
                        <td><input type="text" name="f_nombre" value="" /></td>
                    </tr>
                    <tr>
                        <td>Apellidos:</td>
                        <td><input type="text" name="f_apellidos" value="" /></td>
                    </tr>
                    <tr>
                        <td>DNI: </td>
                        <td><input type="text" name="f_dni" value="" /></td>
                    </tr>
                    <tr>
                        <td>Código: </td>
                        <td><input type="text" name="f_codigo" value="" /></td>
                    </tr>
                    <tr>
                        <td>Estado: </td>
                        <td><input type="text" name="f_estado" value="" /></td>
                    </tr>
                    <tr align="center">
                        <td colspan="2">
                            <input type="submit" value="Agregar" name="f_agregar" />
                            <input type="hidden" name="f_accion" value="C" />
                        
                        </td>
                    </tr>
                </tbody>
            </table>
        </form>
        
        
        <table border="1" cellspacing="0" cellpadding="" align="center" class="table text-center col-7" style="font-size: 12px; margin-top:30px !important">
            <thead class="thead-dark">
            <tr>
                <th colspan="8" >Datos Estudiante</th>
            </tr>    
                <th class="text-center">#</th>
                <th class="text-center">Nombre</th>
                <th class="text-center">Apellidos</th>
                <th class="text-center">DNI</th>
                <th class="text-center">Codigo</th>
                <th class="text-center">Estado</th>
                <th class="text-center">Eliminar</th>
                <th class="text-center">Editar</th>
            </thead>   
        <%
            try {
            
                ConectaBd bd = new ConectaBd();
                cn = bd.getConnection();
                s_accion = request.getParameter("f_accion");
                s_idestudiante = request.getParameter("f_idestudiante");
                
                if (s_accion !=null) {
                    if (s_accion.equals("E")) {
                            consulta =    " delete from estudiante "
                                        + " where  "
                                        + " idestudiante = " + s_idestudiante +"; ";
                            //out.print(consulta);
                            pst = cn.prepareStatement(consulta);
                            pst.executeUpdate();
                    
                }else if(s_accion.equals("C")){
                            s_nombre = request.getParameter("f_nombre");
                            s_apellidos = request.getParameter("f_apellidos");
                            s_dni = request.getParameter("f_dni");
                            s_codigo = request.getParameter("f_codigo");
                            s_estado = request.getParameter("f_estado");
                            
                            consulta =    " insert into "
                                        + " estudiante (nombre, apellidos, dni, codigo, estado)"
                                        + " values('"+ s_nombre +"','"+ s_apellidos +"','"+ s_dni +"','"+ s_codigo +"','"+s_estado+"');  ";
                            //out.print(consulta);
                            pst = cn.prepareStatement(consulta);
                            pst.executeUpdate();
                    }                    
                }
            
                
                consulta = " Select idestudiante, nombre, apellidos, dni, codigo, estado "
                        + " from estudiante";
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
            <td><a href="datosestudiante.jsp?f_accion=E&f_idestudiante=<%out.print(ide);%>">Eliminar</a></td>
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
