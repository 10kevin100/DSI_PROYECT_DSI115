from django.shortcuts import render, redirect
#importando sql connector para interactuar con la base
from .models import *
from django.contrib.auth.decorators import login_required
from django.contrib.auth.models import User
from django.http import HttpResponse
from django.contrib import messages
import random

# Create your views here.
#definiendo la view de registrar usuario

def crear_usuario(nombre, apellido):
   id=random.randint(0,999)
   usuario_nombre=nombre[0].lower() + apellido.lower() + str(id).zfill(3)
   return usuario_nombre

#Método editar usuario
@login_required
def editar_usuario(request,usuario_id,editar):
   #este if es para saber si es la primera consulta hecha por el usuario y va a rellenar el formulario
   if(editar==0):
      try: 
         usuario = Usuario.objects.get(usuario_id=usuario_id)
         empleado = Empleado.objects.get(usuario=usuario)
         instructor = None
         if(usuario.rol.rol_id==2):
            instructor = Instructor.objects.get(empleado_id=empleado)
         return render(request, 'usuario/editar_usuario.html/', {'usuario': usuario,'empleado':empleado,'instructor': instructor})
      except:
         messages.success(request,"Ha ocurrido un error, intentelo de nuevo")
         return redirect('usuarios')
   else:
      if(request.method=='POST'):
         #obteniendo los campos del forms
         rol = Rol.objects.get(rol_id=int(request.POST.get('usuario_rol',False)))
         nombre = request.POST.get('empleado_nombre',False)
         apellido = request.POST.get('empleado_apellido', False)
         telefono = request.POST.get('empleado_telefono', False)
         estado=request.POST.get('usuario_estado',False)
         try:
            #obteniendo el objeto usuario y empleado
            usuario_base = Usuario.objects.get(usuario_id=usuario_id)
            empleado_base = Empleado.objects.get(usuario=usuario_base)
            usuario_auth = User.objects.get(username=usuario_base.usuario_nombre)
            #Declarando instructor,vehiculo none para usarlo en el def
            instructor=None
            vehiculo=None
            #Controlando si el usuario era un instructor y asi destruir la instancia en la bd para continuar sin error
            if (usuario_base.rol.rol_id==2):
               instructor = Instructor.objects.get(empleado=empleado_base)
               #Controlando si el instructor posee un vehiculo aisgnado y asi destruir la instancia en la bd para continuar sin error
               for vehiculo in Vehiculo.objects.all():
                  if(vehiculo.instructor.instructor_id == instructor.instructor_id):
                     for mantenimiento in Mantenimiento.objects.all():
                        if mantenimiento.vehiculo == vehiculo:
                           mantenimiento.delete()
                     vehiculo.delete()                    
               instructor.delete()
            #Actualizando datos de usuario
            usuario_base.rol = rol
            usuario_base.usuario_estado = estado
            usuario_base.save()
         #Actualizando datos de empleado
            empleado_base.empleado_nombre = nombre
            empleado_base.empleado_apellido = apellido
            empleado_base.empleado_telefono = telefono
            empleado_base.save()
            #validando segun rol
            if int(request.POST.get('usuario_rol',False)) == 1:
               usuario_auth.is_superuser=1
               usuario_auth.save()
            elif int(request.POST.get('usuario_rol',False)) == 2:
               instructor = Instructor.objects.create(empleado=empleado_base)
               usuario_auth.is_superuser=0
               usuario_auth.save()
            else:
               usuario_auth.is_superuser=0
               usuario_auth.save()  
            messages.success(request,"Empleado: " + nombre.upper() + " " + apellido.upper() + ", se ha editado correctamente")
            return redirect('usuarios')
         except:
            messages.success(request,"Ha ocurrido un error editando el usuario, intentelo de nuevo")
            return render(request, 'usuario/editar_usuario.html/', {'usuario': usuario,'empleado':empleado,'instructor': instructor}) 

 
 

@login_required
def eliminar_usuario(request,usuario_id):
   try:
      #declarando los objetos usuario, usuario_auth, empleado, instructor, vehiculo para eliminar
      usuario = Usuario.objects.get(usuario_id=usuario_id)
      usuario_auth = User.objects.get(username=usuario.usuario_nombre)
      empleado= Empleado.objects.get(usuario = usuario)
      nombre = empleado.empleado_nombre
      apellido = empleado.empleado_apellido
      instructor=None
      vehiculo=None
      if (usuario.rol.rol_id==2):
         instructor = Instructor.objects.get(empleado=empleado)
         #Controlando si el instructor posee un vehiculo aisgnado y asi destruir la instancia en la bd para continuar sin error
         for vehiculo in Vehiculo.objects.all():
            if(vehiculo.instructor.instructor_id == instructor.instructor_id):
               for mantenimiento in Mantenimiento.objects.all():
                  if mantenimiento.vehiculo == vehiculo:
                     mantenimiento.delete()
               vehiculo.delete()                       
         instructor.delete()
      empleado.delete()
      usuario_auth.delete()
      usuario.delete()
      messages.success(request,"Empleado: " + nombre.upper() + " " + apellido.upper() + ", se ha eliminado correctamente")
      return redirect('usuarios')
   except:
      messages.success(request,"Ha ocurrido un error eliminando el usuario, intentelo de nuevo")
      return redirect('usuarios')


