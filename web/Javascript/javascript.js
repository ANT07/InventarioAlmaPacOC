/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
function totalizar(){
    var subTotalElemento = document.getElementById("subTotal");
    var totalIvaElemento = document.getElementById("totalIva");
    var totalElemento = document.getElementById("total");
    
    var montos = document.getElementsByName("monto");
    var subTotal = 0;
    for(i = 0; i<montos.length ; i++){
        subTotal += parseFloat(montos[i].value) || 0   ;
    }
    
    
    var iva = subTotal * 0.13
    var total = iva + subTotal;
    
//    subTotalElemento.value = round(subTotal);
//    totalIvaElemento.value = round(iva);
//    totalElemento.value = round(total);
    
    subTotalElemento.value = subTotal.toFixed(2);
    totalIvaElemento.value = iva.toFixed(2);
    totalElemento.value = total.toFixed(2); 
}

function round(numero) {
    var opciones = {
        maximumFractionDigits: 2, 
        useGrouping: false
    };
    return new Intl.NumberFormat("en", opciones).format(numero);
}

function sumaDetalle(e){
    var elemento = e.target;
    var celda = elemento.parentNode;
    var fila = celda.parentNode;
    
    var cantidadText = $("table tr#"+fila.id+" td input[id='cantidad']");
    var precioUnitarioText = $("table tr#"+fila.id+" td input[id='precioUnitario']");
    var montoText = $("table tr#"+fila.id+" td input[id='monto']");
    
    var cantidad = cantidadText.val() || 0;
    var precioUnitario = precioUnitarioText.val() || 0;
    //var monto    = round(cantidad * precioUnitario);
    var monto    = (cantidad * precioUnitario).toFixed(2);
    
    montoText.val(monto);
    
    totalizar();
}


function onlyDecimalNumber(e){
    var char = e.key;
    var elemento = e.target;
    var textoElemento = elemento.value;
    
    if((char >= '0' && char <='9') || (char == 'Backspace')){
        return true;
    }
    
    if(char == '.' && textoElemento.length != 0){
        for(i = 0 ; i< textoElemento.length ; i++){
            if(textoElemento.charAt(i) == '.'){
                return false;
            }
        }
        return true;
    }
    
    return false;
}

function onlyNumber(e,length){
    var elemento = e.target;
    var textoElemento = elemento.value;
    var char = e.key;
    
    if(textoElemento.length < length){
        if(char >= '0' && char <= '9'){
            return true;
        }
    }
    return false; 
}

function cambiarTipo(){
    var tipo = document.getElementById("tipo");
    tipo.value = "guardar"; 
}

function habilitarSelect(){       
    var providerIdSelect = document.getElementById("providerid");
    providerIdSelect.disabled = false; 
}

function habilitarText(){       
    var productIdText = document.getElementById("produtcid");
    productIdText.readOnly = false; 
}

function abrirDialogoContact(contactid,providerid,contactname,contactstate,contactphone){
        var tipo = document.getElementById("tipo");
        tipo.value = "editar";
        
        var providerIdSelect = document.getElementById("providerid");
        var providerIdHidden = document.getElementById("providerId");
        var contactIdHidden = document.getElementById("contactid");
        var contactNameText = document.getElementById("contactname");
        var contactPhoneText = document.getElementById("contactphone");
        var contactStateCheck = document.getElementById("contactstate");
        
        providerIdHidden.value = providerid;
        providerIdSelect.value = providerid;
        providerIdSelect.disabled = true;
        contactIdHidden.value = contactid;
        contactNameText.value = contactname;
        contactPhoneText.value = contactphone;
        
        if(contactstate == 1){
            contactStateCheck.setAttribute("checked","true");
        }
        else{
            contactStateCheck.removeAttribute("checked");
        }
    }

