/*****************************************************************************************************************/
/*                                            JS FUNCIONES GENERICAS                                             */
/*****************************************************************************************************************/

/****************************************************************************/
/******>>>>> METODOS AJAX ***************************************************/
/****************************************************************************/

/**
 * Realiza una petición via ajax sync.
 * @param {String} xRuta: archivo que recibe los parametros pasados en str_param. Devuelve código html
 * @param {String} xIdElemento: identificador del elemento donde se desplegarán los datos que arroje arch_busqueda
 * @param {String} xParametros: es una string con los parametros y valores que se le va a pasar por POST al arch_busqueda
 * @returns {String} cadena html respuesta de la petición
 */
function cargaAjax(xRuta, xIdElemento, xParametros)
{
    try
    {
        elemento = document.getElementById(xIdElemento);
        if (elemento != null)
        {
            xParametros = replaceParametros(xParametros);
            $.ajax(
                    {
                        type: "POST",
                        async: false,
                        url: xRuta,
                        data: xParametros,
                        contentType: "application/x-www-form-urlencoded",
                        dataType: "html",
                        beforeSend: function ()
                        {
//                            elemento.innerHTML = "<img src=\"images/loader.gif\" style=\"width: 105px;\"/>";
                            elemento.innerHTML = "<div class=\"loader\">"+
                                                "<div class=\"row\">"+
                                                    "<div class=\"col-3 loader-section section-left\">"+
                                                        "<div class=\"bg\"></div>"+
                                                    "</div>"+
                                                    "<div class=\"col-3 loader-section section-left\">"+
                                                        "<div class=\"bg\"></div>"+
                                                    "</div>"+
                                                    "<div class=\"col-3 loader-section section-right\">"+
                                                        "<div class=\"bg\"></div>"+
                                                    "</div>"+
                                                    "<div class=\"col-3 loader-section section-right\">"+
                                                        "<div class=\"bg\"></div>"+
                                                    "</div>"+
                                                "</div>"+
                                            "</div>";
                        },
                        success: function (datos)
                        {
                            $('#recarga').attr('innerHTML', '');
                            elemento.innerHTML = datos;
                            buscarScripts(datos);
                        },
                        error: function (obj, textStatus, excep)
                        {
                            if (obj.status == 404)
                            {
                                showMensaje('Error Recarga - Status ' + obj.status + ': La direccion no existe.', 'error');
                            } else
                            {
                                showMensaje('Error Recarga - Status ' + obj.status + ': ' + textStatus + ' ' + excep + '.', 'error');
                            }
                        }
                    });
        } else {
//            alert("sale");
        }
    } catch (e)
    {
        showMensaje(e, 'error');
    }
}

/**
 * Permite que se ejecuten los scripts llamados vía AJAX, pero los scripts deben estar con el siguiente formato <script>...código...</script>.
 * @param {String} scripts: cadena con html y javascript incrustado
 */
function buscarScripts(scripts)
{
    while (scripts.indexOf("<script>") != -1)
    {
        restohtml = scripts.substring(scripts.indexOf("/script") + 7, scripts.length);
        scripts = scripts.substring(scripts.indexOf("<script>") + 8, scripts.indexOf("/script") - 1);
        eval(scripts);
        scripts = restohtml;
    }
}

/**
 * Devulve todos los parametros del formulario para ser enviados
 * @param {}
 * @returns {String}  cadenaFormulario parametros del formulario
 */
function getParams()
{
    var results = jQuery(document.getElementById('formulario')).serialize();
    results = decodeURI(results);

    return results;
}

/****************************************************************************/
/******>>>>> OTROS METODOS GENERICOS ****************************************/
/****************************************************************************/

/**
 * Funcion generica para mostrar mensajes emergentes.
 * @param {String} xMensaje: mensaje que se muestra
 * @param {String} xClass: estilo del mensaje
 */
