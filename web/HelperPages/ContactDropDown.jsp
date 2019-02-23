<%-- 
    Document   : ContactDropDown
    Created on : 02-07-2018, 10:34:47 AM
    Author     : anthony
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
    <select name="contactid" id="contactid" class="form-control input-sm">
        <option selected>Seleccionar...</option>
    </select>
    <script>
        $(document).ready(function() {
		$('#providerid').on("change",function(event) {
			obtenerContactos(event);
		});
	});
        
        function obtenerContactos(e){
            var provideridtext = $("#providerid").val();
			// Si en vez de por post lo queremos hacer por get, cambiamos el $.post por $.get
			$.post('ProviderPhoneServlet',{tipo : "devolver",providerid : provideridtext}, function(responseText) {
				$('#contactid').html(responseText); 
			});
        }
    </script>
