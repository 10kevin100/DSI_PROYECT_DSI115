from django.shortcuts import render,redirect,HttpResponse
from .models import Vehiculo
from modulos.Instructor.models import Instructor
from django.contrib import messages
import pdfkit



# Create your views here.

def homeVehiculos(request):
   listaVehiculos=Vehiculo.objects.all()
   listaInstructores=Instructor.objects.all()
   
   return render(request,'Vehiculos/gestioVehiculos.html',{'listaVehiculos':listaVehiculos,'listaInstructor':listaInstructores})

def registrarVehiculo(request):

   if(request.method=='GET'):
      listaInstructores=Instructor.objects.all()
      enviar=render(request,'Vehiculos/registrarVehiculo.html',{'listaInstructor':listaInstructores})

   if(request.method=='POST'):
   #Obteniendo datos#
      placa=request.POST['vehiculo_placa']
      marca=request.POST['vehiculo_marca']
      tipo=request.POST['vehiculo_tipo']
      transmision=request.POST['vehiculo_transmision']
      instructor1=Instructor.objects.get(instructor_id=int(request.POST['instructor']))
      bandera=False

      try:
         for vehiculo in Vehiculo.objects.all():
            if(vehiculo.instructor==instructor1):
               messages.success(request,"El instructor ya esta asignado a un vehiculo")
               bandera=False
               break
            else:
               bandera=True
      

         if(bandera):
            vehiculo=Vehiculo.objects.create(vehiculo_placa=placa,vehiculo_marca=marca,vehiculo_tipo=tipo,vehiculo_transmision=transmision,instructor=instructor1)
            messages.success(request,"El vehiculo placa: " + vehiculo.vehiculo_placa + " y marca: " + vehiculo.vehiculo_marca + " Se ha registrado correctamente!!")
      
      except:
         messages.error(request,"EL vehiculo ya ha sido registrado")
      enviar=redirect('/homeVehiculo/')

   return enviar

def editarVehiculo(request,vehiculo_id):
   vehiculo=Vehiculo.objects.get(vehiculo_id=vehiculo_id)
   listaInstructores=Instructor.objects.all()
   listaNoSeleccionada=[]
   vehiculos=Vehiculo.objects.all()
   listaIntermedia=[]

  
#Haciendo una lista de los instructores que aun no tienen carro vinculado

   for carro in vehiculos:
      listaNoSeleccionada.append(carro.instructor)
      for instructor in listaInstructores:
        if(carro==vehiculo):
           if(carro.instructor==instructor):
              listaIntermedia.append(instructor)

   for instructor in listaInstructores:
      if(instructor not in listaNoSeleccionada):
         listaIntermedia.append(instructor)

           
          
   return render(request,'Vehiculos/editarVehiculo.html',{'vehiculo':vehiculo,'listaInstructor':listaIntermedia})

def edicionVehiculo(request):
   
   idVehiculo=request.POST['vehiculo_id']
   placa=request.POST['vehiculo_placa']
   marca=request.POST['vehiculo_marca']
   tipo=request.POST['vehiculo_tipo']
   transmision=request.POST['vehiculo_transmision']
   instructor1=Instructor.objects.get(instructor_id=int(request.POST['instructor']))
   vehiculo=Vehiculo.objects.get(vehiculo_id=idVehiculo)
   enviar=redirect('/homeVehiculo/')
   
   try:
      vehiculo.vehiculo_marca=marca
      vehiculo.vehiculo_placa=placa
      vehiculo.vehiculo_tipo=tipo
      vehiculo.vehiculo_transmision=transmision
      vehiculo.instructor=instructor1
      vehiculo.save()
      messages.success(request,"El vehiculo se ha editado correctamente!")

   except:
      messages.success(request,"La placa ya fue registrada")

   return enviar

def eliminarVehiculo(request,vehiculo_id):
   vehiculo=Vehiculo.objects.get(vehiculo_id=vehiculo_id)
   vehiculo.delete()
   messages.success(request,"El vehiculo placa "+vehiculo.vehiculo_placa + " y marca: " + vehiculo.vehiculo_marca + " ha sido eliminado!")

   return redirect('/homeVehiculo/')




def mkpdf(request):
   
   options={
      'page-size': 'Letter',
      'margin-top': '1in',
      'margin-right': '1.75in',
      'margin-bottom': '1.75in',
      'margin-left': '1.75in',
      'encoding': "UTF-8"
   }

  
   pdf=pdfkit.from_url('',False,options=options)
   
   response = HttpResponse(pdf,content_type='application/pdf')
   response['Content-Disposition'] = 'attachment; filename="ListadoVehiculos.pdf"'

   return response

  