function showMensaje(xMensaje, xClass)
{
    var errorBaseInsert = -1;
    var errorBaseDelete = -1;

    xMensaje = String(xMensaje); // Por las dudas que el mensaje no venga como un String del lado de javascript

    errorBaseInsert = xMensaje.indexOf("PRIMARY KEY", 0);
    errorBaseDelete = xMensaje.indexOf("InstrucciÃ³n DELETE en conflicto con la restricciÃ³n REFERENCE", 0);

    if (errorBaseInsert >= 0)
    {
        xMensaje = "No se puede insertar un registro duplicado.";
        xClass = "alerta";
    }

    if (errorBaseDelete >= 0)
    {
        xMensaje = "No se puede borrar registro, existe información relacionada.";
        xClass = "alerta";
    }

    var elemMensaje = document.getElementById('Mensaje');
    var cantidadDIV = elemMensaje.getElementsByTagName('DIV').length;

    //Limpia si hay mas de 6 mensajes en pantalla
    if (cantidadDIV >= 6) {
        $('#Mensaje').empty();
    }
    var uniqueID = (new Date()).getTime();

    var elemSubMensaje = document.createElement("DIV");
    var xSubMensaje = "#" + String(uniqueID);
    var timeShow = 0;
    elemSubMensaje.id = String(uniqueID);
    elemSubMensaje.className = "Mensajes";
    elemMensaje.appendChild(elemSubMensaje);

    if (xMensaje != null)
    {
        if (xMensaje.indexOf("#info:") >= 0)
        {
            xMensaje = xMensaje.substring(xMensaje.indexOf("#info:") + 6, xMensaje.length);
            xMensaje = xMensaje.substring(0, xMensaje.lastIndexOf("[") - 1);
            xClass = "info";
        } else if (xMensaje.indexOf("#exito:") >= 0)
        {
            xMensaje = xMensaje.substring(xMensaje.indexOf("#exito:") + 7, xMensaje.length);
            xMensaje = xMensaje.substring(0, xMensaje.lastIndexOf("[") - 1);
            xClass = "exito";
        } else if (xMensaje.indexOf("#alerta:") >= 0)
        {
            xMensaje = xMensaje.substring(xMensaje.indexOf("#alerta:") + 8, xMensaje.length);
            xMensaje = xMensaje.substring(0, xMensaje.lastIndexOf("[") - 1);
            xClass = "alerta";
        }

        //Mostrar mensajes
        if (xClass == "exito")
        {
            timeShow = 2800;
        } else if (xClass == "info")
        {
            timeShow = 4000;
        } else if (xClass == "alerta")
        {
            timeShow = 4100;
        } else if (xClass == "error")
        {
            timeShow = 5000;
        } else
        {
            timeShow = 2000;
        }

        $(xSubMensaje).addClass(xClass).html(xMensaje).fadeIn().animate({right: 0, opacity: 1}, 500, function () {});
        setTimeout(function () {
            $(xSubMensaje).animate({right: -320, opacity: 0}, 500, function () {
                eliminarDivHijo(xSubMensaje);
            });
        }, timeShow);
    } else
    {
        $(xSubMensaje).addClass("error").html("null").fadeIn().animate({right: 0, opacity: 1}, 500, function () {});
        setTimeout(function () {
            $(xSubMensaje).animate({right: -320, opacity: 0}, 500, function () {
                eliminarDivHijo(xSubMensaje);
            });
        }, 4000);
    }
}

/**
 * Elimina el Div de Sub Mensaje
 * @param {String} xSubMensaje: Sub Mensaje
 */
function eliminarDivHijo(xSubMensaje)
{
    elemMensaje = document.getElementById('Mensaje');
    if (xSubMensaje != null)
    {
        xSubMensaje = xSubMensaje.substr(1, xSubMensaje.length);
        elemSubMensaje = document.getElementById(xSubMensaje);
        if (elemSubMensaje != null)
        {
            elemMensaje.removeChild(elemSubMensaje);
        }
    }
}

/**
 * Se encarga de remplazar los numeradores
 */
function replaceParametros(xParametros)
{
    xParametros = xParametros.replace('%', '%25');
    return xParametros;
}


