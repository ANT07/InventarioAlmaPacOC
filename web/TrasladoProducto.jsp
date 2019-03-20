<%-- 
    Document   : InsertarAlumno
    Created on : 4/11/2018, 06:56:58 PM
    Author     : ANTHONY MARTINEZ
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registro de Traslado</title>
        <style>
            .login{
                width: 700px;
                border: 1px solid #E1E1E1;
                border-radius: 4px;
                padding: 15px;
                position: absolute;
                top: 50%;
                left: 50%;

            }
            body
            {
                background: #00606F;
            }
            #cont{
                background: #e9e9e9;
            }

        </style>
    </head>
    <body>
        <%@include file="/WEB-INF/jspf/NavBar.jspf"%><br><br>
        <%
            DepartmentImpl departmentImpl = new DepartmentImpl();
        %>
        <div class="">
            <div  class="col-xs-6 col-xs-offset-3 " id="cont" >
                <form action="traslado.do"  method="post" class="usuario form-horizontal" id="FormCrearUs">
                    <input type="hidden" name="tipo" value="insertar">
                    <div class="form-header">
                        <h3 class="text-center">Traslado de Producto</h3>
                    </div>  <hr>

                    <!--Carnet-->
                    <div class="form-group">
                        <label class="col-md-4 control-label">Producto</label>
                        <div class="col-md-6  inputGroupContainer">
                            <div class="input-group"> <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                                <%@include file="/HelperPages/ProductDataList.jsp" %>
                            </div>
                        </div>
                    </div>
                    <!--Nombre-->
                    <div class="form-group">
                        <label class="col-md-4 control-label">Bodega de Origen</label>
                        <div class="col-md-6  inputGroupContainer">
                            <div class="input-group"> <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                                    <%@include file="/WEB-INF/jspf/departamentosOrigen.jspf" %>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-md-4 control-label" >Bodega de Destino</label>
                        <div class="col-md-6  inputGroupContainer">
                            <div class="input-group"> <span class="input-group-addon"><i class="glyphicon glyphicon-earphone"></i></span>
                                    <%@include file="/WEB-INF/jspf/departamentosDestino.jspf" %>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-4 control-label" >Cantidad a Trasladar</label>
                        <div class="col-md-6  inputGroupContainer">
                            <div class="input-group"> <span class="input-group-addon"><i class="glyphicon glyphicon-earphone"></i></span>
                                <input type="number" min="1" step="0.01" class="form-control" name="cantidadTralado">
                            </div>
                        </div>
                    </div>
                    <center>

                        <span><input  type="submit" class="btn btn-primary btn-md" value="Insertar" >
                            <button type="button" class="btn btn-success" data-toggle="modal" data-target="#modalCanc">Cancelar</button>
                        </span></center><br>
                </form> 
            </div>  
            <div class="modal fade" id="modalCanc" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" >
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header" >
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <center><h4 class="modal-title"><b>Cancelar</b></h4></center>  
                        </div>
                        <div class="modal-body">
                            <center><b>¿Desea salir de la página actual?</b></center>
                        </div>
                        <div class="modal-footer">
                            <center>
                                <a href="ListaClientes.jsp"><button type="submit" class="btn btn-default">Ir a la lista de clientes</button></a>
                                <button class="btn btn-info btn-m" data-dismiss="modal" aria-hidden="true">Permanecer aquí</button></center>
                        </div>
                    </div>
                </div>
            </div>        
        </div>
        <script src="//oss.maxcdn.com/jquery.bootstrapvalidator/0.5.3/js/bootstrapValidator.min.js"></script>

        <script src="js/jquery-3.1.1.min.js"></script>

        <script type="text/javascript">

            function valida(e) {
                tecla = (document.all) ? e.keyCode : e.which;

                if (tecla == 8) {
                    return true;
                }

                patron = /[0-9]/;
                tecla_final = String.fromCharCode(tecla);
                return patron.test(tecla_final);
            }

            $('#FormCrearUs').bootstrapValidator({
                message: 'Este valor no es valido',
                feedbackIcons: {
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'
                },
                fields: {
                    txtNombre: {
                        validators: {
                            notEmpty: {

                                message: 'El nombre del cliente es requerido'

                            }
                        }
                    }
                }
            });

        </script>

    </body>
</html>
