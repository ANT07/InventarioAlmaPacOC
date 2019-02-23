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
        <title>Actualizar Cliente</title>
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
                padding-top: 60px;
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
                <form action="clientescontrolador.do"  method="post" class="usuario form-horizontal" id="FormCrearUs">
                    <input type="hidden" name="Tipo" value="actualizar">
                    <div class="form-header">
                        <h3 class="text-center">Actualizar cliente</h3>
                    </div>  <hr>
                    <div class="form-group">
                        <label class="col-md-4 control-label">ID</label>
                        <div class="col-md-6  inputGroupContainer">
                            <div class="input-group"> <span class="input-group-addon"><i class="glyphicon glyphicon-check"></i></span>
                                <input type="text" class="form-control" readonly value="${client.idCliente}" placeholder="Nombre del cliente" name="txtId" id="nombre" data-minLength="5" data-error="some error" required >
                            </div>
                        </div>
                    </div>
                    <!--Carnet-->
                    <div class="form-group">
                        <label class="col-md-4 control-label">Nombre</label>
                        <div class="col-md-6  inputGroupContainer">
                            <div class="input-group"> <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                                <input type="text" class="form-control" value="${client.nombreCliente}" placeholder="Nombre del cliente" name="txtNombre" id="nombre" data-minLength="5" data-error="some error" required >
                            </div>
                        </div>
                    </div>
                    <!--Nombre-->
                    <div class="form-group">
                        <label class="col-md-4 control-label">Apellido</label>
                        <div class="col-md-6  inputGroupContainer">
                            <div class="input-group"> <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                                <input type="text" class="form-control" value="${client.apellidoCliente}" placeholder="Apellido" name="txtApellido" id="nombre" data-minLength="5" data-error="some error" required >
                            </div>
                        </div>
                    </div>
                    <!--Apellido-->
                    <div class="form-group">
                        <label class="col-md-4 control-label" >Dirección</label>
                        <div class="col-md-6  inputGroupContainer">
                            <div class="input-group"> <span class="input-group-addon"><i class="glyphicon glyphicon-home"></i></span>
                                <input name="txtDireccion" placeholder="Direccion" value="${client.direccionCliente}" class="form-control"  type="text" data-minLength="5" data-error="some error" required >
                            </div>
                        </div>
                    </div>
                    <!--Apellido-->
                    <div class="form-group">
                        <label class="col-md-4 control-label" >Teléfono</label>
                        <div class="col-md-6  inputGroupContainer">
                            <div class="input-group"> <span class="input-group-addon"><i class="glyphicon glyphicon-earphone"></i></span>
                                <input name="txtTelefono" placeholder="Teléfono" value="${client.telefonoCliente}" class="form-control"  type="text" data-minLength="5" data-error="some error" required >
                            </div>
                        </div>
                    </div>

                    <!--Apellido-->
                    <div class="form-group">
                        <label class="col-md-4 control-label">Sexo</label>
                        <div class="col-md-6 selectContainer">
                            <div class="input-group"> <span class="input-group-addon"><i class="glyphicon glyphicon-list"></i></span>
                                <input type="hidden" id='sexoCliente' value='${client.sexoCliente}'>
                                <select id="selectSexo" name="sexoCliente" class="form-control selectpicker"  data-minLength="5" data-error="some error" required>
                                    <option value="M" >Masculino</option>                     
                                    <option value="F">Femenino</option>                           
                                </select>
                            </div>
                        </div>
                    </div>
                    <script>
                        function comenzar() {
                            var sexoHidden = document.getElementById("sexoCliente");
                            var select = document.getElementById("selectSexo");
                            select.value = sexoHidden.value;
                        }
                        window.onload = comenzar;
                    </script>
                    <center>

                        <span>
                            <a href="#modalGuardar" data-toggle="modal"> <input type="button" class="btn btn-primary btn-md" value="Guardar" ></a>
                            <button type="button" class="btn btn-success" data-toggle="modal" data-target="#modalCanc">Cancelar</button>
                        </span></center><br>



                    <div class="modal fade" id="modalGuardar" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" >
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header" >
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    <center><h4 class="modal-title"><b>Cancelar</b></h4></center>  
                                </div>
                                <div class="modal-body">
                                    <center><b>¿Desea actualizar el cliente?</b></center>
                                </div>
                                <div class="modal-footer">
                                    <center>
                                        <a href="ListaClientes.jsp"><button type="submit" class="btn btn-primary">Actualizar</button></a>
                                        <button class="btn btn-danger btn-m" data-dismiss="modal" aria-hidden="true">Cancelar</button></center>
                                </div>
                            </div>
                        </div>
                    </div> 
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
                            stringLength: {
                                min: 5,
                                message: 'Por favor ingrese 5 caracteres como mínimo'
                            },
                            notEmpty: {

                                message: 'El nombre del cliente es requerido'

                            },
                            

                        }
                    },
                    txtApellido: {
                        validators: {
                            stringLength: {
                                min: 5,
                                message: 'Por favor ingrese 5 caracteres como mínimo'
                            },
                            notEmpty: {
                                message: 'El apellido del cliente es requerido'
                            },
                            
                        }
                    },
                    txtDireccion: {
                        validators: {
                            stringLength: {
                                min: 10,
                                message: 'Por favor ingrese 10 caracteres como mínimo'
                            },
                            notEmpty: {
                                message: 'La dirección del cliente es requerida'
                            }
                        }
                    },
                    txtTelefono: {
                        validators: {
                            stringLength: {
                                min: 8,

                                message: 'Por favor ingrese 8 caracteres como mínimo (sin guiones)'
                            },
                            notEmpty: {
                                message: 'El teléfono es requerido'
                            }
                        }
                    },
                    sexoCliente: {
                        validators: {

                            notEmpty: {
                                message: 'El sexo es requerido'
                            }
                        }
                    },
                    

                }
            })

        </script>

        </div>
    </body>
</html>
