from django.shortcuts import render,redirect
from django.contrib import messages
from modulos.alumno.models import *

# Create your views here.

#Muestra la pagina principal y el listado segun el filtro

def homeAlumno(request):
    alumnos=Alumno.objects.all()

    return render(request,'alumno/listadoAlumno.html',{'alumnos':alumnos})

#Ingresa un alumno
def ingresarAlumno(request):
   
    if(request.method=='GET'):
        enviar=render(request,"alumno/ingresarAlumno.html")
    if(request.method=='POST'):
        #Se toman los datos del formulario
        nombre=request.POST.get("nombre")
        apellido=request.POST.get("apellido")
        telefono=request.POST.get("telefono")
        menorEdad=request.POST.get("menorEdad")
        tipo=request.POST.get("id")
        IdNum=request.POST.get("numId")
        licenciaTipo=request.POST.get("licencia")
        encargado=None
        alumnoNuevo=None
        enviar=None
        numerosIdentificaciones=[]
        
    
        #Verifica si es menor de edad para asignar un encargado
        if(int(menorEdad)==1):
            encargado=request.POST.get("encargado")
    
        #verificando que no exista el documento
        for documento in Documentoidentidad.objects.all():
            numerosIdentificaciones.append(documento.documento_num)
        try:
            if(IdNum not in numerosIdentificaciones):
                alumnoNuevo=Alumno.objects.create(alumno_nombre=nombre,alumno_apellido=apellido,alumno_telefono=telefono,alumno_encargado=encargado)
                Documentoidentidad.objects.create(alumno=alumnoNuevo,documento_tipo=tipo,documento_num=IdNum)
                licencia=Licencia.objects.get(licencia_id=int(licenciaTipo))
                AlumnoLicencia.objects.create(licencia=licencia,alumno=alumnoNuevo)
                messages.success(request,"El alumno se ha creado correctamente!")
                enviar=redirect("/homeAlumno/")
            else:
                messages.error(request,"El alumno ya posee una ficha!")
                enviar=redirect("/registrarAlumno/")
        except:
            messages.warning(request,"El alumno ya se encuentra registrado")


          
    return enviar

def editarAlumno(request,alumno_id):
    enviar=None
    alumno1=Alumno.objects.get(alumno_id=alumno_id)
    documentoAlumno=Documentoidentidad.objects.get(alumno=alumno1)
    licencia=AlumnoLicencia.objects.get(alumno=alumno1)
    licenciaRegistro=Licencia.objects.get(licencia_id=int(licencia.licencia.licencia_id))
    if(request.method=='GET'):
        enviar=render(request,'alumno/editarAlumno.html',{'alumno':alumno1,'documento':documentoAlumno,'licencia':licenciaRegistro.licencia_id})
    return enviar

def edicionAlumno(request):
    
    if(request.method=='POST'):
        nombre=request.POST.get('nombre')
        apellido=request.POST.get('apellido')
        telefono=request.POST.get('telefono')
        menorEdad=request.POST.get("menorEdad")
        encargado=request.POST.get("encargado")
        tipo=request.POST.get("id")
        IdNum=request.POST.get("numId")
        licenciaTipo=request.POST.get("licencia")
        alumno_id=request.POST.get('alumno_id')
        alumno1=Alumno.objects.get(alumno_id=alumno_id)
        documentoAlumno=Documentoidentidad.objects.get(alumno=alumno1)
        licencia=AlumnoLicencia.objects.get(alumno=alumno1)


        alumno1.alumno_nombre=nombre
        alumno1.alumno_apellido=apellido
        alumno1.alumno_telefono=telefono
        if(int(menorEdad)==1):
            alumno1.alumno_encargado=encargado
        else:
            alumno1.alumno_encargado=None
        nuevaLicencia=Licencia.objects.get(licencia_id=int(licenciaTipo))
        
        if licencia.alumno==alumno1:
            if(licencia.licencia!=nuevaLicencia):
                licencia.licencia=nuevaLicencia

        
        alumno1.save()
        licencia.save()

        messages.success(request,"La ficha se actualizo correctamente")
        enviar=redirect('/homeAlumno/')
    return enviar

def filtroAlumno(request):
    identificacion=request.POST.get("busquedaId")
    nombre=request.POST.get("busquedaNombre")
    apellido=request.POST.get("busquedaApellido")
    telefono=request.POST.get("busquedaTelefono")
    alumnosBusqueda=[]
    enviar=None

    try:
        if identificacion!="" or nombre!="" or apellido!="" or telefono!="":
            if identificacion!="":
                if Documentoidentidad.objects.filter(documento_num__icontains=identificacion).exists():
                    alumnosBusqueda.append(Alumno.objects.get(alumno_id=int(Documentoidentidad.objects.get(documento_num=identificacion).alumno.alumno_id)))
                    
            if telefono!="":
                if Alumno.objects.filter(alumno_telefono__icontains=telefono).exists():
                    for objeto in Alumno.objects.all():
                        if objeto.alumno_telefono==telefono:
                            alumnosBusqueda.append(objeto)

            if nombre!="" and apellido!="":
                if Alumno.objects.filter(alumno_nombre__icontains=nombre) and Alumno.objects.filter(alumno_apellido__icontains=apellido):
                    alumnosBusqueda=Alumno.objects.filter(alumno_nombre__icontains=nombre).union(Alumno.objects.filter(alumno_apellido__icontains=apellido))

            if nombre!="":
                if Alumno.objects.filter(alumno_nombre__icontains=nombre):
                     alumnosBusqueda=Alumno.objects.filter(alumno_nombre__icontains=nombre)
            if apellido!="":
                 if Alumno.objects.filter(alumno_apellido__icontains=apellido):
                     alumnosBusqueda=Alumno.objects.filter(alumno_apellido__icontains=apellido)
                     
            enviar=render(request,'alumno/listadoAlumno.html',{'alumnosBusqueda':alumnosBusqueda})
        else:
            messages.success(request,"Para encontrar a un alumno debe de escribir alguna información")
            enviar=redirect("/homeAlumno/")
    except:
        messages.error(request,"No hay resultados")
        enviar=redirect("/homeAlumno/")

    return enviar


    