function abrirDialogoProduct(productid,productname,productstate){
        var tipo = document.getElementById("tipo");
        tipo.value = "editar";
        
        var produtcIdText = document.getElementById("produtcid");
        var produtcNameText = document.getElementById("produtcname");
        var produtcStateCheck = document.getElementById("produtcstate");
        
        produtcIdText.value = productid;
        produtcIdText.readOnly = true;
        produtcNameText.value = productname;
        
        if(productstate == 1){
            produtcStateCheck.setAttribute("checked","true");
        }
        else{
            produtcStateCheck.removeAttribute("checked");
        }
}


function abrirDialogoDepartment(departmentid,departmentname,departmentstate){
        var tipo = document.getElementById("tipo");
        tipo.value = "editar";
        
        var departmentIdHidden = document.getElementById("departmentid");
        var departmentNameText = document.getElementById("departmentname");
        var departmentStateCheck = document.getElementById("departmentstate");
        
        departmentIdHidden.value = departmentid;
        departmentNameText.value = departmentname;
        
        if(departmentstate == 1){
            departmentStateCheck.setAttribute("checked","true");
        }
        else{
            departmentStateCheck.removeAttribute("checked");
        }
}

function abrirDialogoType(typeid,typename,typestate){
        var tipo = document.getElementById("tipo");
        tipo.value = "editar";
        
        var typeIdHidden = document.getElementById("typeid");
        var typeNameText = document.getElementById("typename");
        var typeStateCheck = document.getElementById("typestate");
        
        typeIdHidden.value = typeid;
        typeNameText.value = typename;
        
        if(typestate == 1){
            typeStateCheck.setAttribute("checked","true");
        }
        else{
            typeStateCheck.removeAttribute("checked");
        }
}

function abrirDialogoSeller(sellerid,sellername,sellerstate){
        var tipo = document.getElementById("tipo");
        tipo.value = "editar";
        
        var sellerIdHidden = document.getElementById("sellerid");
        var sellerNameText = document.getElementById("sellername");
        var sellerStateCheck = document.getElementById("sellerstate");
        
        sellerIdHidden.value = sellerid;
        sellerNameText.value = sellername;
        
        if(sellerstate == 1){
            sellerStateCheck.setAttribute("checked","true");
        }
        else{
            sellerStateCheck.removeAttribute("checked");
        }
}


function abrirDialogo(providerid,providername,providerstate){
        var tipo = document.getElementById("tipo");
        tipo.value = "editar";
        
        var providerIdHidden = document.getElementById("providerid");
        var providerNameText = document.getElementById("providername");
        var providerStateCheck = document.getElementById("providerstate");
        
        providerIdHidden.value = providerid;
        providerNameText.value = providername;
        
        if(providerstate == 1){
            providerStateCheck.setAttribute("checked","true");
        }
        else{
            providerStateCheck.removeAttribute("checked");
        }
}

    function resetForm(){
        var form = document.getElementById("form");
        form.reset();
    }
    
    /*$(document).ready(function () {
                 $('#sidebarCollapse').on('click', function () {
                     $('#sidebar').toggleClass('active');
                 });
    });*/
    
    function dialogs(titulo,mensaje){
        $("#contenedor").attr("title",titulo);
        $("#mensaje").html(mensaje);
        $("#contenedor").dialog({
            width : 400,
            height : "auto",
            draggable : false,
            closeOnScape : true,
            modal : true,
            buttons : {
                "Aceptar" : function(){
                    $(this).dialog("close");
                }
            }
        });
    }
    
    function validar(e){
        //e.preventDefault();
        dialogs("Error de datos","Complete todos los campos");
    }
    
    window.onload = comenzar;
    
    function comenzar(){
        formularios = document.querySelectorAll("input[type='text']");
        
        for (var i = 0; i < formularios.length; i++) {
            formularios[i].required = true;
        }
        
        /*for (var i = 0; i < formularios.length; i++) {
        
            formularios[i].addEventListener("invalid",validar,false);
        }*/
    }