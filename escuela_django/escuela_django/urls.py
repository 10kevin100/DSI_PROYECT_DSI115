"""
URL configuration for escuela_django project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
#Anadiendo la clase include para usar la app core
from django.urls import path, include
from modulos.core.views import *
from modulos.Instructor.views import *
from modulos.Vehiculo.views import *
from modulos.usuario.views import *
from modulos.Mantenimiento.views import *
from modulos.encuesta.views import *
from modulos.alumno.views import *





urlpatterns = [
    path('admin/', admin.site.urls),
    #Incluyendo la app core en la ruta
    #path('', include('core.urls')),
    #Incluyendo accounts para iniciar sesion
    path('accounts/', include('django.contrib.auth.urls')),
    path('', home, name='home'),
    path('mision', mision, name='mision'),
    path('modules/', modules, name='modules'), 
    path('logout', sign_out, name='sign_out'), 
    #Modulo Usuario
    path('modules/usuarios/registrar_usuario/',registrar_usuario,name='registrar_usuario'),
    path('modules/usuarios/editar_usuario/<int:usuario_id>/<int:editar>',editar_usuario,name='editar_usuario'),
    path('modules/usuarios', listar_usuario, name='usuarios'),  
    path('modules/usuarios/eliminar_usuario/<int:usuario_id>', eliminar_usuario, name='eliminar_usuario'),
    path('modules/usuarios/cambiar_usuario/<int:usuario_id>', cambiar_usuario,name='cambiar_usuario'),   
    #Modulo Vehiculo
    path('homeVehiculo/', homeVehiculos, name='homeVehiculo'),
    path('registrarVehiculo/',registrarVehiculo,name='registrarVehiculo'),
    path('editarVehiculo/<int:vehiculo_id>',editarVehiculo,name=''),
    path('edicionVehiculo/',edicionVehiculo,name='edicionVehiculo'),
    path('eliminarVehiculo/<int:vehiculo_id>',eliminarVehiculo,name='eliminarVehiculo'),
    path('documento/',mkpdf,name='documento'),
    #Modulo Instructor
    path('modules/Instructor', lista_empleados, name='lista_empleados'),
    path('modules/asignarInstructor/<int:empleado_id>',asignarInstructor,name=''),
    path('modules/removerInstructor/<int:empleado_id>', removerInstructor, name=''),
    #Modulo Mantenimiento
    path('modules/registrarMantenimiento', registrar_mantenimiento, name='registrar_mantenimiento'),
    path('modules/mantenimiento/modificarMantenimiento/<int:mantenimiento_id>/<int:modificando>', modificar_mantenimiento, name='modificar_mantenimiento'),
    path('modules/mantenimientos', listar_mantenimiento, name="mantenimientos"),
    path('modules/listaMantenimiento', listaMantenimiento,name='listaMantenimiento'),
    #Modulo Encuesta
    path('encuesta/encuesta', llenar_encuesta, name='llenar_encuesta'),
    #Modulo Alumno
    path('homeAlumno/',homeAlumno,name='homeAlumno'),
    path('registrarAlumno/',ingresarAlumno,name='registrarAlumno'),
    path('busquedaAlumno/',filtroAlumno,name='busquedaAlumno'),
    path('edicionAlumno/',edicionAlumno,name='edicionAlumno'),
    path('editarAlumno/<int:alumno_id>',editarAlumno,name='editarAlumno'),
]