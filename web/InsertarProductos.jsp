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
        <title>Insertar producto</title>
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
        <%@include file="WEB-INF/jspf/NavBar.jspf"%>
        <div class="">
            <div  class="col-xs-6 col-xs-offset-3 " id="cont" >
                <label>${Mensaje}</label>
                <form action="productoscontrolador.do"  method="post" class="usuario form-horizontal" id="FormCrearUs">
                    <input type="hidden" name="Tipo" value="insertar">
                    <div class="form-header">
                        <h3 class="text-center">Crear producto</h3>
                    </div>  <hr>

                    <!--Carnet-->
                    <div class="form-group">
                        <label class="col-md-4 control-label">Nombre</label>
                        <div class="col-md-6  inputGroupContainer">
                            <div class="input-group"> <span class="input-group-addon"><i class="glyphicon glyphicon-apple"></i></span>
                                <input type="text" class="form-control" placeholder="Nombre del producto" name="txtNombre" data-error="some error" required >
                            </div>
                        </div>
                    </div>
                    <!--Nombre-->
                    <div class="form-group">
                        <label class="col-md-4 control-label">Descripcion</label>
                        <div class="col-md-6  inputGroupContainer">
                            <div class="input-group"> <span class="input-group-addon"><i class="glyphicon glyphicon-text-size"></i></span>
                                <input type="text" class="form-control" placeholder="Descripcion" name="txtDescripcion" data-error="some error" required >
                            </div>
                        </div>
                    </div>
                    <!--Descripcion-->
                    <div class="form-group">
                        <label class="col-md-4 control-label" >Precio</label>
                        <div class="col-md-6  inputGroupContainer">
                            <div class="input-group"> <span class="input-group-addon"><i class="glyphicon glyphicon-usd"></i></span>
                                <input onkeypress="return valida(event)" name="txtPrecio" min="0" step="0.01" placeholder="Precio" class="form-control"  type="number" data-error="some error" required >
                            </div>
                        </div>
                    </div>
                    <!--Descripcion-->





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
                                <a href="ListaProductos.jsp"><button type="submit" class="btn btn-default">Ir a la lista de productos</button></a>
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

                                        patron = /[0-9 \d/./]/;
                                        tecla_final = String.fromCharCode(tecla);
                                        return patron.test(tecla_final);
                                    }

                                    $('#FormCrearUs').bootstrapValidator({

                                        feedbackIcons: {
                                            valid: 'glyphicon glyphicon-ok',
                                            invalid: 'glyphicon glyphicon-remove',
                                            validating: 'glyphicon glyphicon-refresh'
                                        },
                                        fields: {
                                            txtNombre: {
                                                validators: {
                                                    stringLength: {
                                                        min: 2,
                                                        message: 'Por favor ingrese 2 caracteres como mínimo'
                                                    },
                                                    notEmpty: {

                                                        message: 'El nombre del producto es requerido'

                                                    },

                                                }
                                            },
                                            txtDescripcion: {
                                                validators: {
                                                    stringLength: {
                                                        min: 5,
                                                        message: 'Por favor ingrese 5 caracteres como mínimo'
                                                    },
                                                    notEmpty: {
                                                        message: 'La descripcion del producto es requerida'
                                                    },

                                                }
                                            },
                                            txtPrecio: {
                                                validators: {

                                                    notEmpty: {
                                                        message: 'El precio del producto es requerido'
                                                    },

                                                    numeric: {
                                                        message: 'El precio no es válido'
                                                    },
                                                }
                                            },

                                        }
                                    })

        </script>
    </body>
</html>