@login_required
def cambiar_usuario(request,usuario_id):
   usuario = Usuario.objects.get(usuario_id = usuario_id)
   usuario.usuario_estado = not usuario.usuario_estado 
   usuario.save()
   messages.success(request,'Se ha cambiado el estado correctamente')
   return redirect('usuarios') 

@login_required
def registrar_usuario(request):
      #Evaluando si es un get o post
   if(request.method == 'POST'):
      #Manejando excepciones
      #Obteniendo el rol
      rol = Rol.objects.get(rol_id=int(request.POST.get('usuario_rol',False))) 
      #Obteniendo el nombre 
      nombre = request.POST.get('empleado_nombre',False)
      nombre_= request.POST.get('empleado_nombre',False)
      #Obteniendo el apellido 
      apellido = request.POST.get('empleado_apellido', False)
      #Obteniendo el telefono 
      telefono = request.POST.get('empleado_telefono', False)
      #Obteniendo la contra
      contrasena = request.POST.get('usuario_contrasena',False)
      #Obteniendo el estado
      estado=request.POST.get('usuario_estado',False)
      #Obteniendo correo
      correo=request.POST['empleado_correo']
      #Creando el nombre del usuario
      usuario_nombre=crear_usuario(nombre,apellido)
      try:
         #Creando el usuario en la bd
         usuario_base = Usuario.objects.create(rol=rol,usuario_nombre = usuario_nombre, correo=correo, usuario_estado=estado)
         #creando el empleado en la bd
         empleado_base = Empleado.objects.create(usuario=usuario_base,empleado_nombre=nombre, empleado_apellido=apellido,empleado_telefono=telefono) 
         
         #Eligiendo rol para el empleado y creando el usuario en django
         if int(request.POST.get('usuario_rol',False)) == 1:
            usuario_auth = User.objects.create_superuser(username=usuario_nombre, password=contrasena, email=correo)
         elif int(request.POST.get('usuario_rol',False)) == 2:
            usuario_auth = User.objects.create_user(username=usuario_nombre, password=contrasena, email=correo)
            #creando el instructor 
            instructor_ = Instructor.objects.create(empleado=empleado_base)
         else:
            usuario_auth = User.objects.create_user(username=usuario_nombre, password=contrasena, email=correo)
         messages.success(request,"Empleado: " + nombre.upper() + " " + apellido.upper() + ", se ha registrado correctamente")
         return redirect('usuarios')
      #Capturando el error e informando al usuario
      except:
         messages.success(request,"Ha ocurrido un error registrando el usuario, intentelo de nuevo")
         return render(request,'usuario/registrar_usuario.html')
      
   else:
      return render(request,'usuario/registrar_usuario.html')


@login_required
def listar_usuario(request):
    #Declarando variables
    empleados=[]
    usuarios=[]
    busqueda=False
    #Evaluando si hay una entrada de busqueda
    if request.method == "POST":
      #capturando entrada de busqueda
      search_query = request.POST['txt_buscar']
      #evaluando si es consulta con el nombre y apellido de empelado
      if search_query != "":
         if Empleado.objects.filter(empleado_nombre__icontains=search_query).exists() or Empleado.objects.filter(empleado_apellido__icontains = search_query).exists():
            #Capturando los empleados que coinciden con la busqueda
            empleados = Empleado.objects.filter(empleado_apellido__icontains = search_query).union(Empleado.objects.filter(empleado_nombre__icontains = search_query))
            #capturando cada uno de los usuarios
            for empleado in empleados:
               usuarios.append(Usuario.objects.get(usuario_id = empleado.usuario.usuario_id))
         #evaluando si es consulta con el usuario de empelado
         elif Usuario.objects.filter(usuario_nombre__icontains=search_query).exists() or Usuario.objects.filter(usuario_estado__icontains = search_query).exists():
            #Capturando los usuarios que coinciden con la busqueda
            usuarios = Usuario.objects.filter(usuario_nombre__icontains=search_query).union(Usuario.objects.filter(usuario_estado__icontains=search_query))
            #capturando cada uno de los empleados
            for usuario in usuarios:
               empleados.append(Empleado.objects.get(usuario=usuario))
      else:
         #Mostrando mensaje si no hay coincidencia
         messages.success(request,"No hay resultados")
      #true due to query 
      busqueda=True
    else: 
      empleados = Empleado.objects.all()
      usuarios = Usuario.objects.all()
    
    return render(request, 'usuario/usuarios.html', {'empleados': empleados,'usuarios':usuarios,'busqueda': busqueda})