//ENVIO DE MAILS
//-------------------------------------------------------------------
//-------------------------------------------------------------------
//-------------------------------------------------------------------
 $("#sendMessage").click(function () {

    var errors = "";

    var contact_name = document.getElementById("name");
    var contact_email_address = document.getElementById("email");
    var contact_phone = document.getElementById("phone");
    var contact_subject = document.getElementById("subject");
    var contact_msg = document.getElementById("comments");

    if (contact_name.value == "") {
        errors += 'Por favor ingrese su nombre.';
    } else if (contact_email_address.value == "") {
        errors += 'Por favor ingrese su direccion de correo.';
    } else if (contact_msg.value == "") {
        errors += 'Por favor escriba el mensaje.';
    }

    if (errors)
    {
        document.getElementById("message").style.display = "block";
        var element = document.getElementById("message");
        element.classList.add("error_message");
        document.getElementById("message").innerHTML = errors;

    } else {       
        document.getElementById("message").innerHTML = "";        
        javascript:cargaAjax('envioEmailSimple.jsp', 'contentEnvioMail', 
                '&xNombre=' + contact_name.value + 
                '&xMensaje=' + contact_msg.value + 
                '&xAsunto=' + contact_subject.value + 
                '&xTelefono=' + contact_phone.value + 
                '&xEmail=' + contact_email_address.value+
                '&xTipoEmail=M');
    }
});


$("#EnviarNewsLetter").click(function () {

    var errors = "";   
    var contact_email = document.getElementById("emailNewsletter");
    
    
    if (contact_email.value == "") {
        errors += 'Por favor ingrese su email.';
    }

    if (errors)
    {        
        document.getElementById("mensaje").style.display = "block";
        var element = document.getElementById("mensaje");
        element.classList.add("error_message");
        document.getElementById("mensaje").innerHTML = errors;
    } else {
//        document.getElementById("mensaje").innerHTML = "Mensaje enviado con exito!";
//        document.getElementById("emailNewsletter").value = "";
                
        javascript:cargaAjax('envioEmail.jsp', 'contentNewsletter', '&xEmail=' + contact_email.value + '&xTipoEmail=N');
    }
});

$("#EnviarCurriculum").click(function () {
   
    var errors = "";

    var contact_nombre = document.getElementById("nameCurriculum");
    var contact_apellido = document.getElementById("lastNameCurriculum");
    var contact_edad = document.getElementById("ageCurriculum");
    var contact_studios = document.getElementById("studiesCurriculum");
    var contact_trabajo = document.getElementById("workCurriculum");
    var contact_adjunto = document.getElementById("iUpload");

    if (contact_nombre.value == "") {
        errors += 'Por favor ingrese su nombre.';
    }else if(contact_apellido.value == ""){
        errors += 'Por favor ingrese su apellido.';
    }else if(contact_edad.value == ""){
        errors += 'Por favor ingrese su edad.';
    }else if(contact_studios.value == ""){
        errors += 'Por favor ingrese detalle breve de sus estudios.';
    }else if(contact_trabajo.value == ""){
        errors += 'Por favor seleccione si trabaja actualmente.';                
    }else if(contact_adjunto.value == ""){
        errors += 'Por favor ingrese curriculum.';                
    }

    if (errors)
    {        
        document.getElementById("message").style.display = "block";
        var element = document.getElementById("message");
        element.classList.add("error_message");
        document.getElementById("message").innerHTML = errors;
    } else {
        document.getElementById("message").innerHTML = "";
//        javascript:cargaAjax('envioCurriculum.jsp', 'contentEnvioMail', 
//                                '&xNombre=' + contact_nombre.value +
//                                '&xApellido=' + contact_apellido.value +
//                                '&xEdad=' + contact_edad.value +
//                                '&xEstudios=' + contact_studios.value +
//                                '&xTrabajo=' + contact_trabajo.value);                                                
         jQuery.ajax({
                url: "envioCurriculum.jsp?&xNombre=" + contact_nombre.value +
                                "&xApellido=" + contact_apellido.value +
                                "&xEdad=" + contact_edad.value +
                                "&xEstudios=" + contact_studios.value +
                                "&xTrabajo=" + contact_trabajo.value,
                type: "POST",
                contentType: false,
                processData: false,
                data: function () {
                    var data = new FormData();
                    data.append("iUpload", jQuery("#iUpload").get(0).files[0]);
                    return data;
                }(),
                error: function (_, textStatus, errorThrown) {
                    console.log(textStatus, errorThrown);
                },
                success: function (response) {
                    buscarScripts(response);
                }
            });                                                                                                                                                                        
    }
});

function itemMenu(item)
{
    $('#main-menu li .current').removeClass('current');
    $('#'+item).addClass('current');
}
