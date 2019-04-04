<%-- 
    Document   : InsertarVendedor
    Created on : 11-08-2018, 08:13:21 PM
    Author     : David
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Insertar Departamento</title>
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
        <%@include file="WEB-INF/jspf/NavBar.jspf"%><br><br>
        <div class="">
            <div  class="col-xs-6 col-xs-offset-3 " id="cont" >
                <label>${Mensaje}</label>
                <form action="department.do"  method="post" class="usuario form-horizontal" id="FormCrearUs">
                    <input type="hidden" name="tipo" value="insertar">
                    <input type="hidden" name="departemetstate" value="1">
                    <div class="form-header">
                        <h3 class="text-center">NUEVO DEPARTAMENT0 </h3>
                    </div>  <hr>

                    <div class="form-group">
                        <label class="col-md-4 control-label">Nombre Departamento:</label>
                        <div class="col-md-6  inputGroupContainer">
                            <div class="input-group"> <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                                <input type="text" class="form-control" placeholder="Nombre Departamento" name="departmentname" id="departmentname" data-minLength="5" data-error="some error" required >
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-4 control-label">¿Sera almacen de inventario?</label>
                        <div class="col-md-6  inputGroupContainer">
                            <div class="radio-inline">
                                <input type="radio" name="inventario" checked value="1"> Si<br>
                                <input type="radio" name="inventario" value="0"> No
                            </div>
                        </div>
                    </div>
                    <center>

                        <span><input id="guardarbtn" type="submit" class="btn btn-primary btn-md" value="Insertar" >
                            <button  type="button" class="btn btn-success" data-toggle="modal" data-target="#modalCanc">Cancelar</button>
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
                                <a href="ListaDepartamentos.jsp"><button type="submit" class="btn btn-default">Ir a la lista de Tipos</button></a>
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
                departmentname: {
                    validators: {
                        notEmpty: {

                            message: 'El nombre del vendedor es requerido'

                        }
                    }
                }
            }
        });

        </script>

    </body>
</html>
