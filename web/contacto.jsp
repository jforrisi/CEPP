<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%-- 
    Document   : contacto
    Created on : 02-sep-2024, 17:36:35
    Author     : Patricio Paulino
--%>



<jsp:include page="header.jsp"></jsp:include>


<section class="hero-area">
            <div class="hero-slider">
                <div class="slider-active">
                    <div class="single-slider slider-height d-flex align-items-center" data-background="assets/cepp/7.png">
                        <div class="container">
                            <div class="row">
                                <div class="col-xl-7 col-lg-8 col-md-10">
                                    <div class="hero-text" style="color: #FFF">
                                        <div class="hero-slider-caption ">
                                            <h1 data-animation="fadeInUp" data-delay=".4s" style="color: #FFF">Conect� con el CEPP</h1>
                                           <p data-animation="fadeInUp" data-delay=".6s" style="color: #FFF">En esta secci�n encontrar�s nuestras v�as de comunicaci�n: correo electr�nico, suscripci�n a newsletters y otros canales para mantenerte al d�a con las novedades del centro. Un espacio abierto para estar en contacto e intercambiar ideas.</p>
                                        </div>                                        
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- contact-form-area start -->
        <section class="contact-form-area gray-bg pt-100 pb-100">
            <div class="container">
                <div class="form-wrapper">
                    <div class="row justify-content-center">
                        <div class="col-xl-8 col-lg-8">
                            <div class="section-title text-center mb-55">
                                <h1>Contactanos</h1>
                            </div>
                        </div>
                    </div>
                    <div class="contact-form">
                        <!--<form id="contact-form" action="#">-->
                            <div class="row">
                                <div class="col-lg-6">
                                    <div class="form-box user-icon mb-30">
                                        <input type="text" name="name" id="name" placeholder="Nombre">
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="form-box email-icon mb-30">
                                        <input type="text" name="email" id="email" placeholder="Email">
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="form-box phone-icon mb-30">
                                        <input type="text" name="phone" id="phone" placeholder="Tel�fono">
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="form-box subject-icon mb-30">
                                        <input type="text" name="subject" id="subject" placeholder="Asunto">
                                    </div>
                                </div>
                                <div class="col-lg-12">
                                    <div class="form-box message-icon mb-30">
                                        <textarea name="message" id="comments" cols="30" rows="10"
                                            placeholder="Mensaje"></textarea>
                                    </div>
                                    <div class="contact-btn text-center">
                                        <div class="col-lg-12 col-md-12">
                                            <div id="message" ></div>
                                            <div id="contentEnvioMail"></div>
                                            <div id="Mensaje"></div>

                                        </div>
                                        <button class="bt-btn" id="sendMessage" style="background: #7B162C"> Enviar</button>
                                    </div>
                                </div>
                            </div>
                        <!--</form>-->
                        <p class="ajax-response text-center"></p>
                    </div>
                </div>
            </div>
        </section>
      

    
<jsp:include page="footer.jsp"></jsp:include>

